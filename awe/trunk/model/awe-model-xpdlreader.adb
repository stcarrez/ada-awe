-----------------------------------------------------------------------
--  model -- Generic name/value property management
--  Copyright (C) 2003, 2004, 2005 Free Software Foundation, Inc.
--  Written by Stephane Carrez (stcarrez@nerim.fr)
--
--  This file is part of AWE.
--
--  This program is free software; you can redistribute it and/or
--  modify it under the terms of the GNU General Public License as
--  published by the Free Software Foundation; either version 2,
--  or (at your option) any later version.
--
--  This program is distributed in the hope that it will be useful,
--  but WITHOUT ANY WARRANTY; without even the implied warranty of
--  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
--  GNU General Public License for more details.
--
--  You should have received a copy of the GNU General Public License
--  along with this program; see the file COPYING.  If not, write to
--  the Free Software Foundation, 59 Temple Place - Suite 330,
--  Boston, MA 02111-1307, USA.
-----------------------------------------------------------------------
with Ada.Text_IO;    use Ada.Text_IO;
with Ada.Strings.Unbounded;  use Ada.Strings.Unbounded;
with Sax.Readers;    use Sax.Readers;
with Sax.Exceptions; use Sax.Exceptions;
with Sax.Locators;   use Sax.Locators;
with Sax.Attributes; use Sax.Attributes;
with Sax.Models;     use Sax.Models;
with Unicode.CES;    use Unicode.CES;
with Unicode;        use Unicode;
with Sax.Encodings;  use Sax.Encodings;
with GNAT.Dynamic_Tables;

with AWE.Model.Root;                  use AWE.Model.Root;
with AWE.Model.Root.Internal;         use AWE.Model.Root.Internal;

with AWE.Model.Attributes;            use AWE.Model.Attributes;
with AWE.Model.Attributes.Internal;   use AWE.Model.Attributes.Internal;

with AWE.Model.Participant;   use AWE.Model.Participant;
with AWE.Model.Participant.Internal; use AWE.Model.Participant.Internal;

with AWE.Model.Applications;          use AWE.Model.Applications;

with AWE.Model.XPDL;  use AWE.Model.XPDL;
package body AWE.Model.XpdlReader is

   ----------------
   -- Set_Silent --
   ----------------

   procedure Set_Silent
     (Handler : in out XPDL_Reader; Silent : Boolean) is
   begin
      Handler.Silent := Silent;
   end Set_Silent;

   -------------
   -- Warning --
   -------------

   procedure Warning
     (Handler : in out XPDL_Reader;
      Except : Sax.Exceptions.Sax_Parse_Exception'Class)
   is
     pragma Warnings (Off, Handler);
   begin
      Put_Line ("Sax.Warning ("
                & Get_Message (Except) & ", at "
                & To_String (Get_Locator (Except)) & ')');
   end Warning;

   -----------
   -- Error --
   -----------

   procedure Error
     (Handler : in out XPDL_Reader;
      Except  : Sax.Exceptions.Sax_Parse_Exception'Class)
   is
      pragma Warnings (Off, Handler);
   begin
      Put_Line ("Sax.Error ("
                & Get_Message (Except) & ", at "
                & To_String (Get_Locator (Except)) & ')');
   end Error;

   -----------------
   -- Fatal_Error --
   -----------------

   procedure Fatal_Error
     (Handler : in out XPDL_Reader;
      Except  : Sax.Exceptions.Sax_Parse_Exception'Class) is
   begin
      Put_Line ("Sax.Fatal_Error (" & Get_Message (Except) & ')');
      Fatal_Error (Reader (Handler), Except);
   end Fatal_Error;

   --------------------------
   -- Set_Document_Locator --
   --------------------------

   procedure Set_Document_Locator
     (Handler : in out XPDL_Reader;
      Loc     : access Sax.Locators.Locator'Class) is
   begin
      if not Handler.Silent then
         Put_Line ("Sax.Set_Document_Locator ()");
      end if;
      Handler.Locator := Locator_Access (Loc);
   end Set_Document_Locator;

   --------------------
   -- Start_Document --
   --------------------

   procedure Start_Document (Handler : in out XPDL_Reader) is
   begin
      if not Handler.Silent then
         Put_Line ("Sax.Start_Document ()");
      end if;
      AWE.Model.Attributes.Internal.Init (Handler.ExtAttributes);
      Init (Handler.Participants);
      Delete (Handler.Content, 1, Length (Handler.Content));
   end Start_Document;

   ------------------
   -- End_Document --
   ------------------

   procedure End_Document (Handler : in out XPDL_Reader) is
      Cnt : Natural;
      P : Participant_Table_Access;
   begin
      if not Handler.Silent then
         Put_Line ("Sax.End_Document ()");
      end if;
      Cnt := Length (Handler.ExtAttributes);
      Put_Line ("Got " & Natural'Image (Cnt));
      Cnt := Length (Handler.Content);
      Put_Line ("Content length " & Natural'Image (Cnt));
      Put_Line ("Content: " & To_String (Handler.Content));
      P := Get_Participant_Table (Handler.Participants);
      if P = null then
         Put_Line ("No participant");
      else
         for I in P.all'Range loop
            Print (P.all (I).all);
         end loop;
      end if;
   end End_Document;

   --------------------------
   -- Start_Prefix_Mapping --
   --------------------------

   procedure Start_Prefix_Mapping
     (Handler : in out XPDL_Reader;
      Prefix  : Unicode.CES.Byte_Sequence;
      URI     : Unicode.CES.Byte_Sequence) is
   begin
      if not Handler.Silent then
         Put_Line ("Sax.Start_Prefix_Mapping (" & Prefix & ", " & URI & ")");
      end if;
   end Start_Prefix_Mapping;

   ------------------------
   -- End_Prefix_Mapping --
   ------------------------

   procedure End_Prefix_Mapping
     (Handler : in out XPDL_Reader; Prefix : Unicode.CES.Byte_Sequence) is
   begin
      if not Handler.Silent then
         Put_Line ("Sax.End_Prefix_Mapping (" & Prefix & ") at "
                   & To_String (Handler.Locator.all));
      end if;
   end End_Prefix_Mapping;

   -------------------
   -- Start_Element --
   -------------------

   function Get_Attribute (Handler : in XPDL_Reader;
                           Atts    : in Sax.Attributes.Attributes'Class;
                           Name    : in String) return String_Ptr is
      Pos : Integer := Get_Index (Atts, Name);
   begin
      if Pos < 0 then
         Put_Line (To_String (Handler.Locator.all)
                   & ": missing attribute '" & Name & "'");
         return null;
      end if;
      return new String '(Get_Value (Atts, Pos));
   end Get_Attribute;

   procedure Start_Element
     (Handler       : in out XPDL_Reader;
      Namespace_URI : Unicode.CES.Byte_Sequence := "";
      Local_Name    : Unicode.CES.Byte_Sequence := "";
      Qname         : Unicode.CES.Byte_Sequence := "";
      Atts          : Sax.Attributes.Attributes'Class) is
      Id   : String_Ptr;
      Name : String_Ptr;
      Index : String_Ptr;
      Mode : String_Ptr;
   begin
      --  Collect the extended attributes in the list
      if Qname = XPDL_EXTENDED_ATTRIBUTE then
         Append (Handler.ExtAttributes,
                 Create_Attribute (Get_Attribute (Handler, Atts,
                                                  XPDL_ATTR_NAME),
                                   Get_Attribute (Handler, Atts,
                                                  XPDL_ATTR_VALUE)));

         --  Start a new group of extended attributes
      elsif Qname = XPDL_EXTENDED_ATTRIBUTES then
         Init (Handler.ExtAttributes);

      elsif Qname = XPDL_PARTICIPANT then
         Id := Get_Attribute (Handler, Atts, XPDL_ATTR_ID);
         Name := Get_Attribute (Handler, Atts, XPDL_ATTR_NAME);

         Handler.Participant := Create_Participant (Id, Name);
         Handler.Current := Root_Definition_Access (Handler.Participant);
         Append (Handler.Participants, Handler.Participant);

      elsif Qname = XPDL_PARTICIPANT_TYPE then
         Id := Get_Attribute (Handler, Atts, XPDL_ATTR_TYPE);
         if Id = null then
            null;
         elsif Id.all = "ROLE" then
            Set_Participant_Type (Handler.Participant.all, ACTOR_ROLE);
         elsif Id.all = "SYSTEM" then
            Set_Participant_Type (Handler.Participant.all, ACTOR_SYSTEM);
         end if;

      elsif Qname = XPDL_PARTICIPANTS then
         --  Init (Handler.Participants);
         null;

      elsif Qname = XPDL_DESCRIPTION
        or Qname = XPDL_PERFORMER
        or Qname = XPDL_ACTUAL_PARAMETER then
         Delete (Handler.Content, 1, Length (Handler.Content));

      elsif Qname = XPDL_FORMAL_PARAMETER then
         Id := Get_Attribute (Handler, Atts, XPDL_ATTR_ID);
         Index := Get_Attribute (Handler, Atts, XPDL_ATTR_INDEX);
         Mode := Get_Attribute (Handler, Atts, XPDL_ATTR_MODE);
         --  Handler.Parameter := Create_Parameter (Id, Index, Mode);

      else
      if not Handler.Silent then
         Put ("Sax.Start_Element ("
              & Local_Name & ", " & Qname);
         for J in 0 .. Get_Length (Atts) - 1 loop
            Put (", " & Get_Qname (Atts, J) & "='"
                 & Get_Value (Atts, J) & ''');
         end loop;
         Put_Line (") at " & To_String (Handler.Locator.all));
      end if;
      end if;
   end Start_Element;

   function Get_Content (Handler : in XPDL_Reader) return String_Ptr;

   function Get_Content (Handler : in XPDL_Reader) return String_Ptr is
   begin
      if Length (Handler.Content) = 0 then
         return null;
      else
         return new String '(To_String (Handler.Content));
      end if;
   end Get_Content;

   -----------------
   -- End_Element --
   -----------------

   procedure End_Element
     (Handler : in out XPDL_Reader;
      Namespace_URI : Unicode.CES.Byte_Sequence := "";
      Local_Name    : Unicode.CES.Byte_Sequence := "";
      Qname         : Unicode.CES.Byte_Sequence := "") is
   begin
      if Qname /= XPDL_EXTENDED_ATTRIBUTES
        and Qname /= XPDL_EXTENDED_ATTRIBUTE then
         if not Handler.Silent then
            Put_Line ("Sax.End_Element ("
                      & Local_Name & ", " & Qname & ") at "
                      & To_String (Handler.Locator.all));
         end if;
      end if;

      --  Save the list of attributes in the current model element
      if Qname = XPDL_EXTENDED_ATTRIBUTES then
         if Handler.Current /= null then
            Set_Attributes (Handler.Current.all,
                            Get_Attribute_Table (Handler.ExtAttributes));
         end if;
      end if;

      --  Save the description content in the current model object.
      if Qname = XPDL_DESCRIPTION then
         if Handler.Current /= null then
            Set_Description (Handler.Current.all, Get_Content (Handler));
         end if;

      elsif Qname = XPDL_PARTICIPANT then
         null;
      end if;
   end End_Element;

   ----------------
   -- Characters --
   ----------------

   procedure Characters
     (Handler : in out XPDL_Reader; Ch : Unicode.CES.Byte_Sequence) is
   begin
      if not Handler.Silent then
         Put_Line ("Sax.Characters (" & Ch & ','
                   & Integer'Image (Ch'Length) & ") at "
                   & To_String (Handler.Locator.all));
      end if;
      Append (Handler.Content, Ch);
   end Characters;

   --------------------------
   -- Ignorable_Whitespace --
   --------------------------

   procedure Ignorable_Whitespace
     (Handler : in out XPDL_Reader; Ch : Unicode.CES.Byte_Sequence)
   is
      Index : Natural := Ch'First;
      C : Unicode_Char;
   begin
      if not Handler.Silent then
         Put ("Sax.Ignorable_Whitespace (");
         while Index <= Ch'Last loop
            Encoding.Read (Ch, Index, C);
            Put (Unicode_Char'Image (C));
         end loop;
         Put_Line (','
                   & Integer'Image (Ch'Length) & ") at "
                   & To_String (Handler.Locator.all));
      end if;
      Append (Handler.Content, Ch);
   end Ignorable_Whitespace;

   ----------------------------
   -- Processing_Instruction --
   ----------------------------

   procedure Processing_Instruction
     (Handler : in out XPDL_Reader;
      Target  : Unicode.CES.Byte_Sequence;
      Data    : Unicode.CES.Byte_Sequence) is
   begin
      if not Handler.Silent then
         Put_Line ("Sax.Processing instruction (" & Target & ", '" & Data
                   & "') at " & To_String (Handler.Locator.all));
      end if;
   end Processing_Instruction;

   --------------------
   -- Skipped_Entity --
   --------------------

   procedure Skipped_Entity
     (Handler : in out XPDL_Reader; Name : Unicode.CES.Byte_Sequence) is
   begin
      if not Handler.Silent then
         Put_Line ("Sax.Skipped_Entity (" & Name & ") at "
                   & To_String (Handler.Locator.all));
      end if;
   end Skipped_Entity;

   -------------
   -- Comment --
   -------------

   procedure Comment
     (Handler : in out XPDL_Reader; Ch : Unicode.CES.Byte_Sequence) is
   begin
      if not Handler.Silent then
         Put_Line ("Sax.Comment (" & Ch & ") at "
                   & To_String (Handler.Locator.all));
      end if;
   end Comment;

   -----------------
   -- Start_Cdata --
   -----------------

   procedure Start_Cdata (Handler : in out XPDL_Reader) is
   begin
      if not Handler.Silent then
         Put_Line ("Sax.Start_Cdata () at " & To_String (Handler.Locator.all));
      end if;
   end Start_Cdata;

   ---------------
   -- End_Cdata --
   ---------------

   procedure End_Cdata (Handler : in out XPDL_Reader) is
   begin
      if not Handler.Silent then
         Put_Line ("Sax.End_Cdata () at " & To_String (Handler.Locator.all));
      end if;
   end End_Cdata;

   ------------------
   -- Start_Entity --
   ------------------

   procedure Start_Entity
     (Handler : in out XPDL_Reader; Name : Unicode.CES.Byte_Sequence) is
   begin
      if not Handler.Silent then
         Put_Line ("Sax.Start_Entity (" & Name & ") at "
                   & To_String (Handler.Locator.all));
      end if;
   end Start_Entity;

   ----------------
   -- End_Entity --
   ----------------

   procedure End_Entity
     (Handler : in out XPDL_Reader; Name : Unicode.CES.Byte_Sequence) is
   begin
      if not Handler.Silent then
         Put_Line ("Sax.End_Entity (" & Name & ") at "
                   & To_String (Handler.Locator.all));
      end if;
   end End_Entity;

   ---------------
   -- Start_DTD --
   ---------------

   procedure Start_DTD
     (Handler   : in out XPDL_Reader;
      Name      : Unicode.CES.Byte_Sequence;
      Public_Id : Unicode.CES.Byte_Sequence := "";
      System_Id : Unicode.CES.Byte_Sequence := "") is
   begin
      if not Handler.Silent then
         Put_Line ("Sax.Start_DTD (" & Name
                   & ", " & Public_Id
                   & ", " & System_Id & ") at "
                   & To_String (Handler.Locator.all));
      end if;
   end Start_DTD;

   -------------
   -- End_DTD --
   -------------

   procedure End_DTD (Handler : in out XPDL_Reader) is
   begin
      if not Handler.Silent then
         Put_Line ("Sax.End_DTD () at " & To_String (Handler.Locator.all));
      end if;
   end End_DTD;

   --------------------------
   -- Internal_Entity_Decl --
   --------------------------

   procedure Internal_Entity_Decl
     (Handler : in out XPDL_Reader;
      Name    : Unicode.CES.Byte_Sequence;
      Value   : Unicode.CES.Byte_Sequence) is
   begin
      if not Handler.Silent then
         Put_Line ("Sax.Internal_Entity_Decl ("
                   & Name & ", " & Value
                   & ") at " & To_String (Handler.Locator.all));
      end if;
   end Internal_Entity_Decl;

   --------------------------
   -- External_Entity_Decl --
   --------------------------

   procedure External_Entity_Decl
     (Handler   : in out XPDL_Reader;
      Name      : Unicode.CES.Byte_Sequence;
      Public_Id : Unicode.CES.Byte_Sequence;
      System_Id : Unicode.CES.Byte_Sequence) is
   begin
      if not Handler.Silent then
         Put_Line ("Sax.External_Entity_Decl ("
                   & Name & ", " & Public_Id
                   & ", " & System_Id
                   & ") at " & To_String (Handler.Locator.all));
      end if;
   end External_Entity_Decl;

   --------------------------
   -- Unparsed_Entity_Decl --
   --------------------------

   procedure Unparsed_Entity_Decl
     (Handler       : in out XPDL_Reader;
      Name          : Unicode.CES.Byte_Sequence;
      System_Id     : Unicode.CES.Byte_Sequence;
      Notation_Name : Unicode.CES.Byte_Sequence) is
   begin
      if not Handler.Silent then
         Put_Line ("Sax.Unparsed_Entity_Decl ("
                   & Name & ", " & System_Id
                   & ", " & Notation_Name
                   & ") at " & To_String (Handler.Locator.all));
      end if;
   end Unparsed_Entity_Decl;

   ------------------
   -- Element_Decl --
   ------------------

   procedure Element_Decl
     (Handler : in out XPDL_Reader;
      Name    : Unicode.CES.Byte_Sequence;
      Model   : Element_Model_Ptr) is
   begin
      if not Handler.Silent then
         Put_Line ("Sax.Element_Decl ("
                   & Name & ", " & To_String (Model.all)
                   & ") at " & To_String (Handler.Locator.all));
      end if;
   end Element_Decl;

   -------------------
   -- Notation_Decl --
   -------------------

   procedure Notation_Decl
     (Handler       : in out XPDL_Reader;
      Name          : Unicode.CES.Byte_Sequence;
      Public_Id     : Unicode.CES.Byte_Sequence;
      System_Id     : Unicode.CES.Byte_Sequence) is
   begin
      if not Handler.Silent then
         Put_Line ("Sax.Notation_Decl ("
                   & Name & ", " & Public_Id
                   & ", " & System_Id & ") at "
                   & To_String (Handler.Locator.all));
      end if;
   end Notation_Decl;

   --------------------
   -- Attribute_Decl --
   --------------------

   procedure Attribute_Decl
     (Handler : in out XPDL_Reader;
      Ename   : Unicode.CES.Byte_Sequence;
      Aname   : Unicode.CES.Byte_Sequence;
      Typ     : Attribute_Type;
      Content : Element_Model_Ptr;
      Value_Default : Sax.Attributes.Default_Declaration;
      Value   : Unicode.CES.Byte_Sequence) is
   begin
      if not Handler.Silent then
         if Content /= null then
            Put_Line ("Sax.Attribute_Decl ("
                      & Ename & ", " & Aname
                      & ", " & Attribute_Type'Image (Typ) & ", "
                      & To_String (Content.all) & ", "
                      & Default_Declaration'Image (Value_Default)
                      & ", " & Value & ")");
         else
            Put_Line ("Sax.Attribute_Decl ("
                      & Ename & ", " & Aname
                      & ", " & Attribute_Type'Image (Typ) & ", "
                      & Default_Declaration'Image (Value_Default)
                      & ", " & Value & ")");
         end if;
      end if;
   end Attribute_Decl;

end AWE.Model.XpdlReader;

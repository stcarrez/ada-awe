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
with Sax.Exceptions;
with Sax.Locators;
with Sax.Readers;
with Sax.Attributes;
with Sax.Models;
with Unicode.CES;
with GNAT.Dynamic_Tables;

with AWE.Model.Root;         use AWE.Model.Root;
with AWE.Model.Attributes;   use AWE.Model.Attributes;
with AWE.Model.Participant;  use AWE.Model.Participant;

with AWE.Model.Attributes.Internal;
with AWE.Model.Participant.Internal;

with Ada.Strings.Unbounded;

package AWE.Model.XpdlReader is

   type XPDL_Reader is new Sax.Readers.Reader with private;

   procedure Set_Silent
     (Handler : in out XPDL_Reader; Silent : Boolean);
   --  If Silent is True, then nothing will be output on the console, except
   --  error messages

   procedure Warning
     (Handler : in out XPDL_Reader;
      Except : Sax.Exceptions.Sax_Parse_Exception'Class);
   procedure Error
     (Handler : in out XPDL_Reader;
      Except  : Sax.Exceptions.Sax_Parse_Exception'Class);
   procedure Fatal_Error
     (Handler : in out XPDL_Reader;
      Except  : Sax.Exceptions.Sax_Parse_Exception'Class);
   procedure Set_Document_Locator
     (Handler : in out XPDL_Reader;
      Loc     : access Sax.Locators.Locator'Class);
   procedure Start_Document (Handler : in out XPDL_Reader);
   procedure End_Document (Handler : in out XPDL_Reader);
   procedure Start_Prefix_Mapping
     (Handler : in out XPDL_Reader;
      Prefix  : Unicode.CES.Byte_Sequence;
      URI     : Unicode.CES.Byte_Sequence);
   procedure End_Prefix_Mapping
     (Handler : in out XPDL_Reader;
      Prefix  : Unicode.CES.Byte_Sequence);
   procedure Start_Element
     (Handler       : in out XPDL_Reader;
      Namespace_URI : Unicode.CES.Byte_Sequence := "";
      Local_Name    : Unicode.CES.Byte_Sequence := "";
      Qname         : Unicode.CES.Byte_Sequence := "";
      Atts          : Sax.Attributes.Attributes'Class);
   procedure End_Element
     (Handler : in out XPDL_Reader;
      Namespace_URI : Unicode.CES.Byte_Sequence := "";
      Local_Name    : Unicode.CES.Byte_Sequence := "";
      Qname         : Unicode.CES.Byte_Sequence := "");
   procedure Characters
     (Handler : in out XPDL_Reader; Ch : Unicode.CES.Byte_Sequence);
   procedure Ignorable_Whitespace
     (Handler : in out XPDL_Reader; Ch : Unicode.CES.Byte_Sequence);
   procedure Processing_Instruction
     (Handler : in out XPDL_Reader;
      Target  : Unicode.CES.Byte_Sequence;
      Data    : Unicode.CES.Byte_Sequence);
   procedure Skipped_Entity
     (Handler : in out XPDL_Reader; Name : Unicode.CES.Byte_Sequence);
   procedure Comment
     (Handler : in out XPDL_Reader; Ch : Unicode.CES.Byte_Sequence);
   procedure Start_Cdata (Handler : in out XPDL_Reader);
   procedure End_Cdata (Handler : in out XPDL_Reader);
   procedure Start_Entity
     (Handler : in out XPDL_Reader; Name : Unicode.CES.Byte_Sequence);
   procedure End_Entity
     (Handler : in out XPDL_Reader; Name : Unicode.CES.Byte_Sequence);
   procedure Start_DTD
     (Handler   : in out XPDL_Reader;
      Name      : Unicode.CES.Byte_Sequence;
      Public_Id : Unicode.CES.Byte_Sequence := "";
      System_Id : Unicode.CES.Byte_Sequence := "");
   procedure End_DTD (Handler : in out XPDL_Reader);
   procedure Internal_Entity_Decl
     (Handler : in out XPDL_Reader;
      Name    : Unicode.CES.Byte_Sequence;
      Value   : Unicode.CES.Byte_Sequence);
   procedure External_Entity_Decl
     (Handler   : in out XPDL_Reader;
      Name      : Unicode.CES.Byte_Sequence;
      Public_Id : Unicode.CES.Byte_Sequence;
      System_Id : Unicode.CES.Byte_Sequence);
   procedure Unparsed_Entity_Decl
     (Handler       : in out XPDL_Reader;
      Name          : Unicode.CES.Byte_Sequence;
      System_Id     : Unicode.CES.Byte_Sequence;
      Notation_Name : Unicode.CES.Byte_Sequence);
   procedure Element_Decl
     (Handler : in out XPDL_Reader;
      Name    : Unicode.CES.Byte_Sequence;
      Model   : Sax.Models.Element_Model_Ptr);
   procedure Notation_Decl
     (Handler       : in out XPDL_Reader;
      Name          : Unicode.CES.Byte_Sequence;
      Public_Id     : Unicode.CES.Byte_Sequence;
      System_Id     : Unicode.CES.Byte_Sequence);
   procedure Attribute_Decl
     (Handler : in out XPDL_Reader;
      Ename   : Unicode.CES.Byte_Sequence;
      Aname   : Unicode.CES.Byte_Sequence;
      Typ     : Sax.Attributes.Attribute_Type;
      Content : Sax.Models.Element_Model_Ptr;
      Value_Default : Sax.Attributes.Default_Declaration;
      Value   : Unicode.CES.Byte_Sequence);

private

   use Ada.Strings.Unbounded;

   package ParticipantList is new GNAT.Dynamic_Tables
     (Table_Component_Type => Participant_Definition_Access,
      Table_Index_Type => Natural,
      Table_Low_Bound => 1,
      Table_Initial => 1,
      Table_Increment => 10);

   type XPDL_Reader is new Sax.Readers.Reader with record
      Locator : Sax.Locators.Locator_Access;
      Silent  : Boolean := False;

      --  The current object
      Current       : Root_Definition_Access;

      ExtAttributes : AWE.Model.Attributes.Internal.Attribute_List;
      Participants  : AWE.Model.Participant.Internal.Participant_List;
      Content       : Unbounded_String;
      Participant   : Participant_Definition_Access;
   end record;

end AWE.Model.XpdlReader;

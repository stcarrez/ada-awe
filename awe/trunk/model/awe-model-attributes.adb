-----------------------------------------------------------------------
--  attributes -- Definition of model attributes
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
with Ada.Text_IO;   use Ada.Text_IO;
with AWE.Util.Xml;  use AWE.Util.Xml;
with AWE.Model.XPDL;

package body AWE.Model.Attributes is

   ----------------------
   -- Attribute        --
   ----------------------
   --  Get the attribute name.
   function Get_Name (Attr : Attribute_Definition) return String_Ptr is
   begin
      return Attr.Name;
   end Get_Name;

   --  Get the attribute value.
   function Get_Value (Attr : Attribute_Definition) return String_Ptr is
   begin
      return Attr.Value;
   end Get_Value;


   ----------------------
   -- Attribute List   --
   ----------------------
   --  Find the attribute given its name and return its definition.
   function Find_Attribute (List : Attribute_Table;
                            Name : String) return Attribute_Definition is
   begin
      for I in List'Range loop
         declare
            Attr : Attribute_Definition renames List (I);
         begin
            if Name = Attr.Name.all then
               return Attr;
            end if;
         end;
      end loop;
      raise NO_ATTRIBUTE;
   end Find_Attribute;

   --  Find the attribute given its name and return its value.
   function Find_Attribute (List : Attribute_Table;
                            Name : String) return String_Ptr is
      Attr : Attribute_Definition := Find_Attribute (List, Name);
   begin
      return Attr.Value;
   end Find_Attribute;

   --  Return true if the attribute is defined in the list.
   function Has_Attribute (List : Attribute_Table;
                           Name : String) return Boolean is
   begin
      for I in List'Range loop
         declare
            Attr : Attribute_Definition renames List (I);
         begin
            if Name = Attr.Name.all then
               return True;
            end if;
         end;
      end loop;
      return False;
   end Has_Attribute;

   --  Create an attribute definition.
   function Create_Attribute(Name : in String;
                             Value : in String) return Attribute_Definition is
      Result : Attribute_Definition;
   begin
      Result.Name  := new String '(Name);
      Result.Value := new String '(Value);
      return Result;
   end Create_Attribute;

   function Create_Attribute(Name : in String_Ptr;
                             Value : in String_Ptr)
                             return Attribute_Definition is
      Result : Attribute_Definition;
   begin
      Result.Name := Name;
      Result.Value := Value;
      return Result;
   end Create_Attribute;

   procedure Print (File : in Ada.Text_IO.File_Type;
                    List : in Attribute_Table) is
      use AWE.Model.XPDL;
   begin
      Print_Element (File, XPDL_EXTENDED_ATTRIBUTES);
      Put_Line (File, ">");
      for I in List'Range loop
         declare
            Attr : Attribute_Definition renames List (I);
         begin
            Print_Element (File, XPDL_EXTENDED_ATTRIBUTE);
            Print_Attribute (File, XPDL_ATTR_NAME, Attr.Name);
            Print_Attribute (File, XPDL_ATTR_VALUE, Attr.Value);
            Put_Line (File, "/>");
         end;
      end loop;
      Print_Element (File, XPDL_EXTENDED_ATTRIBUTES, False);
   end Print;

   --  Print the list of attributes
   procedure Print (List : in Attribute_Table) is
   begin
      Print (Current_Output, List);
   end Print;

end AWE.Model.Attributes;

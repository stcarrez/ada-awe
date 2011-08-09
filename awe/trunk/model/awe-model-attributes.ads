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
with Ada.Text_IO;

package AWE.Model.Attributes is

   NO_ATTRIBUTE : exception;
   --  Exception raised when an attribute cannot be found in a list.

   ----------------------
   -- Attribute        --
   ----------------------
   type Attribute_Definition is private;
   --  Defines a model attribute.  The model attribute is a name/value pair
   --  whose semantics is interpreted by the component it is associated with.
   --  The attribute model cannot be modified as it is a definition attribute.

   function Get_Name (Attr : Attribute_Definition) return String_Ptr;
   --  Get the attribute name.

   function Get_Value (Attr : Attribute_Definition) return String_Ptr;
   --  Get the attribute value.


   ----------------------
   -- Attribute List   --
   ----------------------
   type Attribute_Table is array (Natural range <>) of Attribute_Definition;
   --  Defines a list of attributes.  The list can only be searched as its
   --  intent is to provide a fixed and readonly set of attributes.

   type Attribute_Table_Access is access all Attribute_Table;

   function Find_Attribute (List : Attribute_Table;
                            Name : String) return Attribute_Definition;
   --  Find the attribute given its name and return its definition.

   function Find_Attribute (List : Attribute_Table;
                            Name : String) return String_Ptr;
   --  Find the attribute given its name and return its value.

   function Has_Attribute (List : Attribute_Table;
                           Name : String) return Boolean;
   --  Return true if the attribute is defined in the list.


   procedure Print (File : in Ada.Text_IO.File_Type;
                    List : in Attribute_Table);
   procedure Print (List : in Attribute_Table);
   --  Print the list of attributes

   function Create_Attribute(Name : in String;
                             Value : in String) return Attribute_Definition;
   --  Create an attribute definition.

   function Create_Attribute(Name : in String_Ptr;
                             Value : in String_Ptr)
                             return Attribute_Definition;

private

   type Attribute_Definition is record
      Name  : String_Ptr := null;
      Value : String_Ptr := null;
   end record;

end AWE.Model.Attributes;

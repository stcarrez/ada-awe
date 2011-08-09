-----------------------------------------------------------------------
--  root -- Definition of root model object
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
with AWE.Model.Attributes;  use AWE.Model.Attributes;
with Ada.Text_IO;

package AWE.Model.Root is

   ----------------------
   -- Root             --
   ----------------------
   type Root_Definition is tagged private;
   --  Common definition for every model object.

   type Root_Definition_Access is access all Root_Definition'Class;

   function Get_Name (Object : in Root_Definition'Class) return String_ptr;
   --  Get the object definition name.

   function Get_Id (Object : in Root_Definition'Class) return String_Ptr;
   --  Get the object definition identifier.

   function Get_Description (Object : in Root_Definition) return String_Ptr;
   --  Get the description of the object.

   function Find_Attribute (Object : in Root_Definition;
                            Name   : in String)
                            return Attribute_Definition;
   --  Find the attribute given its name.

   function Find_Attribute (Object : in Root_Definition;
                            Name   : in String)
                            return String_ptr;
   --  Find the attribute given its name.

   procedure Print (File   : in Ada.Text_IO.File_Type;
                    Object : in Root_Definition);
   --  Print a description of the root definition on the output file

   procedure Print (Object : in Root_Definition);
   --  Print a description of the root definition on the standard output

   procedure Print_Attributes (File   : in Ada.Text_IO.File_Type;
                               Object : in Root_Definition'Class);

   procedure Print_Description (File   : in Ada.Text_IO.File_Type;
                                Object : in Root_Definition'Class);

private
   type Root_Definition is tagged record
      Id          : String_ptr := null;
      Name        : String_ptr := null;
      Description : String_Ptr := null;
      Attributes  : Attribute_Table_Access := null;
   end record;

end AWE.Model.Root;

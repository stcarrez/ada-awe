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
with Ada.Text_IO;           use Ada.Text_IO;
with AWE.Model.XPDL;
with AWE.Util.Xml;

package body AWE.Model.Root is

   --  -----------------------
   --  Get the object definition name.
   --  -----------------------
   function Get_Name (Object : in Root_Definition'Class) return String_Ptr is
   begin
      return Object.Name;
   end Get_Name;

   --  -----------------------
   --  Get the object definition identifier.
   --  -----------------------
   function Get_Id (Object : in Root_Definition'Class) return String_Ptr is
   begin
      return Object.Id;
   end Get_Id;

   --  -----------------------
   --  Get the description of the object.
   --  -----------------------
   function Get_Description (Object : in Root_Definition) return String_Ptr is
   begin
      return Object.Description;
   end Get_Description;

   --  -----------------------
   --  Find the attribute given its name.
   --  -----------------------
   function Find_Attribute (Object : in Root_Definition;
                            Name   : in String)
                            return Attribute_Definition is
   begin
      if Object.Attributes = null then
         raise NO_ATTRIBUTE;
      end if;
      return Find_Attribute (Object.Attributes.all, Name);
   end Find_Attribute;

   --  -----------------------
   --  Find the attribute given its name.
   --  -----------------------
   function Find_Attribute (Object : in Root_Definition;
                            Name   : in String)
                            return String_Ptr is
   begin
      if Object.Attributes = null then
         raise NO_ATTRIBUTE;
      end if;
      return Find_Attribute (Object.Attributes.all, Name);
   end Find_Attribute;

   --  -----------------------
   --  Print a description of the root definition on the output file
   --  -----------------------
   procedure Print (File   : in Ada.Text_IO.File_Type;
                    Object : in Root_Definition) is
      use AWE.Model.XPDL;
      use AWE.Util.Xml;
   begin
      Print_Element (File, "root");
      Print_Attribute (File, XPDL_ATTR_ID, Object.Id);
      Print_Attribute (File, XPDL_ATTR_NAME, Object.Name);
      Put_Line (File, ">");
      Print_Description (File, Object);
      Print_Attributes (File, Object);
      Print_Element (File, "root", False);
   end Print;

   --  -----------------------
   --  Print a description of the root definition on the standard output
   --  -----------------------
   procedure Print (Object : in Root_Definition) is
   begin
      Print (Current_Output, Root_Definition'Class (Object));
   end Print;

   procedure Print_Attributes (File   : in Ada.Text_IO.File_Type;
                               Object : in Root_Definition'Class) is
   begin
      if Object.Attributes /= null then
         Print (File, Object.Attributes.all);
      end if;
   end Print_Attributes;

   procedure Print_Description (File   : in Ada.Text_IO.File_Type;
                                Object : in Root_Definition'Class) is
      use AWE.Model.XPDL;
      use AWE.Util.Xml;
   begin
      if Object.Description /= null then
         Print_Element (File, XPDL_DESCRIPTION);
         Put (File, ">");
         Put (File, Object.Description.all);
         Print_Element (File, XPDL_DESCRIPTION, False);
      end if;
   end Print_Description;

end AWE.Model.Root;

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

package AWE.Model.Root.Internal is

   procedure Set_Name (Object : in out Root_Definition'Class;
                       Name   : in String_Ptr);

   procedure Set_Description (Object : in out Root_Definition'Class;
                              Description : in String_Ptr);

   procedure Set_Attributes (Object     : in out Root_Definition'Class;
                             Attributes : in Attribute_Table_Access);

   --  -----------------------
   --  Initialize the root definition object
   --  -----------------------
   procedure Initialize (Object     : in out Root_Definition'Class;
                         Name       : in String;
                         Id         : in String;
                         Description: in String;
                         Attributes : in Attribute_Table_Access);

   procedure Initialize (Object     : in out Root_Definition'Class;
                         Name       : in String_Ptr;
                         Id         : in String_Ptr;
                         Description: in String_Ptr;
                         Attributes : in Attribute_Table_Access);

end AWE.Model.Root.Internal;

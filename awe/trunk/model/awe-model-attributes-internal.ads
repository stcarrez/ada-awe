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
with GNAT.Dynamic_Tables;
with AWE.Model.Attributes;

package AWE.Model.Attributes.Internal is


   package Dynamic_Table is new GNAT.Dynamic_Tables
     (Table_Component_Type => Attribute_Definition,
      Table_Index_Type => Natural,
      Table_Low_Bound => 1,
      Table_Initial => 1,
      Table_Increment => 10);
   subtype Attribute_List is Dynamic_Table.Instance;

   procedure Init (List : in out Attribute_List) renames
     Dynamic_Table.Init;

   function Length (List : in Attribute_List) return Natural renames
     Dynamic_Table.Last;

   procedure Append (List : in out Attribute_List;
                     Item : Attribute_Definition) renames Dynamic_Table.Append;

   function Get_Attribute_Table (List : Attribute_List)
     return Attribute_Table_Access;

end AWE.Model.Attributes.Internal;

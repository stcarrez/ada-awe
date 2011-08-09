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

package body AWE.Model.Attributes.Internal is

   use Dynamic_Table;

   function Get_Attribute_Table (List : Attribute_List)
     return Attribute_Table_Access is
      P : Attribute_Table_Access;
      O : Table_Ptr;

      procedure Copy (Index : Natural;
                      Item : Attribute_Definition;
                      Quit : in out Boolean);

      procedure Copy (Index : Natural;
                      Item : Attribute_Definition;
                      Quit : in out Boolean) is
      begin
         P.all (Index) := Item;
      end Copy;

      procedure Copy_Table is new For_Each (Action => Copy);

   begin
      P := new Attribute_Table (1 .. Last (List));
      Copy_Table (List);
      return P;
   end Get_Attribute_Table;

end AWE.Model.Attributes.Internal;

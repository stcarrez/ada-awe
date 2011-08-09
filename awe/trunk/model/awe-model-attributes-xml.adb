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

with DOM.Core;              use DOM.Core;
with DOM.Core.Nodes;        use DOM.Core.Nodes;
with AWE.Model.Attributes;  use AWE.Model.Attributes;
with AWE.Util.Xml;          use AWE.Util.Xml;

package body AWE.Model.Attributes.Xml is

   EXTENDED_ATTRIBUTES : constant String := "ExtendedAttributes";

   function Extract_Attributes (N : in DOM.Core.Node) return Attribute_Table is
      ExtNode : Node := Get_Child (N, EXTENDED_ATTRIBUTES);
      ExtList : Node_List;
      Size    : Natural;
   begin
      if ExtNode = null then
         declare
            Result : Attribute_Table (1 .. 0);
         begin
            return Result;
         end;
      end if;

      ExtList := Child_Nodes (ExtNode);
      Size := Extended_Attributes_Count (N);
      declare
         Result : Attribute_Table (1 .. Size);
         N : Node;
         Count : Natural := Length (ExtList);
      begin
         Size := 1;
         for I in 1 .. Count loop
            N := Item (ExtList, I - 1);
            if Local_Name (N) = "ExtendedAttribute" then
               declare
                  Attribute : Attribute_Definition renames Result (Size);
               begin
                  Attribute.Name := Get_Attribute (N, "Name");
                  Attribute.Value := Get_Attribute (N, "Value");
                  Size := Size + 1;
               end;
            end if;
         end loop;
         return Result;
      end;
   end Extract_Attributes;

   --  Get the number of extended attributes contained in the
   --  <b>ExtendedAttributes</b> element.
   function Extended_Attributes_Count (N : in DOM.Core.Node) return Natural is
      ExtNode  : Node := Get_Child (N, EXTENDED_ATTRIBUTES);
      Children : Node_List;
      Child    : Node;
      Cnt      : Natural;
      Total    : Natural := 0;
   begin
      if ExtNode /= null then
         Children := Child_Nodes (ExtNode);
         Cnt := Length (Children);
         for I in 1 .. Cnt loop
            Child := Item (Children, I - 1);
            if Local_Name (Child) = "ExtendedAttribute" then
               Total := Total + 1;
            end if;
         end loop;
      end if;
      return Total;
   end Extended_Attributes_Count;

end AWE.Model.Attributes.Xml;

-----------------------------------------------------------------------
--  Xml Util -- XML Utility Operations
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
with DOM.Core;          use DOM.Core;
with DOM.Core.Nodes;    use DOM.Core.Nodes;
with Ada.Text_IO;       use Ada.Text_IO;

package body AWE.Util.Xml is

   function Get_Attribute (N : in DOM.Core.Node; Name : in String)
                           return String_Ptr is
      AttrList : Named_Node_Map := DOM.Core.Nodes.Attributes (N);
      A : Node := Get_Named_Item (AttrList, Name);
   begin
      if A = null then
         return null;
      end if;
      return new String '(Node_Value (A));
   end Get_Attribute;

   function Get_Child (N : in DOM.Core.Node; Name : in String)
                       return DOM.Core.Node is
      Children : Node_List := Child_Nodes (N);
      Count    : Natural   := Length (Children);
      Child    : Node;
   begin
      for I in 0 .. Count - 1 loop
         Child := Item (Children, I);
         if Local_Name (Child) = Name then
            return Child;
         end if;
      end loop;
      return null;
   end Get_Child;

   procedure Print_Attribute (File : in Ada.Text_IO.File_Type;
                              Name : in String;
                              Item : in String) is
   begin
      Put (File, " ");
      Put (File, Name);
      Put (File, "='");
      Put (File, Item);
      Put (File, "'");
   end Print_Attribute;

   procedure Print_Attribute (File : in Ada.Text_IO.File_Type;
                              Name : in String;
                              Item : in String_Ptr) is
   begin
      if Item = null then
         Print_Attribute (File, Name, "null");
      else
         Print_Attribute (File, Name, Item.all);
      end if;
   end Print_Attribute;

   procedure Print (File : in Ada.Text_IO.File_Type;
                    Item : in String_Ptr) is
   begin
      if Item = null then
         Put (File, "null");
      else
         Put (File, Item.all);
      end if;
   end Print;

   procedure Print_Element (File  : in Ada.Text_IO.File_Type;
                            Name  : in String;
                            Start : in Boolean := True) is
   begin
      Put (File, "<");
      if not Start then
         Put (File, "/");
      end if;
      Put (File, Name);
      if not Start then
         Put_Line (File, ">");
      end if;
   end Print_Element;

end AWE.Util.Xml;

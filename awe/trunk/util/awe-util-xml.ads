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
with DOM.Core;
with DOM.Core.Nodes;
with Ada.Text_IO;

package AWE.Util.Xml is

   function Get_Attribute (N : in DOM.Core.Node; Name : in String)
                           return String_Ptr;

   function Get_Child (N : in DOM.Core.Node; Name : in String)
                       return DOM.Core.Node;

   procedure Print (File : in Ada.Text_IO.File_Type;
                    Item : in String_Ptr);

   procedure Print_Attribute (File : in Ada.Text_IO.File_Type;
                              Name : in String;
                              Item : in String_Ptr);

   procedure Print_Attribute (File : in Ada.Text_IO.File_Type;
                              Name : in String;
                              Item : in String);

   procedure Print_Element (File  : in Ada.Text_IO.File_Type;
                            Name  : in String;
                            Start : in Boolean := True);

end AWE.Util.Xml;

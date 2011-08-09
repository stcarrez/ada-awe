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

with DOM.Core;    use DOM.Core;

package AWE.Model.Attributes.Xml is

   --  Get the number of extended attributes contained in the
   --  <b>ExtendedAttributes</b> element.
   function Extended_Attributes_Count (N : in DOM.Core.Node) return Natural;

   function Extract_Attributes (N : in DOM.Core.Node) return Attribute_Table;

end AWE.Model.Attributes.Xml;

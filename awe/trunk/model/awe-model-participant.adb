-----------------------------------------------------------------------
--  participant -- Definition of workflow participant
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
with AWE.Util.Xml;
with AWE.Model.XPDL;
with AWE.Model.Root;  use AWE.Model.Root;
with Ada.Text_IO;     use Ada.Text_IO;

package body AWE.Model.Participant is

   ----------------------
   -- Participant      --
   ----------------------
   --  Get the participant type.
   function Get_Type (Object : in Participant_Definition) return Actor_Type is
   begin
      return Object.Kind;
   end Get_Type;

   procedure Print (File   : in Ada.Text_IO.File_Type;
                    Object : in Participant_Definition) is
      use AWE.Model.XPDL;
      use AWE.Util.Xml;
   begin
      Print_Element (File, XPDL_PARTICIPANT);
      Print_Attribute (File, XPDL_ATTR_ID, Get_Id (Object));
      Print_Attribute (File, XPDL_ATTR_NAME, Get_Name (Object));
      Put_Line (File, ">");
      Print_Element (File, XPDL_PARTICIPANT_TYPE);
      case Object.Kind is
         when ACTOR_SYSTEM =>
            Print_Attribute (File, XPDL_ATTR_TYPE, "SYSTEM");

         when ACTOR_USER =>
            Print_Attribute (File, XPDL_ATTR_TYPE, "USER");

         when ACTOR_ROLE =>
            Print_Attribute (File, XPDL_ATTR_TYPE, "ROLE");

         when ACTOR_GROUP =>
            Print_Attribute (File, XPDL_ATTR_TYPE, "GROUP");

      end case;
      Put_Line (File, "/>");
      Print_Description (File, Object);
      Print_Attributes (File, Object);
      Print_Element (File, XPDL_PARTICIPANT, False);
   end Print;

end AWE.Model.Participant;

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
with AWE.Model.Root;  use AWE.Model.Root;
with Ada.Text_IO;

package AWE.Model.Participant is

   type Actor_Type is (ACTOR_SYSTEM,
                       ACTOR_USER,
                       ACTOR_ROLE,
                       ACTOR_GROUP);

   ----------------------
   -- Participant      --
   ----------------------
   type Participant_Definition is new Root_Definition with private;
   type Participant_Definition_Access is
      access all Participant_Definition'Class;

   function Get_Type (Object : in Participant_Definition) return Actor_Type;
   --  Get the participant type.


   procedure Print (File   : in Ada.Text_IO.File_Type;
                    Object : in Participant_Definition);

   type Participant_Table is array (Natural range <>)
     of Participant_Definition_Access;

   type Participant_Table_Access is
      access all Participant_Table;

private
   type Participant_Definition is new Root_Definition with record
      Kind  : Actor_Type := ACTOR_SYSTEM;
   end record;

end AWE.Model.Participant;

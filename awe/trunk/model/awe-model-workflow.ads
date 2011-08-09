-----------------------------------------------------------------------
--  activity -- Representation of an activity model
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
with AWE.Model;              use AWE.Model;
with AWE.Model.Transitions;  use AWE.Model.Transitions;
with AWE.Model.Participant;  use AWE.Model.Participant;
with AWE.Model.Applications; use AWE.Model.Applications;
with AWE.Model.Activity;     use AWE.Model.Activity;

package AWE.Model.Workflow is

   ----------------------
   -- Activity         --
   ----------------------
   type Workflow_Record (Nb_Transitions : Natural;
                         Nb_Activities  : Natural) is
     new Definition_Record with private;
   type Workflow_Record_ptr is access all Workflow_Record'Class;

   function Get_Activity (Workflow : in Workflow_Record;
			  Name     : in String)
     return Activity_Definition_Ptr;

   function Get_Participant (Activity : in Activity_Record)
                             return Participant_Definition_ptr;

   function Get_Priority (Activity : in Activity_Record) return Integer;

   function Get_Workflow (Activity : in Activity_Record) return Workflow_Record_ptr;

   function Get_Transition_End (Transition : in Transition_Record)
                                return Activity_Record_ptr;

private

   type Workflow_Record (Nb_Transitions  : Natural;
                         Nb_Activities   : Natural) is
     new Definition_Record with record
      Actor        : Participant_Definition_Ptr;
      State        : Integer;
      Transitions  : Transition_List (Size => Nb_Transitions);
      Applications : Application_Refs (1 .. Nb_Applications);
   end record;

end AWE.Model.Workflow;

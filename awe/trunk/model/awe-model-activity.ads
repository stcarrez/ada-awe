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

package AWE.Model.Activity is

   ----------------------
   -- Activity         --
   ----------------------
   type Activity_Mode (MANUAL, AUTOMATIC);

   type Activity_Record (Nb_Transitions : Natural;
                         Nb_Applications: Natural) is
     new Definition_Record with private;
   type Activity_Record_ptr is access all Activity_Record'Class;

   function Create_Activity (Workflow : in Workflow_Record'Class;
                             Name     : in String) return Activity_Record'Class;

   function Get_Transition (Activity : in Activity_Record;
                            To : in Activity_Record'Class)
                            return Transition_Record_ptr;

   function Create_Transition (From : in Activity_Record;
                               To   : in Activity_Record'Class)
                 return Transition_Definition'Class;

   function Get_Participant (Activity : in Activity_Record)
                             return Participant_Definition_ptr;

   function Get_Start_Mode (Activity : in Activity_Record)
                            return Activity_Mode;

   function Get_Finish_Mode (Activity : in Activity_Record)
                             return Activity_Mode;

   function Get_Priority (Activity : in Activity_Record) return Integer;

   function Get_Workflow (Activity : in Activity_Record)
                          return Workflow_Record_ptr;

   function Get_Transition_End (Transition : in Transition_Record)
                                return Activity_Record_ptr;

private

   type Activity_Record (Nb_Transitions  : Natural;
                         Nb_Applications : Natural) is
     new Definition_Record with record
      Actor        : Participant_Definition_Ptr;
      State        : Integer;
      Start_Mode   : Activity_Mode;
      Finish_Mode  : Activity_Mode;
      Transitions  : Transition_List (Size => Nb_Transitions);
      Applications : Application_Refs (1 .. Nb_Applications);
   end record;

end AWE.Model.Activity;

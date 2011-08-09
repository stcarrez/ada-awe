-----------------------------------------------------------------------
--  properties -- Generic name/value property management
--  Copyright (C) 2001, 2002, 2003 Free Software Foundation, Inc.
--  Written by Stephane Carrez (stcarrez@nerim.fr)
--
--  This file is part of gprofiler.
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

package body awe is


   procedure Create_Workflow (Name     : in String;
                              Workflow : out Workflow_Record'Class) is
      W : Workflow_Record;
   begin
      W.Name := new String'(name);
      Workflow := W;
   end Create_Workflow;

   procedure Create_Activity (Workflow : in out Workflow_Record;
                              Name     : in String;
                              Activity : out Activity_Record'Class) is
   begin
      null;
   end Create_Activity;


   procedure Create_Transition (From : in out Activity_Record;
                                To   : in Activity_Record;
                                Transition : out Transition_Record'Class) is
   begin
      null;
   end Create_Transition;


end awe;

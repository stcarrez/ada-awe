-----------------------------------------------------------------------
--  root -- Definition of root model object
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

package AWE.Model.Transitions is

   type Transition_Mode is (TRANSITION_CONDITION,
                            TRANSITION_OTHERWISE,
                            TRANSITION_EXCEPTION);

   type Transition_Definition is new Root_Definition with private;
   type Transition_Definition_Ptr is access all Transition_Definition;

   function Get_From (Object : in Transition_Definition)
		      return Root_Definition_Ptr;
   --  Get the origin of the transition

   function Get_To (Object : in Transition_Definition)
		    return Root_Definition_Ptr;
   --  Get the destination of the transition

   function Get_Kind (Object : in Transition_Definition) return Transition_Mode;
   --  Get the transition execution mode.

   type Transition_Group_Mode is (TRANSITION_SPLIT,
				  TRANSITION_FORK);

   type Transition_List (Size : Natural) is private;

   function Get_Mode (Transitions : Transition_List) return Transition_Mode;
   --  Get the mode to interpret the transition list.

--   generic
--      with type Closure_Type;
--      with function Evaluate (Transition : Transition_Definition'Class;
--			      Closure : Closure_Type) return Boolean;
--   function Choose_Transitions (List : Transition_List;
--				Closure : Closure_Type)
--				return Transition_Definition'Class;

private

   type Transition_Definition is new Root_Definition with record
      From : Root_Definition_Ptr := null;
      To   : Root_Definition_Ptr := null;
      Mode : Transition_Mode := TRANSITION_OTHERWISE;
   end record;

   type Transition_Table is array (Natural range <>)
     of Transition_Definition_Ptr;

   type Transition_List (Size : Natural) is record
      Content : Transition_Table (1 .. Size);
      Mode    : Transition_Group_Mode := TRANSITION_SPLIT;
   end record;

end AWE.Model.Transitions;

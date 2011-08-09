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
with GNAT.Dynamic_Tables;

with AWE.Model.Root;       use AWE.Model.Root;
with AWE.Model.Attributes; use AWE.Model.Attributes;

package AWE.Model.Participant.Internal is

   package Dynamic_Table is new GNAT.Dynamic_Tables
     (Table_Component_Type => Participant_Definition_Access,
      Table_Index_Type => Natural,
      Table_Low_Bound => 1,
      Table_Initial => 1,
      Table_Increment => 10);
   subtype Participant_List is Dynamic_Table.Instance;

   procedure Init (List : in out Participant_List)
     renames Dynamic_Table.Init;

   function Length (List : in Participant_List) return Natural
     renames Dynamic_Table.Last;

   procedure Append (List : in out Participant_List;
                     Item : in Participant_Definition_Access)
     renames Dynamic_Table.Append;

   function Get_Participant_Table (List : Participant_List)
     return Participant_Table_Access;

   procedure Set_Participant_Type (Object : in out Participant_Definition'Class;
                                   Kind   : in Actor_Type);
   --  Set the participant type.

   procedure Initialize (Object     : in out Participant_Definition'Class;
                         Name       : in String_Ptr;
                         Id         : in String_Ptr;
                         Description : in String_Ptr;
                         Attributes : in Attribute_Table_Access;
                         Kind       : in Actor_Type);

   function Create_Participant (Name : in String_Ptr;
                                Id   : in String_Ptr)
                                return Participant_Definition_Access;

end AWE.Model.Participant.Internal;

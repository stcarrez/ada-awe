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
with AWE.Model.Root;          use AWE.Model.Root;
with AWE.Model.Attributes;    use AWE.Model.Attributes;
with AWE.Model.Root.Internal; use AWE.Model.Root.Internal;
with AWE.Model.Participant;   use AWE.Model.Participant;

package body AWE.Model.Participant.Internal is

   use Dynamic_Table;

   --  Set the participant type.
   procedure Set_Participant_Type (Object : in out Participant_Definition'Class;
                                   Kind   : in Actor_Type) is
   begin
      Object.Kind := Kind;
   end Set_Participant_Type;

   procedure Initialize (Object     : in out Participant_Definition'Class;
                         Name       : in String_Ptr;
                         Id         : in String_Ptr;
                         Description : in String_Ptr;
                         Attributes : in Attribute_Table_Access;
                         Kind       : in Actor_Type) is
   begin
      Initialize (Object, Name, Id, Description, Attributes);
      Object.Kind := Kind;
   end Initialize;

   function Create_Participant (Name : in String_Ptr;
                                Id   : in String_Ptr)
                                return Participant_Definition_Access is
      Participant : Participant_Definition_Access;
   begin
      Participant := new Participant_Definition;
      Initialize (Participant.all, Name, Id, null, null);
      return Participant;
   end Create_Participant;

   function Get_Participant_Table (List : Participant_List)
     return Participant_Table_Access is
      P : Participant_Table_Access;
      O : Table_Ptr;

      procedure Copy (Index : Natural;
                      Item : Participant_Definition_Access;
                      Quit : in out Boolean);

      procedure Copy (Index : Natural;
                      Item : Participant_Definition_Access;
                      Quit : in out Boolean) is
      begin
         P.all (Index) := Item;
      end Copy;

      procedure Copy_Table is new For_Each (Action => Copy);

   begin
      P := new Participant_Table (1 .. Last (List));
      Copy_Table (List);
      return P;
   end Get_Participant_Table;

end AWE.Model.Participant.Internal;

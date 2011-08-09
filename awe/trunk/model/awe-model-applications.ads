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
with Ada.Text_IO;

package AWE.Model.Applications is

   ----------------------
   -- Basic Types      --
   ----------------------
   type Data_Type is (TYPE_INTEGER, TYPE_BOOLEAN, TYPE_STRING, TYPE_EXTERNAL);
   type Data_Type_Definition is new Root_Definition with private;
   type Data_Type_Definition_Access is access all Data_Type_Definition'Class;

   function Get_Data_Type (Of_Type : Data_Type_Definition) return Data_Type;
   --  Get the data type enumeration.


   ----------------------
   -- Parameter        --
   ----------------------
   type Direction is (PARAM_IN, PARAM_INOUT, PARAM_OUT);

   type Parameter_Definition is new Root_Definition with private;
   type Parameter_Definition_Access is access all Parameter_Definition;

   function Get_Type (Parameter : in Parameter_Definition)
                      return Data_Type_Definition_Access;
   --  Get the parameter type.

   function Get_Data_Type (Parameter : in Parameter_Definition)
                           return Data_Type;
   --  Get the data type enumeration of the parameter's type.


   function Get_Direction (Parameter : in Parameter_Definition)
                           return Direction;

   procedure Print (File      : in Ada.Text_IO.File_Type;
                    Parameter : in Parameter_Definition);

   type Parameter_Table is array (Natural range <>)
     of Parameter_Definition_Access;
   type Parameter_Table_Access is access all Parameter_Table;

   procedure Print (File       : in Ada.Text_IO.File_Type;
                    Parameters : in Parameter_Table);

   ----------------------
   -- Application      --
   ----------------------
   type Application_Definition is new Root_Definition with private;

   type Application_Definition_Access is
      access all Application_Definition'Class;

   function Get_Parameters (Object : in Application_Definition)
                            return Parameter_Table_Access;

   procedure Print (File   : in Ada.Text_IO.File_Type;
                    Object : in Application_Definition);

   type Application_Refs is array (Natural range <>)
     of Application_Definition_Access;

private

   type Data_Type_Definition is new Root_Definition with record
      T : Data_Type := TYPE_STRING;
   end record;

   type Parameter_Definition is new Root_Definition with record
      Parameter_Type : Data_Type_Definition_Access := null;
      Dir : Direction := PARAM_IN;
   end record;

   type Application_Definition is new Root_Definition with record
      Parameters : Parameter_Table_Access := null;
   end record;

end AWE.Model.Applications;

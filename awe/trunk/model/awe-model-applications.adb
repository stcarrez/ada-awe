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
with Ada.Text_IO;     use Ada.Text_IO;
with AWE.Model.Root;  use AWE.Model.Root;
with AWE.Util.Xml;
with AWE.Model.XPDL;

package body AWE.Model.Applications is

   ----------------------
   -- Basic Types      --
   ----------------------

   --  Get the data type enumeration.
   function Get_Data_Type (Of_Type : Data_Type_Definition) return Data_Type is
   begin
      return Of_Type.T;
   end Get_Data_Type;


   ----------------------
   -- Parameter        --
   ----------------------
   --  Get the parameter type.
   function Get_Type (Parameter : in Parameter_Definition)
                      return Data_Type_Definition_Access is
   begin
      return Parameter.Parameter_Type;
   end Get_Type;

   --  Get the data type enumeration of the parameter's type.
   function Get_Data_Type (Parameter : in Parameter_Definition)
                           return Data_Type is
   begin
      if Parameter.Parameter_Type = null then
	 return TYPE_STRING;
      else
	 return Parameter.Parameter_Type.T;
      end if;
   end Get_Data_Type;

   function Get_Direction (Parameter : in Parameter_Definition)
                           return Direction is
   begin
      return Parameter.Dir;
   end Get_Direction;

   ----------------------
   -- Application      --
   ----------------------
   function Get_Parameters (Object : in Application_Definition)
                            return Parameter_Table_Access is
   begin
      return Object.Parameters;
   end Get_Parameters;

   procedure Print (File      : in Ada.Text_IO.File_Type;
		    Parameter : in Parameter_Definition) is
      use AWE.Util.Xml;
      use AWE.Model.XPDL;
   begin
      Print_Element (File, XPDL_FORMAL_PARAMETER);
      Print_Attribute (File, XPDL_ATTR_ID, Get_Id (Parameter));
      Print_Attribute (File, XPDL_ATTR_NAME, Get_Name (Parameter));
      case Parameter.Dir is
	 when PARAM_IN =>
	    Print_Attribute (File, XPDL_ATTR_MODE, "IN");

	 when PARAM_OUT =>
	    Print_Attribute (File, XPDL_ATTR_MODE, "OUT");

	 when PARAM_INOUT =>
	    Print_Attribute (File, XPDL_ATTR_MODE, "INOUT");
      end case;
      Print_Description (File, Parameter);
      Print_Attributes (File, Parameter);
      Print_Element (File, XPDL_FORMAL_PARAMETER, False);
   end Print;

   procedure Print (File       : in Ada.Text_IO.File_Type;
		    Parameters : in Parameter_Table) is
      use AWE.Util.Xml;
      use AWE.Model.XPDL;
   begin
      Print_Element (File, XPDL_FORMAL_PARAMETERS);
      Put_Line (File, ">");
      for I in Parameters'Range loop
	 Print (File, Parameters (I).all);
      end loop;
      Print_Element (File, XPDL_FORMAL_PARAMETERS, False);
   end Print;

   procedure Print (File   : in Ada.Text_IO.File_Type;
                    Object : in Application_Definition) is
      use AWE.Util.Xml;
      use AWE.Model.XPDL;
   begin
      Print_Element (File, XPDL_APPLICATION);
      Print_Attribute (File, XPDL_ATTR_ID, Get_Id (Object));
      Print_Attribute (File, XPDL_ATTR_NAME, Get_Name (Object));
      Put_Line (File, ">");
      if Object.Parameters /= null then
	 Print (File, Object.Parameters.all);
      end if;
      Print_Element (File, XPDL_APPLICATION, False);
   end Print;

end AWE.Model.Applications;

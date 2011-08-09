-----------------------------------------------------------------------
--  agent -- Abstract Definition of Tool Agent
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
with AWE.Runtime.Context;      use AWE.Runtime.Context;
package AWE.Runtime.Agent.Factory is

   ----------------------
   -- Agent Factory    --
   ----------------------
   type Agent_Factory_Type is abstract tagged private;
   --  The tool agent object.  This is an abstract type that must be
   --  specialized for each tool agent.  The tool agent must implement
   --  the <b>Execute</b> method that represents the tool agent implementation.

   type Agent_Type_Access is access all Agent_Type;

   procedure Register (Agent : in Agent_Type'Class;
		       Name  : in String);
   --  Register the tool agent under the specified name.

private

   
   type Agent_Type is tagged record
   end record;

   MyTool : My_Agent_Type;
   MyToolParam : Parameter_Table (1 .. 3);

begin
   Declare_Parameter (MyToolParams, "param1", TYPE_INTEGER, PARAM_INOUT);
   Declare_Parameter (MyToolParams, "param2", TYPE_STRING, PARAM_IN);
   Declare_Parameter (MyToolParams, "param3", TYPE_OUT);
   Register (MyTool, "MyTool", MyToolParam);

end AWE.Runtime.Agent.Factory;

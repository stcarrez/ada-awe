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
package AWE.Runtime.Agent is

   ----------------------
   -- Tool Agent       --
   ----------------------
   type Agent_Type is abstract tagged private;
   --  The tool agent object.  This is an abstract type that must be
   --  specialized for each tool agent.  The tool agent must implement
   --  the <b>Execute</b> method that represents the tool agent implementation.

   type Agent_Type_Access is access all Agent_Type;

   procedure Execute (Agent : in Agent_Type;
		      Ctx   : in Tool_Context_Type'Class) is abstract;
   --  The tool agent implementation.  The <b>Agent</b> parameter
   --  contains the agent instance that is shared among all activities
   --  for the given tool agent.  It contains the tool agent configuration.
   --  The <b>Ctx</b> parameter contains the activity context for the
   --  tool agent execution.  It contains the input parameter that the
   --  tool agent implementation can use.  Upon successful completion
   --  of the tool agent, it will contain the output parameters.  The output
   --  parameters are saved back in the activity context once the tool
   --  agent finishes.

   ----------------------
   -- Empty Agent      --
   ----------------------
   type Empty_Agent_Type is new Agent_Type with null record;
   --  The empty tool agent.

   procedure Execute (Agent : in Empty_Agent_Type;
		      Ctx   : in Tool_Context_Type'Class);
   --  Empty tool agent implementation.

private

   
   type Agent_Type is tagged record
   end record;

end AWE.Runtime.Agent;

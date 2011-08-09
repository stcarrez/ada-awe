-----------------------------------------------------------------------
--  model -- Generic name/value property management
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

package AWE.Model.XPDL is

   XPDL_PACKAGE : constant String := "Package";
   XPDL_PACKAGE_HEADER : constant String := "PackageHeader";
   XPDL_XPDLVERSION : constant String := "XPDLVersion";
   XPDL_VENDOR : constant String := "Vendor";
   XPDL_CREATED : constant String := "Created";
   XPDL_REDIFINABLE_HEADER : constant String := "RedefinableHeader";
   XPDL_PARTICIPANTS : constant String := "Participants";
   XPDL_PARTICIPANT  : constant String := "Participant";
   XPDL_PARTICIPANT_TYPE : constant String := "ParticipantType";
   XPDL_WORKFLOWS : constant String := "WorkflowProcesses";
   XPDL_WORKFLOW : constant String := "WorkflowProcess";
   XPDL_PROCESS_HEADER : constant String := "ProcessHeader";
   XPDL_APPLICATIONS : constant String := "Applications";
   XPDL_APPLICATION : constant String := "Application";
   XPDL_ACTIVITIES : constant String := "Activities";
   XPDL_ACTIVITY : constant String := "Activity";
   XPDL_IMPLEMENTATION : constant String := "Implementation";
   XPDL_TOOL : constant String := "Tool";
   XPDL_PERFORMER : constant String := "Performer";
   XPDL_START_MODE : constant String := "StartMode";
   XPDL_FINISH_MODE : constant String := "FinishMode";
   XPDL_AUTOMATIC : constant String := "Automatic";
   XPDL_MANUAL : constant String := "Manual";
   XPDL_TRANSITIONS : constant String := "Transitions";
   XPDL_TRANSITION : constant String := "Transition";
   XPDL_EXTENDED_ATTRIBUTE : constant String := "ExtendedAttribute";
   XPDL_EXTENDED_ATTRIBUTES : constant String := "ExtendedAttributes";
   XPDL_DESCRIPTION : constant String := "Description";
   XPDL_ACTUAL_PARAMETERS : constant String := "ActualParameters";
   XPDL_ACTUAL_PARAMETER : constant String := "ActualParameter";

   XPDL_FORMAL_PARAMETERS : constant String := "FormalParameters";
   XPDL_FORMAL_PARAMETER : constant String := "FormalParameter";
   XPDL_DATA_TYPE : constant String := "DataType";
   XPDL_BASIC_TYPE : constant String := "BasicType";

   XPDL_ATTR_ID : constant String := "Id";
   XPDL_ATTR_NAME : constant String := "Name";
   XPDL_ATTR_VALUE : constant String := "Value";
   XPDL_ATTR_FROM : constant String := "From";
   XPDL_ATTR_TO : constant String := "To";
   XPDL_ATTR_INDEX             : constant String := "Index";
   XPDL_ATTR_MODE              : constant String := "Mode";
   XPDL_ATTR_TYPE              : constant String := "Type";
   XPDL_ATTR_ACCESS_LEVEL      : constant String := "AccessLevel";
   XPDL_ATTR_DURATION_UNIT     : constant String := "DurationUnit";
   XPDL_ATTR_PUB_STATUS        : constant String := "PublicationStatus";
   XPDL_ATTR_GRAPH_CONFORMANCE : constant String := "GraphConformance";

end AWE.Model.XPDL;

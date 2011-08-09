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
with AWE.Model.Applications;   use AWE.Model.Applications;
with System;  use System;
package AWE.Runtime.Context is

   type Data_Value (Of_Type : Data_Type) is record
      case Of_Type is
         when TYPE_INTEGER =>
            Int_Value : Integer;

         when TYPE_BOOLEAN =>
            Bool_Value : Boolean;

         when TYPE_STRING =>
            String_Value : String_Ptr;

         when TYPE_EXTERNAL =>
            Addr : System.Address;
      end case;
   end record;

   type Context_Type is tagged record with private;

   function Get_Parameter (Ctx  : in Context_Type;
                           Name : in String) return Data_Value;

   procedure Set_Parameter (Ctx   : in out Context_Type;
                            Name  : in String;
                            Value : in Data_Value);

   type Tool_Context_Type is new Context_Type with private;

   function Get_Parameter (Ctx  : in Tool_Context_Type;
                           Name : in String) return Data_Value;

   procedure Set_Parameter (Ctx   : in Tool_Context_Type;
                            Name  : in String;
                            Value : in Data_Value);

   function Get_Activity (Ctx : in Tool_Context_Type) return String;

   function Get_Process (Ctx : in Tool_Context_Type) return String;


private

   type Data_Value_Access is access all Data_Value;

   type Data_Array is array (Natural range <>) of Data_Value_Access;

   type Name_Array is array (Natural range <>) of String_Ptr;
   type Name_Array_Access is access all Name_Array;

   type Context_Type (Size : Natural) is record
      Data  : Data_Array (0 .. Size);
      Names : Name_Array_Access;
   end record;

   type Tool_Context_Type is new Context_Type with record
      Activity : String_Ptr;
      Process  : String_Ptr;
   end record;

end AWE.Runtime.Context;

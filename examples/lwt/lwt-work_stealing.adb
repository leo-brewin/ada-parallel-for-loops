------------------------------------------------------------------------------
--                    L W T . W O R K _ S T E A L I N G                     --
--                                                                          --
--                     Copyright (C) 2012-2023, AdaCore                     --
--                                                                          --
-- This is free software;  you can redistribute it  and/or modify it  under --
-- terms of the  GNU General Public License as published  by the Free Soft- --
-- ware  Foundation;  either version 3,  or (at your option) any later ver- --
-- sion.  This software is distributed in the hope  that it will be useful, --
-- but WITHOUT ANY WARRANTY;  without even the implied warranty of MERCHAN- --
-- TABILITY or FITNESS FOR A PARTICULAR PURPOSE.                            --
--                                                                          --
-- As a special exception under Section 7 of GPL version 3, you are granted --
-- additional permissions described in the GCC Runtime Library Exception,   --
-- version 3.1, as published by the Free Software Foundation. See           --
-- documentation/COPYING3 and documentation/GCC_RUNTIME3_1 for details.     --
------------------------------------------------------------------------------

with Ada.Unchecked_Deallocation;
with LWT.Scheduler.Work_Stealing;

package body LWT.Work_Stealing is
   use LWT.Scheduler.Work_Stealing;

   procedure Initialize (Obj : in out WS_Parallel) is
      --  Create info about the new server team
      New_Team : constant Server_Team_Ptr := new Server_Team_Info;
   begin
      Obj.Team_Info := New_Team;
      LWT.Scheduler.Work_Stealing.Incr_WS_Parallel_Regions (Obj, New_Team);
   end Initialize;

   procedure Free is new Ada.Unchecked_Deallocation
     (Server_Team_Info, Server_Team_Ptr);

   procedure Finalize (Obj : in out WS_Parallel) is
      Team : Server_Team_Ptr := Obj.Team_Info;
   begin
      LWT.Scheduler.Work_Stealing.Decr_WS_Parallel_Regions (Obj, Team);

      --  Reclaim storage for team info
      Free (Team);
   end Finalize;

end LWT.Work_Stealing;

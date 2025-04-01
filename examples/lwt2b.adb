with Support;                   use Support;
with Support.Strings;           use Support.Strings;
with Support.CmdLine;           use Support.CmdLine;
with Support.Random;            use Support.Random;
with Support.Timer;             use Support.Timer;

with Ada.Text_IO;               use Ada.Text_IO;
with Ada.Command_Line;          use Ada.Command_Line;

with LWT.Parallelism;           use LWT.Parallelism;
with LWT.Work_Stealing;         use LWT.Work_Stealing;

procedure lwt2b is

   num_tasks : Integer := read_command_arg ("--NumTasks?|--numtasks?",4);
   num_loop  : Integer := read_command_arg ("--NumLoops?|--numloops?",100);
   num_data  : Integer := read_command_arg ("--NumData",1000);
   rnd_scale : Real    := read_command_arg ("--RndScale",0.0001);

   Control : WS_Parallel (Num_Servers => num_tasks, Options => null);
   pragma Unreferenced (Control);

   procedure job1 (Low, High : Longest_Integer; Chunk_Index : Positive) is
   begin
      for I in Positive (Low) .. Positive (High) loop
         delay Duration (rnd_scale*rnd_real);
      end loop;
   end job1;

   procedure job2 (Low, High : Longest_Integer; Chunk_Index : Positive) is
   begin
      for I in Positive (Low) .. Positive (High) loop
         delay Duration (rnd_scale*rnd_real);
      end loop;
   end job2;

   procedure job3 (Low, High : Longest_Integer; Chunk_Index : Positive) is
   begin
      for I in Positive (Low) .. Positive (High) loop
         delay Duration (rnd_scale*rnd_real);
      end loop;
   end job3;

begin

   beg_timer;

   for n in 1 .. num_loop loop

      Par_Range_Loop (Low       => Longest_Integer (1),
                      High      => Longest_Integer (num_data),
                      Loop_Body => job1'Access);

      Par_Range_Loop (Low       => Longest_Integer (1),
                      High      => Longest_Integer (num_data),
                      Loop_Body => job2'Access);

      Par_Range_Loop (Low       => Longest_Integer (1),
                      High      => Longest_Integer (num_data),
                      Loop_Body => job3'Access);

   end loop;

   end_timer;

   put_line (str(Command_Name,9,' ')&": "&
             "NumTasks = "&  str(num_tasks,2)&", "&
             "NumLoop = "&   str(num_loop)&", "&
             "NumData = "&   str(num_data)&", "&
             "RndScale = "&  str(rnd_scale)&", "&
             "Time = "&      str(get_elapsed,5,1));

end lwt2b;

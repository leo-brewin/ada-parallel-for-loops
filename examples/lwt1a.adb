with Ada.Text_IO;               use Ada.Text_IO;

with LWT.Parallelism;           use LWT.Parallelism;
with LWT.OpenMP;                use LWT.OpenMP;

with Support;                   use Support;
with Support.Clock;             use Support.Clock;
with Support.Strings;           use Support.Strings;
with Support.CmdLine;           use Support.CmdLine;
with Support.Random;            use Support.Random;

procedure lwt1a is

   num_tasks : Integer := read_command_arg ("--NumTasks?|--numtasks?",4);
   num_loop  : Integer := read_command_arg ("--NumLoops?|--numloops?",4);
   num_data  : Integer := read_command_arg ("--NumData",1000);
   rnd_scale : Real    := read_command_arg ("--RndScale",0.0001);

   Control : OMP_Parallel (Num_Threads => num_tasks);
   pragma Unreferenced (Control);

   procedure job1 (Low, High : Longest_Integer; Chunk_Index : Positive) is
   begin
      put_line ("Chunk "&str(Chunk_Index)&" starting job 1");
      for I in Positive (Low) .. Positive (High) loop
         delay Duration (rnd_scale*rnd_real);
      end loop;
      put_line ("Chunk "&str(Chunk_Index)&" finished job 1");
   end job1;

   procedure job2 (Low, High : Longest_Integer; Chunk_Index : Positive) is
   begin
      put_line ("Chunk "&str(Chunk_Index)&" starting job 2");
      for I in Positive (Low) .. Positive (High) loop
         delay Duration (rnd_scale*rnd_real);
      end loop;
      put_line ("Chunk "&str(Chunk_Index)&" finished job 2");
   end job2;

   procedure job3 (Low, High : Longest_Integer; Chunk_Index : Positive) is
   begin
      put_line ("Chunk "&str(Chunk_Index)&" starting job 3");
      for I in Positive (Low) .. Positive (High) loop
         delay Duration (rnd_scale*rnd_real);
      end loop;
      put_line ("Chunk "&str(Chunk_Index)&" finished job 3");
   end job3;

begin

   echo_date;

   for n in 1 .. num_loop loop

      put_line ("---------------------------------");
      put_line ("Start loop "&str(n)&" of "&str(num_loop));

      Par_Range_Loop (Low       => Longest_Integer (1),
                      High      => Longest_Integer (num_data),
                      Loop_Body => job1'Access);

      Par_Range_Loop (Low       => Longest_Integer (1),
                      High      => Longest_Integer (num_data),
                      Loop_Body => job2'Access);

      Par_Range_Loop (Low       => Longest_Integer (1),
                      High      => Longest_Integer (num_data),
                      Loop_Body => job3'Access);

      put_line ("Done loop "&str(n)&" of "&str(num_loop));

   end loop;

end lwt1a;

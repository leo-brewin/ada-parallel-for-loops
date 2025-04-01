with Support;                   use Support;
with Support.Strings;           use Support.Strings;
with Support.CmdLine;           use Support.CmdLine;
with Support.Random;            use Support.Random;
with Support.Parallel;          use Support.Parallel;
with Support.Timer;             use Support.Timer;

with Ada.Text_IO;               use Ada.Text_IO;
with Ada.Command_Line;          use Ada.Command_Line;

procedure ex1c is

   package Real_IO is new Ada.Text_IO.Float_IO (Real);    use Real_IO;

   num_tasks : Integer := read_command_arg ("--NumTasks?|--numtasks?",4);
   num_loop  : Integer := read_command_arg ("--NumLoops?|--numloops?",4);
   num_data  : Integer := read_command_arg ("--NumData",1000);
   rnd_scale : Real    := read_command_arg ("--RndScale",0.0001);

   procedure job1 (task_id : Integer; i_beg, i_end : Integer) is
   begin

      for i in i_beg .. i_end loop
         delay Duration (rnd_scale*rnd_real);
      end loop;

   end job1;

   procedure job2 (task_id : Integer; i_beg, i_end : Integer) is
   begin

      for i in i_beg .. i_end loop
         delay Duration (rnd_scale*rnd_real);
      end loop;

   end job2;

   procedure job3 (task_id : Integer; i_beg, i_end : Integer) is
   begin

      for i in i_beg .. i_end loop
         delay Duration (rnd_scale*rnd_real);
      end loop;

   end job3;

begin

   beg_timer;

   -- ini_parallel (1,num_data,num_tasks);
   --
   -- for n in 1 .. num_loop loop
   --
   --    run_parallel (job1'access);
   --    run_parallel (job2'access);
   --    run_parallel (job3'access);
   --
   -- end loop;

   for n in 1 .. num_loop loop

      run_parallel (job1'access,1,num_data,num_tasks);
      run_parallel (job2'access,1,num_data,num_tasks);
      run_parallel (job3'access,1,num_data,num_tasks);

   end loop;

   end_timer;

   put_line (str(Command_Name,9,' ')&": "&
             "NumTasks = "&  str(num_tasks,2)&", "&
             "NumLoop = "&   str(num_loop)&", "&
             "NumData = "&   str(num_data)&", "&
             "RndScale = "&  str(rnd_scale)&", "&
             "Time = "&      str(get_elapsed,5,1));

end ex1c;

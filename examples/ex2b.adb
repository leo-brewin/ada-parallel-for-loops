with Support;                   use Support;
with Support.Strings;           use Support.Strings;
with Support.CmdLine;           use Support.CmdLine;
with Support.Random;            use Support.Random;
with Support.Timer;             use Support.Timer;

with Ada.Text_IO;               use Ada.Text_IO;
with Ada.Command_Line;          use Ada.Command_Line;

procedure ex2b is

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

   task type My_Task is
      entry beg_job;
      entry end_job;
      entry stop_task;
      entry start_task (task_id : Integer; i_beg, i_end : Integer);
   end My_Task;

   task body My_Task is
      my_task_id : Integer;
      my_i_beg   : Integer;
      my_i_end   : Integer;
   begin

      accept start_task (task_id : Integer; i_beg, i_end : Integer) do
         my_task_id := task_id;
         my_i_beg   := i_beg;
         my_i_end   := i_end;
      end;

      loop

         select

            accept beg_job;   job1 (my_task_id, my_i_beg, my_i_end);   accept end_job;
            accept beg_job;   job2 (my_task_id, my_i_beg, my_i_end);   accept end_job;
            accept beg_job;   job3 (my_task_id, my_i_beg, my_i_end);   accept end_job;

         or

            accept stop_task;
            exit;

         end select;

      end loop;

   end My_Task;

   the_tasks : Array (1..num_tasks) of my_task;

   procedure run_parallel is
   begin

      for t in 1 .. num_tasks loop
         the_tasks (t).beg_job;
      end loop;

      for t in 1 .. num_tasks loop
         the_tasks (t).end_job;
      end loop;

   end run_parallel;

begin

   beg_timer;

   declare
      i_step : Integer;
      i_beg, i_end : Integer;
   begin

      i_step := (num_data - 1) / num_tasks;

      i_beg := 1;
      i_end := min (i_beg + i_step, num_data);

      for t in 1 .. num_tasks loop

         the_tasks (t).start_task (t, i_beg, i_end);

         i_beg := i_end + 1;
         i_end := min (i_beg + i_step, num_data);

      end loop;

   end;

   for n in 1 .. num_loop loop

      run_parallel;  -- all tasks running job1
      run_parallel;  -- all tasks running job2
      run_parallel;  -- all tasks running job3

   end loop;

   for t in 1 .. num_tasks loop
      the_tasks (t).stop_task;
   end loop;

   end_timer;

   put_line (str(Command_Name,9,' ')&": "&
             "NumTasks = "&  str(num_tasks,2)&", "&
             "NumLoop = "&   str(num_loop)&", "&
             "NumData = "&   str(num_data)&", "&
             "RndScale = "&  str(rnd_scale)&", "&
             "Time = "&      str(get_elapsed,5,1));

end ex2b;

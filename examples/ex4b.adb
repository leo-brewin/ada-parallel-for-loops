with Support;                   use Support;
with Support.Strings;           use Support.Strings;
with Support.CmdLine;           use Support.CmdLine;
with Support.Random;            use Support.Random;
with Support.Timer;             use Support.Timer;

with Ada.Text_IO;               use Ada.Text_IO;
with Ada.Command_Line;          use Ada.Command_Line;

procedure ex4b is

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

   -- this protected type based on the second solution to
   -- exercise 20.9 Q.2 in Barnes 2012

   protected control is
      entry pause_task;
      entry resume_main;
      entry resume_tasks;
      entry request_stop;
      function should_stop Return Boolean;
   private
      stop_tasks : Boolean := False;
   end control;

   protected body control is

      -- Note: the "when" in the following entry barrier might better be read as "until"

      entry pause_task when resume_tasks'count > 0 is
      begin
         null;
      end pause_task;

      entry resume_tasks when pause_task'count = 0 is
      begin
         null;
      end resume_tasks;

      entry resume_main when pause_task'count = num_tasks is
      begin
         null;
      end resume_main;

      entry request_stop when pause_task'count = num_tasks is
      begin
         stop_tasks := True;
      end request_stop;

      function should_stop Return Boolean is
      begin
         return stop_tasks;
      end should_stop;

   end control;

   task type My_Task is
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

         job1 (my_task_id, my_i_beg, my_i_end);   control.pause_task;
         job2 (my_task_id, my_i_beg, my_i_end);   control.pause_task;
         job3 (my_task_id, my_i_beg, my_i_end);   control.pause_task;

         exit when control.should_stop;

      end loop;

   end My_Task;

   procedure run_parallel is
   begin

      -- one resume pair for each pause_task in the main task loop

      control.resume_main;    -- when all tasks paused
      control.resume_tasks;   -- resume all paused tasks

   end run_parallel;

   the_tasks : Array (1..num_tasks) of my_task;

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

   for n in 1 .. num_loop-1 loop

      run_parallel;
      run_parallel;
      run_parallel;

   end loop;

   -- one extra iteration to squeeze in a call to control.request_stop

   control.request_stop;

   run_parallel;
   run_parallel;
   run_parallel;

   end_timer;

   put_line (str(Command_Name,9,' ')&": "&
             "NumTasks = "&  str(num_tasks,2)&", "&
             "NumLoop = "&   str(num_loop)&", "&
             "NumData = "&   str(num_data)&", "&
             "RndScale = "&  str(rnd_scale)&", "&
             "Time = "&      str(get_elapsed,5,1));

end ex4b;

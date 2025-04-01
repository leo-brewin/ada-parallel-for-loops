with Support;                   use Support;
with Support.Clock;             use Support.Clock;
with Support.Strings;           use Support.Strings;
with Support.CmdLine;           use Support.CmdLine;
with Support.Random;            use Support.Random;

with Ada.Text_IO;               use Ada.Text_IO;

procedure ex4a is

   num_tasks : Integer := read_command_arg ("--NumTasks?|--numtasks?",4);
   num_loop  : Integer := read_command_arg ("--NumLoops?|--numloops?",4);
   rnd_scale : Real    := read_command_arg ("--RndScale",0.01);

   procedure job1 (task_id : Integer) is
   begin

      put_line ("Task "&str(task_id)&" starting job 1");
      delay Duration (rnd_scale*rnd_real);
      put_line ("Task "&str(task_id)&" finished job 1");

   end job1;

   procedure job2 (task_id : Integer) is
   begin

      put_line ("Task "&str(task_id)&" starting job 2");
      delay Duration (rnd_scale*rnd_real);
      put_line ("Task "&str(task_id)&" finished job 2");

   end job2;

   procedure job3 (task_id : Integer) is
   begin

      put_line ("Task "&str(task_id)&" starting job 3");
      delay Duration (rnd_scale*rnd_real);
      put_line ("Task "&str(task_id)&" finished job 3");

   end job3;

   -- this protected type based on the second solution to
   -- exercise 20.9 Q.2 in Barnes 2012

   protected control is
      entry pause_task (me : Integer);
      entry resume_main;
      entry resume_tasks;
      entry request_stop;
      function  should_stop Return Boolean;
      procedure started_task (me : Integer);
      procedure terminating_task (me : Integer);
   private
      stop_tasks : Boolean := False;
   end control;

   protected body control is

      -- Note: the "when" in the following entry barrier might better be read as "until"

      entry pause_task (me : Integer) when resume_tasks'count > 0 is
      begin
         null;
         -- put_line ("! in control.pause_task, pause_task'count: "&str(pause_task'count)&" resume_tasks'count: "&str(resume_tasks'count)&" task: "&str(me));
      end pause_task;

      entry resume_tasks when pause_task'count = 0 is
      begin
         null;
         -- put_line ("! in control.resume_tasks, pause_task'count: "&str(pause_task'count));
      end resume_tasks;

      entry resume_main when pause_task'count = num_tasks is
      begin
         null;
         -- put_line ("! done control.resume_main");
      end resume_main;

      -- moo.adb: warning: potentially unsynchronized barrier [enabled by default]
      -- moo.adb: warning: "num_tasks" should be private component of type [enabled by default]

      entry request_stop when pause_task'count = num_tasks is
      begin
         stop_tasks := True;
         -- put_line ("! in control.request_stop");
      end request_stop;

      function should_stop Return Boolean is
      begin
         return stop_tasks;
      end should_stop;

      procedure started_task (me : Integer) is
      begin
         null;
         put_line ("Task "&str(me)&" started.");
      end started_task;

      procedure terminating_task (me : Integer) is
      begin
         null;
         put_line ("Task "&str(me)&" terminating.");
      end terminating_task;

   end control;

   task type My_Task is
      entry start_task (task_id : Integer);
   end My_Task;

   task body My_Task is
      my_task_id : Integer;
   begin

      accept start_task (task_id : Integer) do
         my_task_id := task_id;
      end;

      control.started_task (my_task_id);

      loop

         job1 (my_task_id);   control.pause_task (my_task_id);
         job2 (my_task_id);   control.pause_task (my_task_id);
         job3 (my_task_id);   control.pause_task (my_task_id);

         exit when control.should_stop;

      end loop;

      control.terminating_task (my_task_id);

   end My_Task;

   procedure run_parallel is
   begin

      -- one resume pair for each pause_task in the main task loop

      control.resume_main;    -- when all tasks paused
      control.resume_tasks;   -- resume all paused tasks

   end run_parallel;

   the_tasks : Array (1..num_tasks) of my_task;

begin

   echo_date;

   for t in 1 .. num_tasks loop
      the_tasks (t).start_task (t);
      control.started_task (t);
   end loop;

   for n in 1 .. num_loop-1 loop

      put_line ("---------------------------------");
      put_line ("Start loop "&str(n)&" of "&str(num_loop));

      run_parallel;   put_line ("Finished job 1 in loop "&str(n)&" of "&str(num_loop));
      run_parallel;   put_line ("Finished job 2 in loop "&str(n)&" of "&str(num_loop));
      run_parallel;   put_line ("Finished job 3 in loop "&str(n)&" of "&str(num_loop));

      put_line ("Done loop "&str(n)&" of "&str(num_loop));

   end loop;

   -- one extra iteration to squeeze in a call to control.request_stop

   put_line ("Start loop "&str(num_loop)&" of "&str(num_loop));

   control.request_stop;

   run_parallel;   put_line ("Finished job 1 in loop "&str(num_loop)&" of "&str(num_loop));
   run_parallel;   put_line ("Finished job 2 in loop "&str(num_loop)&" of "&str(num_loop));
   run_parallel;   put_line ("Finished job 3 in loop "&str(num_loop)&" of "&str(num_loop));

   put_line ("Done loop "&str(num_loop)&" of "&str(num_loop));

end ex4a;

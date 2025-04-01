with Support;                   use Support;
with Support.Clock;             use Support.Clock;
with Support.Strings;           use Support.Strings;
with Support.CmdLine;           use Support.CmdLine;
with Support.Random;            use Support.Random;

with Ada.Text_IO;               use Ada.Text_IO;

with Ada.Synchronous_Barriers;
use  Ada.Synchronous_Barriers;

procedure ex3a is

   num_tasks : Integer := read_command_arg ("--NumTasks?|--numtasks?",4);
   num_loop  : Integer := read_command_arg ("--NumLoops?|--numloops?",4);
   rnd_scale : Real    := read_command_arg ("--RndScale",0.01);

   sync_barrier : Synchronous_Barrier (num_tasks);
   notified     : Boolean := False;

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

   task type My_Task is
      entry parallel;
      entry serial;
      entry stop_task;
      entry start_task (task_id : Integer);
   end My_Task;

   task body My_Task is
      my_task_id : Integer;
   begin

      accept start_task (task_id : Integer) do
         my_task_id := task_id;
      end;

      put_line ("Task "&str(my_task_id)&" started");

      loop

         select

            accept parallel;

            job1 (my_task_id);   Wait_For_Release (sync_barrier, notified);
            job2 (my_task_id);   Wait_For_Release (sync_barrier, notified);
            job3 (my_task_id);   Wait_For_Release (sync_barrier, notified);

            accept serial;

         or

            accept stop_task;
            exit;

         or

            terminate;  -- a safeguard, just to ensure tasks don't hang

         end select;

      end loop;

      put_line ("Task "&str(my_task_id)&" finished");

   end My_Task;

   the_tasks : Array (1..num_tasks) of my_task;

   procedure run_parallel is
   begin

      -- will start all tasks working on the body of the Runge-Kutta computations

      for t in 1 .. num_tasks loop
         the_tasks (t).parallel;
      end loop;

      -- now all tasks are running in parallel

      -- force the main thread to pause while waiting for all
      -- tasks to accept this batch of entry calls

      for t in 1 .. num_tasks loop
         the_tasks (t).serial;
      end loop;

      -- now running on just the main thread
      -- all tasks are paused

   end run_parallel;

begin

   echo_date;

   for t in 1 .. num_tasks loop
      the_tasks (t).start_task (t);
   end loop;

   for n in 1 .. num_loop loop

      put_line ("---------------------------------");
      put_line ("Start loop "&str(n)&" of "&str(num_loop));

      run_parallel;

      put_line ("Done loop "&str(n)&" of "&str(num_loop));

   end loop;

   for t in 1 .. num_tasks loop
      the_tasks (t).stop_task;
   end loop;

end ex3a;

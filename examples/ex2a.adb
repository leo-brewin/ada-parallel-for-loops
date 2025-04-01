with Support;                   use Support;
with Support.Clock;             use Support.Clock;
with Support.Strings;           use Support.Strings;
with Support.CmdLine;           use Support.CmdLine;
with Support.Random;            use Support.Random;

with Ada.Text_IO;               use Ada.Text_IO;

procedure ex2a is

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

   task type My_Task is
      entry beg_job;
      entry end_job;
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

            accept beg_job;   job1 (my_task_id);   accept end_job;
            accept beg_job;   job2 (my_task_id);   accept end_job;
            accept beg_job;   job3 (my_task_id);   accept end_job;

         or

            accept stop_task;
            exit;

         end select;

      end loop;

      put_line ("Task "&str(my_task_id)&" finished");

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

   echo_date;

   for t in 1 .. num_tasks loop
      the_tasks (t).start_task (t);
   end loop;

   for n in 1 .. num_loop loop

      put_line ("---------------------------------");
      put_line ("Start loop "&str(n)&" of "&str(num_loop));

      run_parallel;   put_line ("Finished job 1 in loop "&str(n)&" of "&str(num_loop));
      run_parallel;   put_line ("Finished job 2 in loop "&str(n)&" of "&str(num_loop));
      run_parallel;   put_line ("Finished job 3 in loop "&str(n)&" of "&str(num_loop));

      put_line ("Done loop "&str(n)&" of "&str(num_loop));

   end loop;

   for t in 1 .. num_tasks loop
      the_tasks (t).stop_task;
   end loop;

end ex2a;

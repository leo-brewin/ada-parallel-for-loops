package body Support.Parallel is

   max_tasks : Constant := 64;
   num_tasks : Integer  := 1;
   beg_end   : Array (1..max_tasks,1..2) of Integer;

   procedure ini_parallel (i_min, i_max  : Integer;
                           the_num_tasks : Integer)
   is
      i_step : Integer;
      i_beg, i_end : Integer;
   begin

      -- LCB: raise an exception if the_num_tasks > max_tasks?
      num_tasks := min (the_num_tasks, max_tasks);

      i_step := (i_max - i_min) / num_tasks;

      i_beg := i_min;
      i_end := min (i_beg + i_step, i_max);

      for t in 1 .. num_tasks loop

         beg_end (t,1) := i_beg;
         beg_end (t,2) := i_end;

         i_beg := i_end + 1;
         i_end := min (i_beg + i_step, i_max);

      end loop;

   end ini_parallel;

   procedure run_parallel (run_serial : access procedure
                                          (task_id      : Integer;
                                           i_beg, i_end : Integer))
   is

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

         run_serial (my_task_id, my_i_beg, my_i_end);

      end My_Task;

      the_tasks : Array (1..num_tasks) of my_task;

   begin

      for t in 1 .. num_tasks loop

         the_tasks (t).start_task (t, beg_end (t,1), beg_end (t,2));

      end loop;

   end run_parallel;

   procedure run_parallel (run_serial    : access procedure
                                             (task_id      : Integer;
                                              i_beg, i_end : Integer);
                           i_min, i_max  : Integer;
                           the_num_tasks : Integer)
   is

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

         run_serial (my_task_id, my_i_beg, my_i_end);

      end My_Task;

      num_tasks : Integer := the_num_tasks;
      the_tasks : Array (1..num_tasks) of my_task;

   begin

      declare
         i_step : Integer;
         i_beg, i_end : Integer;
      begin

         i_step := (i_max - i_min) / num_tasks;

         i_beg := i_min;
         i_end := min (i_beg + i_step, i_max);

         for t in 1 .. num_tasks loop

            the_tasks (t).start_task (t, i_beg, i_end);

            i_beg := i_end + 1;
            i_end := min (i_beg + i_step, i_max);

         end loop;

      end;

   end run_parallel;

end Support.Parallel;

package Support.Parallel is

   procedure ini_parallel (i_min, i_max  : Integer;
                           the_num_tasks : Integer);

   procedure run_parallel (run_serial : access procedure
                                          (task_id      : Integer;
                                           i_beg, i_end : Integer));

   procedure run_parallel (run_serial    : access procedure
                                             (task_id      : Integer;
                                              i_beg, i_end : Integer);
                           i_min, i_max  : Integer;
                           the_num_tasks : Integer);

end Support.Parallel;

-- LCB: maybe this?
-- procedure run_parallel (Loop_Body : access procedure
--                                        (task_id   : Integer;
--                                         index_beg : Integer;
--                                         index_end : Integer);
--                         index_min : Integer;
--                         index_max : Integer;
--                         the_num_tasks : Integer);

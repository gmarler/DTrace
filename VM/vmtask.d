#!/usr/sbin/dtrace -s

#pragma D option bufsize=64k
#pragma D option aggsize=64k
#pragma D option quiet


fbt::vmtask_run_job:entry
{
  @[execname] = count();
  @t["TOTAL"] = count();
}

tick-1sec
{
  printf("\n%Y\n",walltimestamp);

  /* Truncate to top 40, but since we're printing the total
     along with it, we won't be misled */
  trunc(@,40);

  printa(@);
  printa(@t);

  trunc(@);
  trunc(@t);
}


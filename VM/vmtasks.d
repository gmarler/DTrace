#!/usr/sbin/dtrace -s

#pragma D option bufsize=32k
#pragma D option aggsize=32k
#pragma D option quiet

profile-101Hz
/ execname == "vmtasks" /
{
  @[stack()] = count();
}

tick-1sec
{
  printf("\n%Y\n",walltimestamp);
  trunc(@,20);
  printa(@);
}


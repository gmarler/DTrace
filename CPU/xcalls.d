#!/usr/sbin/dtrace -qs

#pragma D option aggsize=512k
#pragma D option bufsize=512k

xcalls
{
  @[execname, stack()] = sum(arg0);
}

tick-1s
{
  printf("\n%Y\n", walltimestamp);
  trunc(@, 40);
  printa(@);
  trunc(@);
}


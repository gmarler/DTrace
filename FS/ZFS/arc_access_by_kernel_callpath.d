#!/usr/sbin/dtrace -qs

sdt:zfs::arc-hit,
sdt:zfs::arc-miss
{
  @[execname, probefunc, stack()] = count();
}

tick-1min
{
  printf("\n%Y\n",walltimestamp);

  printa(@);
  trunc(@);
}

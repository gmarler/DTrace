#!/usr/sbin/dtrace -qs

sdt:zfs::arc-hit,
sdt:zfs::arc-miss
{
  @[execname] = count();
}

tick-1min
{
  printf("\n%Y\n",walltimestamp);

  printa(@);
  trunc(@);
}

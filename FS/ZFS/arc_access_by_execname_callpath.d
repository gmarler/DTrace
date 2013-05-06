#!/usr/sbin/dtrace -qs

sdt:zfs::arc-miss
/ execname == $$1 /
{
  @[execname, probefunc, ustack()] = count();
}

tick-1min
{
  printf("\n%Y\n",walltimestamp);

  printa(@);
  trunc(@);
}

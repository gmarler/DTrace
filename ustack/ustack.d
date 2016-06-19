#!/usr/sbin/dtrace -qs

#pragma D option destructive

profile-2001Hz
/ execname == "nscd" /
{
  @s1[ustack()] = count();
}

tick-5sec
{
  printa(@s1);
}

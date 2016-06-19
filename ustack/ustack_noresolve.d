#!/usr/sbin/dtrace -qs

#pragma D option noresolve

profile-997Hz
/ execname == "nscd" /
{
  @s1[ustack()] = count();
}

tick-5sec
{
  printa(@s1);
}

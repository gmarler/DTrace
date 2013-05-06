#!/usr/sbin/dtrace -s

#pragma D option quiet

dtrace:::BEGIN
{
  trace("Tracing ARC evicts...\n");
}

fbt::arc_evict:entry
{
  printf("%Y %-10a %-10s %-10s %d bytes\n", walltimestamp, args[0],
         arg4 == 0 ? "data" : "metadata",
         arg3 == 0 ? "evict" : "recycle",  arg2);
}

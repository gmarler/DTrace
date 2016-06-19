#!/usr/sbin/dtrace -s

pid$target::sym_prefer:entry
{
  self->sym1 = arg0;
  self->sym2 = arg2;
}

pid$target::sym_prefer:return
/ (self->sym1 != NULL) || (self->sym2 != NULL) /
{
  this->symtype = (arg1 == self->sym1) ? "SYMTAB" : "DYNSYMTAB";

  @[this->symtype] = count();

  self->sym1 = 0;
  self->sym2 = 0;
}

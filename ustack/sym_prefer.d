#!/usr/sbin/dtrace -Cqs

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
  @r[arg1] = count();

  self->sym1 = 0;
  self->sym2 = 0;
}

END {
  printa("%s %@12u\n",@);
  printa("%llx %@12u\n",@r);
}
/*
pid$target::build_map_symtab:return
{
  this->fptr = (file_info_t *)arg1;

  printf("file_dyn_base: %s\n",this->fptr->file_dyn_base);
}
*/

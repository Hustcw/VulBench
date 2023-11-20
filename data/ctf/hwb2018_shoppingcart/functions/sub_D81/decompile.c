int sub_D81()
{
  void *v0;
  __int64 v1;
  __int64 v2;
  _QWORD *v4;

  if ( (unsigned __int64)qword_202098 <= 0x13 )
  {
    puts("I will give you $9999, but what's the  currency type you want, RMB or Dollar?");
    v4 = malloc(0x10uLL);
    v4[1] = 9999LL;
    fgets(&byte_2020A0[8 * qword_202098], 8, stdin);
    *v4 = &byte_2020A0[8 * qword_202098];
    v1 = qword_202098++;
    v2 = 8 * v1;
    v0 = &unk_202140;
    *(_QWORD *)((char *)&unk_202140 + v2) = v4;
  }
  else
  {
    LODWORD(v0) = puts("You already have enough money!");
  }
  return (int)v0;
}

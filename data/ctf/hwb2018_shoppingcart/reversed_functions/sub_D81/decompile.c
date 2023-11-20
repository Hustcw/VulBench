void sub_D81()
{
  __int64 v0;
  Data *v1;

  if ( (unsigned __int64)qword_202098 <= 0x13 )
  {
    puts("I will give you $9999, but what's the  currency type you want, RMB or Dollar?");
    v1 = (Data *)malloc(0x10uLL);
    v1->field_8 = 9999LL;
    fgets(byte_2020A0[qword_202098], 8, stdin);
    v1->field_0 = (__int64)byte_2020A0[qword_202098];
    v0 = qword_202098++;
    byte_202140[v0] = (char *)v1;
  }
  else
  {
    puts("You already have enough money!");
  }
}
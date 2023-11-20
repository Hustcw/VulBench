void sub_9B0()
{
  __int64 v0;
  unsigned __int64 size;
  Data *v2;
  char s[24];
  unsigned __int64 v4;

  v4 = __readfsqword(0x28u);
  if ( (unsigned __int64)qword_202090 <= 0x13 )
  {
    puts("How long is your goods name?");
    fgets(s, 24, stdin);
    size = strtoul(s, 0LL, 0);
    v2 = (Data *)malloc(0x10uLL);
    v2->field_8 = 999LL;
    v2->field_0 = (char *)malloc(size);
    puts("What is your goods name?");
    v2->field_0[(int)read(0, v2->field_0, size) - 1] = 0;
    v0 = qword_202090++;
    qword_2021E0[v0] = v2;
  }
  else
  {
    puts("Your shopping cart is full now!");
  }
}
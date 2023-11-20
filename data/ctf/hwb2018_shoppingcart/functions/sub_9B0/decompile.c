unsigned __int64 sub_9B0()
{
  __int64 v0;
  unsigned __int64 size;
  void **v3;
  char s[24];
  unsigned __int64 v5;

  v5 = __readfsqword(0x28u);
  if ( (unsigned __int64)qword_202090 <= 0x13 )
  {
    puts("How long is your goods name?");
    fgets(s, 24, stdin);
    size = strtoul(s, 0LL, 0);
    v3 = (void **)malloc(0x10uLL);
    v3[1] = &stru_3D8 + 15;
    *v3 = malloc(size);
    puts("What is your goods name?");
    *((_BYTE *)*v3 + (int)read(0, *v3, size) - 1) = 0;
    v0 = qword_202090++;
    qword_2021E0[v0] = v3;
  }
  else
  {
    puts("Your shopping cart is full now!");
  }
  return __readfsqword(0x28u) ^ v5;
}

void __fastcall read_str(char *a1, int a2)
{
  char buf; // [rsp+13h] [rbp-Dh] BYREF
  int i; // [rsp+14h] [rbp-Ch]
  unsigned __int64 v4; // [rsp+18h] [rbp-8h]

  v4 = __readfsqword(0x28u);
  for ( i = 0; i < a2; ++i )
  {
    if ( (unsigned int)read(0, &buf, 1uLL) == -1 )
    {
      puts("error!");
      exit(0);
    }
    a1[i] = buf;
    if ( buf == 10 )
    {
      a1[i] = 0;
      return;
    }
  }
  a1[i - 1] = 0;
}
int __fastcall sub_89A(const char *a1, unsigned __int64 a2)
{
  int v2;
  char buf;
  int v5;
  unsigned __int64 v6;

  v6 = __readfsqword(0x28u);
  v5 = 0;
  while ( v5 + 1 < a2 && (unsigned int)read(0, &buf, 1uLL) != -1 )
  {
    if ( buf == 32 || buf == 10 || !buf )
    {
      a1[v5] = 0;
      break;
    }
    if ( buf > 57 || buf <= 47 )
      fault();
    v2 = v5++;
    a1[v2] = buf;
  }
  a1[v5] = 0;
  return atoi(a1);
}
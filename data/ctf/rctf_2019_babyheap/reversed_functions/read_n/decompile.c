__int64 __fastcall read_n(char *a1, unsigned int a2)
{
  int v3;

  v3 = read(0, a1, a2);
  if ( v3 < 0 )
  {
    puts("read() error");
    exit(0);
  }
  if ( v3 && a1[v3 - 1] == 10 )
    a1[v3 - 1] = 0;
  return (unsigned int)v3;
}
__int64 __fastcall secure_read(void *a1, unsigned int a2)
{
  int v3;

  v3 = read(0, a1, a2);
  if ( v3 < 0 )
  {
    puts("Do you want a flag?");
    exit(0);
  }
  if ( *((_BYTE *)a1 + v3 - 1) == 10 )
    *((_BYTE *)a1 + v3 - 1) = 0;
  return (unsigned int)v3;
}

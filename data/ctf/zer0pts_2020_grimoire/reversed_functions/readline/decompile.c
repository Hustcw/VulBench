__int64 __fastcall readline(void *a1, int a2)
{
  unsigned int v3;

  v3 = read(0, a1, a2);
  if ( *((_BYTE *)a1 + (int)v3 - 1) == 10 )
    --v3;
  if ( !v3 )
  {
    error("read", "Received nothing");
    exit(1);
  }
  *((_BYTE *)a1 + (int)v3) = 0;
  return v3;
}
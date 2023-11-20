void __fastcall secure_read(char *a1, unsigned int a2)
{
  int v2;

  v2 = read(0, a1, a2);
  if ( v2 < 0 )
  {
    puts("Do you want a flag?");
    exit(0);
  }
  if ( a1[v2 - 1] == 10 )
    a1[v2 - 1] = 0;
}
void __fastcall get_input(char *a1, int a2)
{
  int v2; // [rsp+10h] [rbp-10h]
  char *v3; // [rsp+18h] [rbp-8h]

  v2 = 0;
  while ( 1 )
  {
    v3 = &a1[v2];
    if ( (int)fread(v3, 1uLL, 1uLL, stdin) <= 0 )
      break;
    if ( *v3 == 10 )
    {
      if ( v2 )
      {
        *v3 = 0;
        return;
      }
    }
    else if ( a2 + 1 <= (unsigned int)++v2 )
    {
      return;
    }
  }
}
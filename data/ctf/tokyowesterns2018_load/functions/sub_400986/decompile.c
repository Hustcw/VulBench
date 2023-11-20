void __fastcall sub_400986(char *a1, int a2)
{
  char *v2;

  if ( a2 >= 0 )
  {
    fgets(a1, a2, stdin);
    v2 = strchr(a1, 10);
    if ( v2 )
      *v2 = 0;
  }
}

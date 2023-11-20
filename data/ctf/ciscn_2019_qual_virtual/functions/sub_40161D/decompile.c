void __fastcall sub_40161D(__int64 a1, char *a2)
{
  int v2;
  int i;
  const char *s1;
  _QWORD *ptr;

  if ( a1 )
  {
    ptr = malloc(8LL * *(int *)(a1 + 8));
    v2 = 0;
    for ( s1 = strtok(a2, delim); v2 < *(_DWORD *)(a1 + 8) && s1; s1 = strtok(0LL, delim) )
    {
      if ( !strcmp(s1, "push") )
      {
        ptr[v2] = 17LL;
      }
      else if ( !strcmp(s1, "pop") )
      {
        ptr[v2] = 18LL;
      }
      else if ( !strcmp(s1, "add") )
      {
        ptr[v2] = 33LL;
      }
      else if ( !strcmp(s1, "sub") )
      {
        ptr[v2] = 34LL;
      }
      else if ( !strcmp(s1, "mul") )
      {
        ptr[v2] = 35LL;
      }
      else if ( !strcmp(s1, "div") )
      {
        ptr[v2] = 36LL;
      }
      else if ( !strcmp(s1, "load") )
      {
        ptr[v2] = 49LL;
      }
      else if ( !strcmp(s1, "save") )
      {
        ptr[v2] = 50LL;
      }
      else
      {
        ptr[v2] = 255LL;
      }
      ++v2;
    }
    for ( i = v2 - 1; i >= 0 && (unsigned int)sub_40144E(a1, ptr[i]); --i )
      ;
    free(ptr);
  }
}

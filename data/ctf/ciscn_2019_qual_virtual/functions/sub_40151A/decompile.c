void __fastcall sub_40151A(__int64 a1, char *a2)
{
  int v2;
  int i;
  const char *nptr;
  _QWORD *ptr;

  if ( a1 )
  {
    ptr = malloc(8LL * *(int *)(a1 + 8));
    v2 = 0;
    for ( nptr = strtok(a2, delim); v2 < *(_DWORD *)(a1 + 8) && nptr; nptr = strtok(0LL, delim) )
      ptr[v2++] = atol(nptr);
    for ( i = v2 - 1; i >= 0 && (unsigned int)sub_40144E(a1, ptr[i]); --i )
      ;
    free(ptr);
  }
}

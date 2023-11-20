__int64 __fastcall doheap(int a1)
{
  unsigned int v2;
  unsigned int v3;
  unsigned int v4;
  int i;
  int v6;
  int v7;
  __int64 s[128];
  char nptr[24];
  unsigned __int64 v10;

  v10 = __readfsqword(0x28u);
  memset(s, 0, sizeof(s));
  sendstr(a1, "Help yourself with the following functions :\n");
  while ( 1 )
  {
    sendstr(a1, "   1. Alloc\n   2. Free\n   3. Read into chunk\n   4. View chunks\n   5. Return\n");
    sendstr(a1, "Your choice > ");
    recvlen_until(a1, nptr, 0x10uLL, "\n");
    switch ( nptr[0] )
    {
      case '1':
        sendstr(a1, "Choose chunk > ");
        recvlen_until(a1, nptr, 0x10uLL, "\n");
        v2 = atoi(nptr);
        if ( v2 <= 0x7F )
        {
          sendstr(a1, "Choose size > ");
          recvlen_until(a1, nptr, 0x10uLL, "\n");
          v6 = atoi(nptr);
          s[v2] = (__int64)malloc(v6);
          dprintf(a1, "Allocated chunk %d @ %016llx\n", v2, s[v2]);
        }
        continue;
      case '2':
        sendstr(a1, "Choose chunk > ");
        recvlen_until(a1, nptr, 0x10uLL, "\n");
        v3 = atoi(nptr);
        if ( v3 <= 0x7F )
          free((void *)s[v3]);
        continue;
      case '3':
        sendstr(a1, "Choose chunk > ");
        recvlen_until(a1, nptr, 0x10uLL, "\n");
        v4 = atoi(nptr);
        if ( v4 <= 0x7F )
        {
          sendstr(a1, "Choose size > ");
          recvlen_until(a1, nptr, 0x10uLL, "\n");
          v7 = atoi(nptr);
          recvlen(a1, s[v4], v7);
        }
        goto LABEL_11;
      case '4':
LABEL_11:
        for ( i = 0; i <= 127 && s[i]; ++i )
          dprintf(a1, "[%16llx]", s[i]);
        dprintf(a1, "\n");
        break;
      case '5':
        return 0LL;
      default:
        continue;
    }
  }
}

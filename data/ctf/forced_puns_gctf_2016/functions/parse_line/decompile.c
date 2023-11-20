__int64 __fastcall parse_line(unsigned int a1, char *nptr)
{
  unsigned int v2;
  int v5;
  __int64 v6;
  __int64 v7;
  __int64 i;
  int v9;
  __int64 v10;
  void *v11;
  _QWORD *v12;
  __int64 v13;
  void *v14;
  __int64 v15;
  size_t v16;

  v2 = a1;
  if ( !a1 )
  {
    v5 = strtol(nptr, 0LL, 10);
    switch ( v5 )
    {
      case 1:
        v10 = root;
        if ( root )
        {
          while ( *(_QWORD *)(v10 + 16) )
            v10 = *(_QWORD *)(v10 + 16);
          v2 = 1;
          v11 = malloc(0x100uLL);
          *(_QWORD *)(v10 + 16) = v11;
          if ( !v11 )
            err(1, "out of memory");
        }
        else
        {
          v2 = 1;
          root = (__int64)malloc(0x100uLL);
          v16 = malloc_usable_size((void *)root);
          printf("malloc_usable_size is %d, and sizeof(struct entry) is %d\n", v16, 256LL);
        }
        return v2;
      case 2:
        for ( i = root; i; i = *(_QWORD *)(i + 16) )
        {
          printf("Name: %s\n", (const char *)(i + 24));
          printf("Small: %s\n", *(const char **)(i + 8));
          printf("Large: %p\n", *(const void **)i);
          if ( !*(_QWORD *)(i + 16) )
            break;
          puts("-- next --");
        }
        return v2;
      case 3:
        exit(1);
    }
    if ( write(
           0,
           "\n"
           "What is the fastest liquid on earth?\n"
           "Milk, because it is pasteurized before you see it\n"
           "\n"
           "Also, you made an error somewhere\n",
           0x7BuLL) == 123 )
      return 0LL;
    goto LABEL_23;
  }
  if ( a1 != 1 )
  {
    switch ( a1 )
    {
      case 2u:
        v2 = 1;
        v15 = (*(__int64 (__fastcall **)(__int64))fp)(root);
        strcpy((char *)(v15 + 24), nptr);
        return v2;
      case 3u:
        v6 = (*(__int64 (__fastcall **)(__int64))fp)(root);
        v7 = __strdup(nptr);
        *(_QWORD *)(v6 + 8) = v7;
        if ( !v7 )
          err(1, "out of memory setting tmp->small");
        break;
      case 4u:
        v12 = (_QWORD *)(*(__int64 (__fastcall **)(__int64))fp)(root);
        v13 = strtoll(nptr, 0LL, 10);
        v14 = malloc(v13);
        *v12 = v14;
        if ( !v14 )
          err(1, "out of memory setting tmp->large");
        break;
      default:
        return v2;
    }
    return 1LL;
  }
  v9 = strtol(nptr, 0LL, 10);
  switch ( v9 )
  {
    case 1:
      return 2;
    case 2:
      return 3;
    case 3:
      return 4;
    case 4:
      return 0;
  }
  if ( write(
         0,
         "\nWho is General Failure, and why is he reading my hard disk?!\n\nAlso, you made an error somewhere\n",
         0x61uLL) != 97 )
LABEL_23:
    err(1, "writing error message");
  return 1LL;
}

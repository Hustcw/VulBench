void __fastcall __noreturn main(__int64 a1, char **a2, char **a3)
{
  int v3; // [rsp+4h] [rbp-Ch]

  while ( 1 )
  {
    while ( 1 )
    {
      v3 = read_int();
      if ( v3 != 2 )
        break;
      free_mem();
    }
    if ( v3 > 2 )
    {
      if ( v3 == 3 )
      {
        print_mem();
      }
      else if ( v3 == 4 )
      {
        exit(0);
      }
    }
    else if ( v3 == 1 )
    {
      alloc_mem();
    }
  }
}
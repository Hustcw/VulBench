int __cdecl __noreturn main(int argc, const char **argv, const char **envp)
{
  int v3; // [rsp+8h] [rbp-18h] BYREF
  unsigned int v4; // [rsp+Ch] [rbp-14h] BYREF
  unsigned int v5; // [rsp+10h] [rbp-10h] BYREF
  unsigned int v6; // [rsp+14h] [rbp-Ch] BYREF
  unsigned __int64 v7; // [rsp+18h] [rbp-8h]

  v7 = __readfsqword(0x28u);
  setbuf(stdin, 0LL);
  setbuf(stdout, 0LL);
  flag = (__int64)dword_206CE0;
  dword_206CE0[0] = -1;
  menu();
  while ( 1 )
  {
    __isoc99_scanf("%d", &v3);
    if ( v3 == 2 )
    {
      puts("input from and to:");
      __isoc99_scanf("%d%d", &v4, &v5);
      if ( v4 > 0x1D || v5 > 0x1D )
        goto LABEL_11;
      SPFA(v4, v5);
    }
    else
    {
      if ( v3 > 2 )
      {
        if ( v3 == 3 )
          getflag();
        if ( v3 == 4 )
          exit(0);
LABEL_18:
        exit(0);
      }
      if ( v3 != 1 )
        goto LABEL_18;
      puts("input from to and length:");
      __isoc99_scanf("%d%d%d", &v4, &v5, &v6);
      if ( (unsigned int)check(v4, v5, v6) )
      {
        add(v4, v5, v6);
        puts("add succeed");
      }
      else
      {
LABEL_11:
        puts("don't think that");
      }
    }
  }
}
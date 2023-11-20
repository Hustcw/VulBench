_QWORD qword_4060[20];
_QWORD qword_4060[20];
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

int read_int()
{
  char nptr[8]; // [rsp+0h] [rbp-20h] BYREF
  __int64 v2; // [rsp+8h] [rbp-18h]
  int v3; // [rsp+10h] [rbp-10h]
  unsigned __int64 v4; // [rsp+18h] [rbp-8h]

  v4 = __readfsqword(0x28u);
  *(_QWORD *)nptr = 0LL;
  v2 = 0LL;
  v3 = 0;
  read_str(nptr, 16);
  return atoi(nptr);
}

__int64 __fastcall read_str(char *a1, unsigned int a2)
{
  unsigned int i; // [rsp+14h] [rbp-Ch]

  for ( i = 0; (int)i < (int)a2; ++i )
  {
    read(0, &a1[i], 1uLL);
    if ( a1[i] == 10 )
    {
      a1[i] = 0;
      return i;
    }
  }
  fflush(stdin);
  return a2;
}

unsigned __int64 free_mem()
{
  unsigned int v1; // [rsp+4h] [rbp-Ch]
  unsigned __int64 v2; // [rsp+8h] [rbp-8h]

  v2 = __readfsqword(0x28u);
  printf("idx:");
  v1 = read_int();
  if ( v1 <= 0x13 && qword_4060[v1] )
  {
    free((void *)qword_4060[v1]);
    puts("Done!");
  }
  else
  {
    puts("invalid");
  }
  return __readfsqword(0x28u) ^ v2;
}

unsigned __int64 print_mem()
{
  unsigned int v1; // [rsp+4h] [rbp-Ch]
  unsigned __int64 v2; // [rsp+8h] [rbp-8h]

  v2 = __readfsqword(0x28u);
  printf("idx:");
  v1 = read_int();
  if ( v1 <= 0x13 && qword_4060[v1] )
    puts((const char *)qword_4060[v1]);
  else
    puts("invalid");
  return __readfsqword(0x28u) ^ v2;
}

unsigned __int64 sub_134D()
{
  int i; // [rsp+0h] [rbp-10h]
  int v2; // [rsp+4h] [rbp-Ch]
  unsigned __int64 v3; // [rsp+8h] [rbp-8h]

  v3 = __readfsqword(0x28u);
  printf("size:");
  v2 = read_int();
  if ( v2 > 0 && v2 <= 4095 )
  {
    for ( i = 0; i <= 19 && qword_4060[i]; ++i )
      ;
    if ( i <= 19 )
    {
      qword_4060[i] = malloc(v2);
      printf("content:");
      read_str((char *)qword_4060[i], v2);
      puts("Done!");
    }
    else
    {
      puts("full");
    }
  }
  else
  {
    puts("invalid");
  }
  return __readfsqword(0x28u) ^ v3;
}
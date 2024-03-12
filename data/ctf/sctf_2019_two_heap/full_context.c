struct Data
{
  int field_0;
  char *field_8;
};

Data off_4020[16] =
{
  { 128, NULL },
  { 128, NULL },
  { 128, NULL },
  { 128, NULL },
  { 128, NULL },
  { 128, NULL },
  { 128, NULL },
  { 128, NULL },
  { 128, NULL },
  { 128, NULL },
  { 128, NULL },
  { 128, NULL },
  { 128, NULL },
  { 128, NULL },
  { 128, NULL },
  { 128, NULL },
};
__int64 end;

void __fastcall __noreturn main(int rdi0, char **a2, char **a3)
{
  int v3;
  _BYTE a1[8];
  int v5;
  unsigned __int64 v6;

  v6 = __readfsqword(0x28u);
  *(_QWORD *)a1 = 0LL;
  v5 = 0;
  puts("Welcome to SCTF:");
  sub_1350(a1, 11);
  __printf_chk(1LL, a1, 0xFFFFFFFFLL, 0xFFFFFFFFLL, 0xFFFFFFFFLL);
  while ( 1 )
  {
    while ( 1 )
    {
      v3 = sub_1440();
      if ( v3 != 1 )
        break;
      sub_14A0();
    }
    if ( v3 != 2 )
    {
      puts("exit.");
      exit(0);
    }
    sub_15A0();
  }
}

void __fastcall sub_1350(_BYTE *a1, int a2)
{
  _BYTE *v2;
  char v3;
  char buf;
  unsigned __int64 v5;

  v5 = __readfsqword(0x28u);
  if ( a2 > 0 )
  {
    v2 = a1;
    do
    {
      buf = 0;
      if ( read(0, &buf, 1uLL) <= 0 )
        exit(0);
      v3 = buf;
      *v2 = buf;
      if ( v3 == 10 )
        break;
      ++v2;
    }
    while ( v2 != &a1[a2 - 1 + 1] );
  }
}

__int64 sub_13E0()
{
  __int64 v1[3];

  v1[1] = __readfsqword(0x28u);
  v1[0] = 0LL;
  sub_1350(v1, 8LL);
  return strtol((const char *)v1, 0LL, 10);
}

__int64 sub_1440()
{
  puts("1. new");
  puts("2. delete");
  printf("Your choice:");
  return sub_13E0();
}

void sub_14A0()
{
  Data *v0;
  __int64 v1;
  Data *v2;
  int v3;
  char *v4;
  Data *v5;

  v0 = off_4020;
  v1 = 0LL;
  v2 = off_4020;
  while ( v2->field_8 )
  {
    ++v1;
    ++v2;
    if ( v1 == 8 )
      goto LABEL_4;
  }
  puts("Input the size:");
  v3 = sub_13E0() & 0xFFFFFFF8;
  if ( v3 > 128 )
    goto LABEL_4;
  do
  {
    if ( v0->field_0 == v3 )
    {
      puts("I don't like the same size!");
      exit(0);
    }
    ++v0;
  }
  while ( &end != (FILE **)v0 );
  v4 = (char *)malloc(v3);
  if ( !v4 )
LABEL_4:
    exit(0);
  puts("Input the note:");
  v5 = &off_4020[v1];
  sub_1350(v4, v3);
  v5->field_0 = v3;
  v5->field_8 = v4;
}

void sub_15A0()
{
  int v0;

  puts("Input the index:");
  v0 = sub_13E0();
  if ( (unsigned __int64)v0 > 7 )
    exit(0);
  free(off_4020[v0].field_8);
}
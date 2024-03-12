struct Note
{
  char title[8];
  char content[104];
};

int dword_202010 = 3; // weak
Note* qword_202040[10];

void __fastcall __noreturn main(__int64 a1, char **a2, char **a3)
{
  int v3; // [rsp+4h] [rbp-24h] BYREF
  unsigned __int64 v4; // [rsp+8h] [rbp-20h]

  v4 = __readfsqword(0x28u);
  sub_A40();
  while ( 1 )
  {
    sub_A70();
    __isoc99_scanf("%d", &v3);
    _IO_getc(stdin);
    if ( v3 == 1 )
    {
      new_note();
    }
    else if ( v3 == 2 )
    {
      free_note();
    }
    else
    {
      puts("invalid choice");
    }
  }
}

__int64 sub_A70()
{
  puts("1.new_note");
  puts("2.free_note");
  return __printf_chk(1LL, ">> ");
}

void new_note()
{
  __int64 v0; // rax
  __int64 v1; // rbx

  v0 = 1LL;
  if ( qword_202040[0] )
  {
    do
      v1 = (int)v0++;
    while ( qword_202040[v1] );
  }
  else
  {
    v1 = 0LL;
  }
  qword_202040[v1] = (Note *)malloc(0x70uLL);
  puts("title:");
  read(0, qword_202040[v1], 8uLL);
  puts("content:");
  read(0, qword_202040[v1]->content, 0x68uLL);
  __printf_chk(1LL, "%s %s", qword_202040[v1]->title, qword_202040[v1]->content);
}

void free_note()
{
  Note *v0; // rdi
  unsigned int v1; // [rsp+4h] [rbp-14h] BYREF
  unsigned __int64 v2; // [rsp+8h] [rbp-10h]

  v2 = __readfsqword(0x28u);
  if ( dword_202010 )
  {
    puts("index:");
    __isoc99_scanf("%d", &v1);
    _IO_getc(stdin);
    if ( v1 <= 9 )
    {
      v0 = qword_202040[v1];
      if ( v0 )
      {
        free(v0);
        --dword_202010;
      }
    }
  }
  else
  {
    puts("no more free available");
  }
}
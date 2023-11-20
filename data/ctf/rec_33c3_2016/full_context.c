

void __cdecl read_str(char *a1, unsigned int a2)
{
  unsigned int v2;
  int v3;
  unsigned int i;

  v3 = getchar();
  for ( i = 0; i < a2 && v3 != -1 && v3 != 10; ++i )
  {
    v2 = i;
    a1[v2] = v3;
    v3 = getchar();
  }
  a1[i] = 0;
  a1[a2 - 1] = 0;
}

void sub_732()
{
  int v0;
  int v1;
  char v2[2];
  char nptr[12];
  unsigned int v4;

  v4 = __readgsdword(0x14u);
  printf("Operand: ");
  read_str(nptr, 0xCu);
  v0 = atoi(nptr);
  printf("Operand: ");
  read_str(nptr, 0xCu);
  v1 = atoi(nptr);
  printf("Operator: ");
  read_str(v2, 2u);
  if ( v2[0] == 43 )
    printf("Result: %d\n", v0 + v1);
  if ( v2[0] == 45 )
    printf("Result: %d\n", v0 - v1);
  if ( v2[0] == 42 )
    printf("Result: %d\n", v1 * v0);
  if ( v2[0] == 47 )
    printf("Result: %d\n", v0 / v1);
}

void sub_87B()
{
  int v0;
  int v1;
  char a1[2];
  char nptr[12];
  unsigned int v4;

  v4 = __readgsdword(0x14u);
  printf("Operand: ");
  read_str(nptr, 0xCu);
  v0 = atoi(nptr);
  printf("Operator: ");
  read_str(a1, 2u);
  printf("Operand: ");
  read_str(nptr, 0xCu);
  v1 = atoi(nptr);
  if ( a1[0] == 43 )
    printf("Result: %d\n", v0 + v1);
  if ( a1[0] == 45 )
    printf("Result: %d\n", v0 - v1);
  if ( a1[0] == 42 )
    printf("Result: %d\n", v1 * v0);
  if ( a1[0] == 47 )
    printf("Result: %d\n", v0 / v1);
  if ( __readgsdword(0x14u) != v4 )
    sub_1030();
}

int __cdecl sub_9C4(int a1, int a2)
{
  return printf("Result: %d\n", a1 + a2);
}

int __cdecl sub_9F8(int a1, int a2)
{
  return printf("Result: %d\n", a1 - a2);
}

int __cdecl sub_A2A(int a1, int a2)
{
  return printf("Result: %d\n", a2 * a1);
}

int __cdecl sub_A5D(int a1, int a2)
{
  return printf("Result: %d\n", a1 / a2);
}

int __cdecl sub_A91(int a1)
{
  return a1;
}

void sub_AA3()
{
  int v0;
  int v1;
  int v2;
  int v3;
  char a1[2];
  char nptr[12];
  unsigned int v6;

  v6 = __readgsdword(0x14u);
  v2 = 0;
  printf("Operator: ");
  read_str(a1, 2u);
  if ( a1[0] == 83 )
  {
    printf("Operand: ");
    read_str(nptr, 0xCu);
    v0 = atoi(nptr);
    while ( nptr[0] != 46 )
    {
      v2 += ((int (__stdcall *)(int, int))sub_A91)(v0, v0);
      printf("Operand: ");
      read_str(nptr, 0xCu);
      v0 = atoi(nptr);
    }
    printf("Sum: %d\n", v2);
  }
  else
  {
    printf("Operand: ");
    read_str(nptr, 0xCu);
    v1 = atoi(nptr);
    printf("Operand: ");
    read_str(nptr, 0xCu);
    v3 = atoi(nptr);
    if ( a1[0] == 43 )
      sub_9C4(v1, v3);
    if ( a1[0] == 45 )
      sub_9F8(v1, v3);
    if ( a1[0] == 42 )
      sub_A2A(v1, v3);
    if ( a1[0] == 47 )
      sub_A5D(v1, v3);
  }
}

int sub_C85()
{
  return puts("Positive");
}

int sub_CB0()
{
  return puts("Negative");
}

void sub_CDB()
{
  unsigned int result;
  void (*v1)(void);
  int v2;
  char nptr[12];
  unsigned int v4;

  v4 = __readgsdword(0x14u);
  read_str(nptr, 0xCu);
  v2 = atoi(nptr);
  if ( v2 <= 0 )
  {
    if ( v2 < 0 )
      v1 = (void (*)(void))sub_CB0;
  }
  else
  {
    v1 = (void (*)(void))sub_C85;
  }
  v1();
}

void sub_D57()
{
  unsigned int v0;

  v0 = __readgsdword(0x14u);
  sub_CDB();
}

void __cdecl sub_D8E(int a1)
{
  char s[20];
  unsigned int v2;

  v2 = __readgsdword(0x14u);
  printf("Your note: ");
  if ( a1 )
    read_str(s, 0x14u);
  else
    puts(s);
}

void sub_E0E()
{
  unsigned int result;
  char v1[2];
  unsigned int v2;

  v2 = __readgsdword(0x14u);
  do
  {
    puts("0 - Take note");
    puts("1 - Read note");
    puts("2 - Polish");
    puts("3 - Infix");
    puts("4 - Reverse Polish");
    puts("5 - Sign");
    puts("6 - Exit");
    printf("> ");
    read_str(v1, 2u);
    if ( v1[0] == '0' )
      sub_D8E(1);
    if ( v1[0] == '1' )
      sub_D8E(0);
    if ( v1[0] == '2' )
      sub_AA3();
    if ( v1[0] == '3' )
      sub_87B();
    if ( v1[0] == '4' )
      sub_732();
    if ( v1[0] == '5' )
      sub_D57();
  }
  while ( v1[0] != 54 );
}

int __cdecl main(int argc, const char **argv, const char **envp)
{
  setvbuf(stdin, 0, 2, 0);
  setvbuf(stdout, 0, 2, 0);
  puts("Calculators are fun!");
  return sub_E0E();
}

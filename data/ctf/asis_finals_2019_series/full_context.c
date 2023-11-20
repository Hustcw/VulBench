char byte_202048;
__int64 A;
__int64 B;
int n;
__int64 *x;
char byte_202048;
__int64 A;
__int64 B;
int n;
__int64 *x;


void __fastcall __noreturn sub_A97(const char *a1)
{
  fprintf(stderr, "[ABORT] %s\n", a1);
  exit(1);
}

void __fastcall sub_ACC(char *a1, int a2)
{
  int v2;

  v2 = read(0, a1, a2);
  if ( v2 <= 0 )
    sub_A97("Broken pipe");
  a1[v2] = 0;
}

__int64 sub_B1A()
{
  char nptr[8];
  __int64 v2;
  unsigned __int64 v3;

  v3 = __readfsqword(0x28u);
  *(_QWORD *)nptr = 0LL;
  v2 = 0LL;
  sub_ACC(nptr, 32LL);
  return atol(nptr);
}

void sub_B74()
{
  printf("A = ");
  A = read_int();
  printf("B = ");
  B = read_int();
}

void read_nx()
{
  printf("n = ");
  n = read_int();
  x = (__int64 *)malloc(8LL * n);
  if ( !x )
    sub_A97("Could not allocate memory");
}

void read_x0x1()
{
  __int64 *v0;
  __int64 *v1;

  printf("x0 = ");
  v0 = x;
  *v0 = read_int();
  printf("x1 = ");
  v1 = x + 1;
  *v1 = read_int();
}

void sub_C79()
{
  int i;
  __int64 v1;
  __int64 v2;

  for ( i = 2; i < n; ++i )
  {
    v1 = x[i - 2] * A;
    v2 = x[i - 1] * B;
    if ( v1 > 0 && v2 > 0x7FFFFFFFFFFFFFFFLL - v1 || v1 < 0 && v2 < 0x7FFFFFFFFFFFFFFFLL - v1 )
      sub_A97("Overflow detected");
    x[i] = v1 + v2;
  }
}

void sub_D5D()
{
  int v0;

  puts("Calculation Done!");
  while ( 1 )
  {
    printf("i > ");
    v0 = read_int();
    if ( v0 < 0 )
      break;
    printf("x(%d) = %ld\n", (unsigned int)v0, x[v0]);
  }
}

__int64 __fastcall main(int a1, char **a2, char **a3)
{
  FILE *stream;
  char ptr[504];
  unsigned __int64 v6;

  v6 = __readfsqword(0x28u);
  stream = fopen("description.txt", "r");
  if ( !stream )
    sub_A97("File not found");
  fread(ptr, 1uLL, 0x1F8uLL, stream);
  puts(ptr);
  read_AB();
  read_nx();
  read_x0x1();
  sub_C79();
  sub_D5D();
  return 0LL;
}

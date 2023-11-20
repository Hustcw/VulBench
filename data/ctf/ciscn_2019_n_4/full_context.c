struct Nest
{
  __int64 size;
  char *content;
};

Nest *nests[10];
struct Nest
{
  __int64 size;
  char *content;
};

Nest *nests[10];

int __cdecl main(int argc, const char **argv, const char **envp)
{
  char buf[8]; // [rsp+0h] [rbp-10h] BYREF
  unsigned __int64 v5; // [rsp+8h] [rbp-8h]

  v5 = __readfsqword(0x28u);
  setvbuf(_bss_start, 0LL, 2, 0LL);
  setvbuf(stdin, 0LL, 2, 0LL);
  while ( 1 )
  {
    menu();
    read(0, buf, 4uLL);
    switch ( atoi(buf) )
    {
      case 1:
        buildnest();
        break;
      case 2:
        decoratenest();
        break;
      case 3:
        shownest();
        break;
      case 4:
        crash_nest();
        break;
      case 5:
        exit(0);
      default:
        puts("Invalid Choice");
        break;
    }
  }
}

unsigned __int64 buildnest()
{
  Nest *v0; // rbx
  int i; // [rsp+4h] [rbp-2Ch]
  size_t size; // [rsp+8h] [rbp-28h]
  char buf[8]; // [rsp+10h] [rbp-20h] BYREF
  unsigned __int64 v5; // [rsp+18h] [rbp-18h]

  v5 = __readfsqword(0x28u);
  for ( i = 0; i <= 9; ++i )
  {
    if ( !nests[i] )
    {
      nests[i] = (Nest *)malloc(0x10uLL);
      if ( !nests[i] )
      {
        puts("Nope.something wrong..");
        exit(1);
      }
      printf("how big is the nest ?");
      read(0, buf, 8uLL);
      size = atoi(buf);
      v0 = nests[i];
      v0->content = (char *)malloc(size);
      if ( !nests[i]->content )
      {
        puts("Nope.something wrong..");
        exit(2);
      }
      nests[i]->size = size;
      printf("what stuff you wanna put in the nest?");
      myread(nests[i]->content, size);
      puts("Thx buddy.");
      return __readfsqword(0x28u) ^ v5;
    }
  }
  return __readfsqword(0x28u) ^ v5;
}

unsigned __int64 decoratenest()
{
  unsigned int v1; // [rsp+Ch] [rbp-14h]
  char buf[8]; // [rsp+10h] [rbp-10h] BYREF
  unsigned __int64 v3; // [rsp+18h] [rbp-8h]

  v3 = __readfsqword(0x28u);
  printf("Index :");
  read(0, buf, 4uLL);
  v1 = atoi(buf);
  if ( v1 >= 0xA )
  {
    puts("OOB!My Boy!");
    _exit(0);
  }
  if ( nests[v1] )
  {
    printf("what stuff you wanna put in the nest?");
    myread(nests[v1]->content, nests[v1]->size + 1);
    puts("Done !");
  }
  else
  {
    puts("No such nest !");
  }
  return __readfsqword(0x28u) ^ v3;
}

unsigned __int64 shownest()
{
  unsigned int v1; // [rsp+Ch] [rbp-14h]
  char buf[8]; // [rsp+10h] [rbp-10h] BYREF
  unsigned __int64 v3; // [rsp+18h] [rbp-8h]

  v3 = __readfsqword(0x28u);
  printf("Index :");
  read(0, buf, 4uLL);
  v1 = atoi(buf);
  if ( v1 >= 0xA )
  {
    puts("OOB!My Boy!");
    _exit(0);
  }
  if ( nests[v1] )
  {
    printf("Size : %ld\nDecorations : %s\n", nests[v1]->size, nests[v1]->content);
    puts("Done !");
  }
  else
  {
    puts("No such nest !");
  }
  return __readfsqword(0x28u) ^ v3;
}

unsigned __int64 crash_nest()
{
  unsigned int v1; // [rsp+Ch] [rbp-14h]
  char buf[8]; // [rsp+10h] [rbp-10h] BYREF
  unsigned __int64 v3; // [rsp+18h] [rbp-8h]

  v3 = __readfsqword(0x28u);
  printf("Index :");
  read(0, buf, 4uLL);
  v1 = atoi(buf);
  if ( v1 >= 0xA )
  {
    puts("OOB!My Boy!");
    _exit(0);
  }
  if ( nests[v1] )
  {
    free(nests[v1]->content);
    free(nests[v1]);
    nests[v1] = 0LL;
    puts("Now another w0odpeck3r lost his house :(");
  }
  else
  {
    puts("No such nest !");
  }
  return __readfsqword(0x28u) ^ v3;
}

ssize_t __fastcall myread(void *a1, size_t a2)
{
  ssize_t result; // rax

  result = read(0, a1, a2);
  if ( (int)result <= 0 )
  {
    puts("Error");
    _exit(-1);
  }
  return result;
}
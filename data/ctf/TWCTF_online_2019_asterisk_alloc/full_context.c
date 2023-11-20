
int __cdecl main(int argc, const char **argv, const char **envp)
{
  int v4; // [rsp+4h] [rbp-Ch] BYREF
  unsigned __int64 v5; // [rsp+8h] [rbp-8h]

  v5 = __readfsqword(0x28u);
  while ( 1 )
  {
    printf("Your choice: ");
    __isoc99_scanf("%d", &v4);
    switch ( v4 )
    {
      case 1:
        call_malloc();
        break;
      case 2:
        call_calloc();
        break;
      case 3:
        call_realloc();
        break;
      case 4:
        call_free();
        break;
      case 5:
        _exit(0);
      default:
        puts("Invalid choice");
        break;
    }
  }
}

void __fastcall call_malloc()
{
  size_t size; // [rsp+0h] [rbp-10h] BYREF
  unsigned __int64 v1; // [rsp+8h] [rbp-8h]

  v1 = __readfsqword(0x28u);
  if ( !ptr_m )
  {
    printf("Size: ");
    __isoc99_scanf("%ld", &size);
    getchar();
    printf("Data: ");
    ptr_m = malloc(size);
    read(0, ptr_m, size);
  }
}

void call_calloc(void)
{
  size_t size; // [rsp+0h] [rbp-10h] BYREF
  unsigned __int64 v1; // [rsp+8h] [rbp-8h]

  v1 = __readfsqword(0x28u);
  if ( !ptr_c )
  {
    printf("Size: ");
    __isoc99_scanf("%ld", &size);
    getchar();
    ptr_c = calloc(1uLL, size);
    printf("Data: ");
    read(0, ptr_c, size);
  }
}

void call_realloc(void)
{
  size_t size; // [rsp+0h] [rbp-10h] BYREF
  unsigned __int64 v1; // [rsp+8h] [rbp-8h]

  v1 = __readfsqword(0x28u);
  printf("Size: ");
  __isoc99_scanf("%ld", &size);
  getchar();
  ptr_r = realloc(ptr_r, size);
  printf("Data: ");
  read(0, ptr_r, size);
}

void __fastcall call_free()
{
  char v0; // [rsp+7h] [rbp-9h] BYREF
  unsigned __int64 v1; // [rsp+8h] [rbp-8h]

  v1 = __readfsqword(0x28u);
  printf("Which: ");
  __isoc99_scanf("%c", &v0);
  getchar();
  switch ( v0 )
  {
    case 'm':
      free(ptr_m);
      break;
    case 'c':
      free(ptr_c);
      break;
    case 'r':
      free(ptr_r);
      break;
    default:
      puts("Invalid choice");
      break;
  }
}
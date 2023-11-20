int __cdecl main(int argc, const char **argv, const char **envp)
{
  int v4;
  unsigned __int64 v5;

  v5 = __readfsqword(0x28u);
  initialize();
  while ( 1 )
  {
    print_menu();
    printf("Your choice: ");
    __isoc99_scanf("%d", &v4);
    getchar();
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

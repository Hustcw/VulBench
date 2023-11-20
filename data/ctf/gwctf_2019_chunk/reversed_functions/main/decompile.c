int __cdecl __noreturn main(int argc, const char **argv, const char **envp)
{
  int v3;
  unsigned __int64 v4;

  v4 = __readfsqword(0x28u);
  init();
  while ( 1 )
  {
    while ( 1 )
    {
      menu();
      _isoc99_scanf("%d", &v3);
      if ( v3 != 1 )
        break;
      add();
    }
    switch ( v3 )
    {
      case 3:
        delete();
        break;
      case 2:
        show();
        break;
      case 4:
        edit();
        break;
      case 5:
        puts("See you tomorrow~");
        exit(0);
      default:
        puts("Invalid choice!");
        break;
    }
  }
}
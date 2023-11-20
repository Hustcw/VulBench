int __cdecl main(int argc, const char **argv, const char **envp)
{
  setvbuf(stdout, 0LL, 2, 0LL);
  puts("---------------------------");
  while ( 1 )
  {
    switch ( printmenu() )
    {
      case 1:
        add_note();
        break;
      case 2:
        edit_note();
        break;
      case 3:
        remove_note();
        break;
      case 4:
        view_note();
        break;
      case 5:
        exit(0);
      default:
        puts("Invalid");
        break;
    }
  }
}
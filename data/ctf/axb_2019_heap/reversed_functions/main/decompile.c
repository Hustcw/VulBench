int __cdecl __noreturn main(int argc, const char **argv, const char **envp)
{
  int v3;

  banner();
  while ( 1 )
  {
    menu();
    v3 = get_int();
    switch ( v3 )
    {
      case 1:
        add_note();
        break;
      case 2:
        delete_note();
        break;
      case 3:
        puts("None!");
        break;
      case 4:
        edit_note();
        break;
      default:
        puts("No such choices!");
        break;
    }
  }
}
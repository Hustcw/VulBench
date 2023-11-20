void vuln()
{
  NOTE buffer[128];
  int loop_switch;

  loop_switch = 1;
  memset(buffer, 0, sizeof(buffer));
  while ( loop_switch )
  {
    switch ( choose() )
    {
      case 1:
        add_note(buffer);
        break;
      case 2:
        edit_note(buffer);
        break;
      case 3:
        show_note(buffer);
        break;
      case 4:
        dump_notes(buffer);
        break;
      case 5:
        loop_switch = 0;
        break;
      default:
        puts("Invalid option!");
        break;
    }
  }
}

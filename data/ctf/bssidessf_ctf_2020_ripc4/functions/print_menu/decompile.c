void __cdecl print_menu(int type)
{
  puts(&byte_3118);
  print_menu_line("set_input", "Set the input value");
  switch ( type )
  {
    case 1:
      print_menu_line("print", "Print the output value");
      break;
    case 2:
      print_menu_line("print", "Print the output value");
      print_menu_line("set_encoding", "Set the encoding scheme.");
      break;
    case 3:
      print_menu_line("set_key", "Set the RC4 key.");
      print_menu_line("encrypt", "Perform encryption.");
      break;
  }
  print_menu_line("quit", "Quit the Program");
  puts(&byte_3118);
}

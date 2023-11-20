__int64 handle_it()
{
  char buf[24];

  printf("1) sign command\n2) execute command\n>_ ");
  read(0, buf, 4uLL);
  if ( buf[0] == 49 )
  {
    sign_it();
    return 0LL;
  }
  else if ( buf[0] == 50 )
  {
    execute_it();
    return 0LL;
  }
  else
  {
    puts("NOP");
    return 1LL;
  }
}
void auth()
{
  char s2[32];
  unsigned int v1;

  v1 = __readgsdword(0x14u);
  puts("Enter admin password:");
  readline(s2, 32, stdin);
  if ( !strcmp(adminpassword, s2) )
  {
    puts("Authenticated!");
    isadmin = 1;
  }
  else
  {
    puts("Wrong password!");
  }
}
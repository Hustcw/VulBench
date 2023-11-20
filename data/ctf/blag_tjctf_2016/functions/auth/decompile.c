unsigned int auth()
{
  char s2[32];
  unsigned int v2;

  v2 = __readgsdword(0x14u);
  puts("Enter admin password:");
  readline(s2, 32, (FILE *)stdin);
  if ( !strcmp(adminpassword, s2) )
  {
    puts("Authenticated!");
    isadmin = 1;
  }
  else
  {
    puts("Wrong password!");
  }
  return __readgsdword(0x14u) ^ v2;
}

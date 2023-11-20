unsigned int menu()
{
  char s1[8];
  unsigned int v2;

  v2 = __readgsdword(0x14u);
  puts(
    "Commands:\n"
    "\n"
    "list: List all posts.\n"
    "read: Read post.\n"
    "add: Add post.\n"
    "auth: Authenticate as admin.\n"
    "quit: Exactly what it says on the tin.");
  while ( 1 )
  {
    while ( 1 )
    {
      while ( 1 )
      {
        while ( 1 )
        {
          while ( 1 )
          {
            printf("> ");
            readline(s1, 8, (FILE *)stdin);
            if ( strcmp(s1, "list") )
              break;
            listposts();
          }
          if ( strcmp(s1, "read") )
            break;
          readpost();
        }
        if ( strcmp(s1, "add") )
          break;
        addpost();
      }
      if ( strcmp(s1, "auth") )
        break;
      auth();
    }
    if ( !strcmp(s1, "quit") )
      break;
    puts("Invalid command.");
  }
  return __readgsdword(0x14u) ^ v2;
}

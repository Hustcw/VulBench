void sub_400E30()
{
  printf("%s", "database to read from: ");
  fflush(stdout);
  fgets(name, 100, stdin);
  strtok(name, "\n");
  if ( (strstr(name, "flag") || strchr(name, 42) || strchr(name, 63)) && !dword_6020FC )
  {
    puts("You are not allowed access to that database!");
    dword_6020FC = 0;
  }
  else
  {
    dword_6020FC = 1;
    if ( access(name, 0) == -1 )
    {
      puts("Tried to open non-existing database");
    }
    else
    {
      printf("%s", "database to read: ");
      fflush(stdout);
      fgets(nptr, 7, stdin);
      dword_6022A0 = atoi(nptr) + 1;
      pthread_create(&th, 0LL, (void *(*)(void *))start_routine, 0LL);
      pthread_join(th, 0LL);
      dword_6020FC = 0;
    }
  }
}
int sub_400FB7()
{
  int result;

  printf("%s", "database to write to: ");
  fflush(stdout);
  fgets(name, 100, stdin);
  strtok(name, "\n");
  if ( (strstr(name, "flag") || strchr(name, 42) || strchr(name, 63)) && !dword_6020FC )
  {
    result = puts("You are not allowed access to that database!");
    dword_6020FC = 0;
  }
  else
  {
    dword_6020FC = 1;
    if ( access(name, 0) == -1 )
    {
      return puts("Tried to open non-existing database");
    }
    else
    {
      printf("%s", "Database to write to: ");
      fflush(stdout);
      fgets(nptr, 8, stdin);
      printf("%s", "Data to write: ");
      fflush(stdout);
      fgets(byte_602120, 200, stdin);
      dword_6022A0 = atoi(nptr);
      return pthread_create(&newthread, 0LL, (void *(*)(void *))sub_400CE0, 0LL);
    }
  }
  return result;
}

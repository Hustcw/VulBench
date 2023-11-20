int sub_40128B()
{
  printf("%s", "Demo activation code: ");
  fflush(stdout);
  fgets(s2, 36, stdin);
  if ( !strcmp("watevr-sql2019-demo-code-admin", s2) && *((_DWORD *)s2 + 8) == 7955827 )
    return puts("Demo access granted!");
  else
    return puts("Demo access not granted!");
}

__int64 __fastcall drop_privs(const char *a1)
{
  struct passwd *v2;

  v2 = getpwnam(a1);
  if ( v2 )
  {
    if ( chdir(v2->pw_dir) )
    {
      perror("chdir");
      return 1LL;
    }
    else if ( setgroups(0LL, 0LL) )
    {
      perror("setgroups");
      return 1LL;
    }
    else if ( setgid(v2->pw_gid) )
    {
      perror("setgid");
      return 1LL;
    }
    else if ( setuid(v2->pw_uid) )
    {
      perror("setuid");
      return 1LL;
    }
    else
    {
      return 0LL;
    }
  }
  else
  {
    fprintf(stderr, "User %s not found\n", a1);
    return 1LL;
  }
}

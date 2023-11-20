void sign_it()
{
  __int64 v0;
  unsigned int v1;
  char *v2;
  __int64 v3;
  unsigned int v4;
  unsigned int i;
  int v6;
  unsigned __int8 *v7;
  char *s1;

  if ( !exec_guy )
  {
    exec_guy = (ExecGuy *)calloc(36uLL, 1uLL);
    s_exec_guy = exec_guy;
    m_exec_guy = (__int64)&exec_guy->hash[1];
    exec_guy->deny_ptr = deny_command;
    s_exec_guy->success_ptr = exec_command;
  }
  puts("what command do you want to sign?");
  printf(">_ ");
  v6 = read(0, global, 0x100uLL);
  global[v6] = 0;
  s1 = global;
  if ( !strcmp(global, "ls\n") || !strcmp(s1, "pwd\n") || !strcmp(s1, "id\n") || !strcmp(s1, "whoami\n") )
  {
    if ( is_md5 )
    {
      v0 = strlen(s1);
      v1 = strlen(key);
      v2 = key;
      v3 = EVP_md5();
    }
    else
    {
      v0 = strlen(s1);
      v1 = strlen(key);
      v2 = key;
      v3 = EVP_sha1();
    }
    v7 = (unsigned __int8 *)HMAC(v3, (__int64)v2, v1, (__int64)s1, v0, 0LL, (__int64)&v4);
    puts("signature: ");
    for ( i = 0; i < v4; ++i )
      printf("%02x", v7[i]);
  }
  else
  {
    puts("not going to sign that for you...");
  }
}
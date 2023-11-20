void execute_it()
{
  __int64 v0;
  unsigned int v1;
  char *v2;
  __int64 v3;
  unsigned int n;
  unsigned int n_4;
  unsigned int i;
  int v7;
  int v8;
  void *dest;
  void *src;
  char *s;
  char *s1;
  _BYTE *buf;

  if ( !exec_guy )
  {
    exec_guy = (ExecGuy *)calloc(0x24uLL, 1uLL);
    s_exec_guy = exec_guy;
    m_exec_guy = (MExecGuy *)&exec_guy->hash[1];
    exec_guy->deny_ptr = deny_command;
    s_exec_guy->success_ptr = exec_command;
  }
  v7 = is_md5;
  dest = m_exec_guy;
  if ( !is_md5 )
    dest = s_exec_guy;
  puts("what command do you want to run?");
  printf(">_ ");
  v8 = read(0, global, 0x100uLL);
  global[v8] = 0;
  s = global;
  if ( is_md5 )
  {
    v0 = strlen(s);
    v1 = strlen(key);
    v2 = key;
    v3 = EVP_md5();
  }
  else
  {
    v0 = strlen(s);
    v1 = strlen(key);
    v2 = key;
    v3 = EVP_sha1();
  }
  src = (void *)HMAC(v3, (__int64)v2, v1, (__int64)s, v0, 0LL, (__int64)&n);
  memcpy(dest, src, n);
  s1 = (char *)calloc(1uLL, 2 * n + 1);
  buf = calloc(1uLL, 2 * n + 1);
  printf("gimme signature:\n>_ ");
  v8 = read(0, buf, 2 * n + 1);
  for ( n_4 = 0; 2 * n + 1 > n_4; ++n_4 )
  {
    if ( buf[n_4] == 10 )
    {
      buf[n_4] = 0;
      break;
    }
  }
  for ( i = 0; i < n; ++i )
    sprintf(&s1[2 * i], "%02x", *((unsigned __int8 *)src + i));
  if ( !strcmp(s1, buf) )
    m_exec_guy->success_ptr(global);
  else
    m_exec_guy->deny_ptr(global);
}
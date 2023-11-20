unsigned __int64 execute_it()
{
  size_t v0;
  unsigned int v1;
  char *v2;
  __int64 v3;
  unsigned int n;
  signed int n_4;
  unsigned int i;
  int v8;
  int v9;
  void *dest;
  void *src;
  char *s;
  char *s1;
  void *buf;
  unsigned __int64 v15;

  v15 = __readfsqword(0x28u);
  if ( !exec_guy )
  {
    exec_guy = (__int64)calloc(0x24uLL, 1uLL);
    s_exec_guy = exec_guy;
    m_exec_guy = exec_guy + 1;
    *(_QWORD *)(exec_guy + 20) = deny_command;
    *(_QWORD *)(s_exec_guy + 28) = exec_command;
  }
  v8 = byte_602240;
  dest = (void *)m_exec_guy;
  if ( !byte_602240 )
    dest = (void *)s_exec_guy;
  puts("what command do you want to run?");
  printf(">_ ");
  v9 = read(0, global, 0x100uLL);
  global[v9] = 0;
  s = global;
  if ( byte_602240 )
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
  src = (void *)HMAC(v3, v2, v1, s, v0, 0LL, &n);
  memcpy(dest, src, n);
  s1 = (char *)calloc(1uLL, 2 * n + 1);
  buf = calloc(1uLL, 2 * n + 1);
  printf("gimme signature:\n>_ ");
  v9 = read(0, buf, 2 * n + 1);
  for ( n_4 = 0; 2 * n + 1 > n_4; ++n_4 )
  {
    if ( *((_BYTE *)buf + n_4) == 10 )
    {
      *((_BYTE *)buf + n_4) = 0;
      break;
    }
  }
  for ( i = 0; i < n; ++i )
    sprintf(&s1[2 * i], "%02x", *((unsigned __int8 *)src + i));
  if ( !strcmp(s1, (const char *)buf) )
    (*(void (__fastcall **)(char *))(m_exec_guy + 27))(global);
  else
    (*(void (__fastcall **)(char *))(m_exec_guy + 19))(global);
  puts(byte_40165B);
  return __readfsqword(0x28u) ^ v15;
}

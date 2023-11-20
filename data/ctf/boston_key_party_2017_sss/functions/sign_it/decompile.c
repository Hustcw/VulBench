unsigned __int64 sign_it()
{
  size_t v0;
  unsigned int v1;
  char *v2;
  __int64 v3;
  unsigned int v5;
  unsigned int i;
  int v7;
  __int64 v8;
  char *s1;
  unsigned __int64 v10;

  v10 = __readfsqword(0x28u);
  if ( !exec_guy )
  {
    exec_guy = (__int64)calloc(0x24uLL, 1uLL);
    s_exec_guy = exec_guy;
    m_exec_guy = exec_guy + 1;
    *(_QWORD *)(exec_guy + 20) = deny_command;
    *(_QWORD *)(s_exec_guy + 28) = exec_command;
  }
  puts("what command do you want to sign?");
  printf(">_ ");
  v7 = read(0, global, 0x100uLL);
  global[v7] = 0;
  s1 = global;
  if ( !strcmp(global, "ls\n") || !strcmp(s1, "pwd\n") || !strcmp(s1, "id\n") || !strcmp(s1, "whoami\n") )
  {
    if ( byte_602240 )
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
    v8 = HMAC(v3, v2, v1, s1, v0, 0LL, &v5);
    puts("signature: ");
    for ( i = 0; i < v5; ++i )
      printf("%02x", *(unsigned __int8 *)(i + v8));
    puts(byte_40165B);
  }
  else
  {
    puts("not going to sign that for you...");
  }
  return __readfsqword(0x28u) ^ v10;
}

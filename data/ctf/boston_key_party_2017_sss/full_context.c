struct __attribute__((aligned(8))) ExecGuy
{
  char hash[20];
  __attribute__((packed)) void (__fastcall *deny_ptr)(const char *) __attribute__((aligned(1)));
  __attribute__((packed)) void (__fastcall *success_ptr)(const char *) __attribute__((aligned(1)));
};

struct __attribute__((packed)) __attribute__((aligned(1))) MExecGuy
{
  char hash[19];
  void (__fastcall *deny_ptr)(const char *);
  void (__fastcall *success_ptr)(const char *);
};

char *key;
ExecGuy *exec_guy;
char global[256];
char is_md5;
ExecGuy *s_exec_guy;
MExecGuy *m_exec_guy;
struct __attribute__((aligned(8))) ExecGuy
{
  char hash[20];
  __attribute__((packed)) void (__fastcall *deny_ptr)(const char *) __attribute__((aligned(1)));
  __attribute__((packed)) void (__fastcall *success_ptr)(const char *) __attribute__((aligned(1)));
};

struct __attribute__((packed)) __attribute__((aligned(1))) MExecGuy
{
  char hash[19];
  void (__fastcall *deny_ptr)(const char *);
  void (__fastcall *success_ptr)(const char *);
};

char *key;
ExecGuy *exec_guy;
char global[256];
char is_md5;
ExecGuy *s_exec_guy;
MExecGuy *m_exec_guy;

void __fastcall deny_command(const char *a1)
{
  printf("wrong signature for %s - it wasn't signed by me\n", a1);
}

void __fastcall exec_command(const char *a1)
{
  system(a1);
}

void init_key()
{
  FILE *stream;
  __int64 size;
  char *ptr;

  stream = fopen("flag", "rb");
  fseek(stream, 0LL, 2);
  size = ftell(stream);
  fseek(stream, 0LL, 0);
  ptr = (char *)calloc(1uLL, size + 1);
  if ( !ptr )
    exit(1);
  fread(ptr, size, 1uLL, stream);
  fclose(stream);
  ptr[size] = 0;
  key = strdup(ptr);
  free(ptr);
}

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

__int64 handle_it()
{
  char buf[24];

  printf("1) sign command\n2) execute command\n>_ ");
  read(0, buf, 4uLL);
  if ( buf[0] == 49 )
  {
    sign_it();
    return 0LL;
  }
  else if ( buf[0] == 50 )
  {
    execute_it();
    return 0LL;
  }
  else
  {
    puts("NOP");
    return 1LL;
  }
}

int __cdecl main(int argc, const char **argv, const char **envp)
{
  is_md5 = 1;
  init_key();
  while ( !(unsigned int)handle_it() )
    ;
  return 0;
}

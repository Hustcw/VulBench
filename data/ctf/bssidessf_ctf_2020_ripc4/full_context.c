char buf_3753[4096];

union pointer
{
  void (*print_encoded)(const char *, size_t);
  char *enc_state;
};

struct workspace_t
{
  int type;
  char *input_buf;
  size_t buf_len;
  pointer _anon_0;
};

char buf_3753[4096];

union pointer
{
  void (*print_encoded)(const char *, size_t);
  char *enc_state;
};

struct workspace_t
{
  int type;
  char *input_buf;
  size_t buf_len;
  pointer _anon_0;
};

int __cdecl main(int argc, const char **argv, const char **envp)
{
  const char *cmd;
  const char *type;
  workspace_t *ws;

  setbuf(stdout, 0LL);
  ws = (workspace_t *)secure_malloc(0x20uLL);
  memset(ws, 0, sizeof(workspace_t));
  type = prompt("type (plain, encoded, encrypted)");
  if ( !strcmp("plain", type) )
  {
    ws->type = 1;
    goto LABEL_8;
  }
  if ( !strcmp("encoded", type) )
  {
    ws->type = 2;
    goto LABEL_8;
  }
  if ( !strcmp("encrypted", type) )
  {
    ws->type = 3;
    while ( 1 )
    {
LABEL_8:
      print_menu(ws->type);
      cmd = prompt("command");
      if ( !cmd )
      {
        puts("Exiting!");
        return 0;
      }
      if ( !strcmp(cmd, "quit") || !strcmp(cmd, "exit") )
        break;
      if ( !strcmp(cmd, "set_input") )
      {
        set_input(ws);
      }
      else if ( !strcmp(cmd, "set_encoding") )
      {
        if ( (ws->type & 3) == 3 )
          puts("No encoding for encrypted type!");
        else
          set_encoding(ws);
      }
      else if ( !strcmp(cmd, "print") )
      {
        print_state(ws);
      }
      else if ( !strcmp(cmd, "set_key") )
      {
        if ( (ws->type & 3) == 3 )
          set_key(ws);
        else
          puts("Can only set key for encrypted type.");
      }
      else if ( !strcmp(cmd, "encrypt") )
      {
        if ( (ws->type & 3) == 3 )
          do_encrypt(ws);
        else
          puts("Can only encrypt for encrypted type.");
      }
    }
    return 0;
  }
  else
  {
    puts("Invalid type!");
    return 1;
  }
}

void __cdecl set_key(workspace_t *ws)
{
  int byte;
  int rv;
  char tmp;
  size_t key_len;
  char *key_data;
  int i_1;
  int j;
  int i_0;
  int i;

  key_data = prompt("key (hex)");
  if ( key_data )
  {
    key_len = strlen(key_data);
    if ( key_len > 0x200 || key_len <= 1 || (key_len & 1) != 0 )
    {
      puts("Invalid key length!");
    }
    else
    {
      for ( i = 0; key_len > i; i += 2 )
      {
        rv = __isoc99_sscanf(&key_data[i], "%02x", &byte);
        if ( rv != 1 )
        {
          puts("Invalid key data!");
          return;
        }
        key_data[i / 2] = byte;
      }
      key_len >>= 1;
      if ( ws->_anon_0.enc_state )
      {
        secure_free(ws->_anon_0.enc_state);
        ws->_anon_0.enc_state = 0LL;
      }
      ws->_anon_0.enc_state = (char *)secure_malloc(0x100uLL);
      for ( i_0 = 0; i_0 <= 255; ++i_0 )
        ws->_anon_0.enc_state[i_0] = i_0;
      j = 0;
      for ( i_1 = 0; i_1 <= 255; ++i_1 )
      {
        j = (unsigned __int8)(ws->_anon_0.enc_state[i_1] + j + key_data[i_1 % key_len]);
        tmp = ws->_anon_0.enc_state[i_1];
        ws->_anon_0.enc_state[i_1] = ws->_anon_0.enc_state[j];
        ws->_anon_0.enc_state[j] = tmp;
      }
      memset(key_data, 0, 2 * key_len);
      puts("Key has been set.");
    }
  }
  else
  {
    puts("No key!");
  }
}

void __cdecl set_input(workspace_t *ws)
{
  size_t v1;
  const char *inp;

  if ( ws->input_buf )
  {
    secure_free(ws->input_buf);
    ws->input_buf = 0LL;
    ws->buf_len = 0LL;
  }
  inp = prompt("input");
  if ( inp )
  {
    ws->input_buf = secure_strdup(inp);
    v1 = strlen(ws->input_buf);
    printf("Input is %lu bytes long.\n", v1);
    ws->buf_len = strlen(ws->input_buf);
  }
  else
  {
    printf("No input!");
  }
}

void __cdecl set_encoding(workspace_t *ws)
{
  const char *enc;

  enc = prompt("encoding (base64, hex)");
  if ( !strcasecmp("base64", enc) )
  {
    ws->_anon_0.print_encoded = (void (*)(const char *, size_t))print_base64;
  }
  else if ( !strcasecmp("hex", enc) )
  {
    ws->_anon_0.print_encoded = (void (*)(const char *, size_t))print_hex;
  }
  else
  {
    puts("Invalid encoding!");
  }
}

void __cdecl print_state(workspace_t *ws)
{
  if ( (ws->type & 2) != 0 )
  {
    if ( ws->_anon_0.print_encoded )
      ws->_anon_0.print_encoded(ws->input_buf, ws->buf_len);
    else
      puts("Must use set_encoding first.");
  }
  else if ( (ws->type & 1) != 0 )
  {
    puts(ws->input_buf);
  }
  else
  {
    puts("Printing not supported for encrypted data.");
  }
}

char *__cdecl prompt(const char *prompt_str)
{
  size_t l;
  const char *rv;

  printf("%s> ", prompt_str);
  rv = fgets(buf_3753, 4096, stdin);
  if ( !rv )
    return 0LL;
  l = strlen(rv);
  if ( rv[l - 1] == 10 )
    rv[l - 1] = 0;
  return (char *)rv;
}

void __cdecl print_hex(const char *buf, size_t buflen)
{
  int i;

  for ( i = 0; buflen > i; ++i )
    printf("%02x", (unsigned __int8)buf[i]);
  putchar(10);
}

void __cdecl print_base64(const char *buf, size_t buflen)
{
  unsigned __int8 *encoded;

  encoded = base64_encode((const unsigned __int8 *)buf, buflen, 0LL);
  if ( encoded )
  {
    puts((const char *)encoded);
    free(encoded);
  }
}

void __cdecl do_encrypt(workspace_t *ws)
{
  unsigned __int8 tmp;
  int k;
  int j;
  int i;

  LOBYTE(i) = 0;
  LOBYTE(j) = 0;
  for ( k = 0; k < ws->buf_len; ++k )
  {
    i = (unsigned __int8)(i + 1);
    j = (unsigned __int8)(ws->_anon_0.enc_state[i] + j);
    tmp = ws->_anon_0.enc_state[i];
    ws->_anon_0.enc_state[i] = ws->_anon_0.enc_state[j];
    ws->_anon_0.enc_state[j] = tmp;
    ws->input_buf[k] ^= ws->_anon_0.enc_state[(unsigned __int8)(ws->_anon_0.enc_state[i] + ws->_anon_0.enc_state[j])];
  }
  puts("Buffer encrypted!");
}

void *__cdecl secure_malloc(size_t sz)
{
  int *v1;
  char *v2;
  size_t sza;
  _QWORD *ptr;
  __int64 pg_size;

  pg_size = sysconf(30);
  sza = 2 * pg_size + ((sz + pg_size - 1) & -pg_size);
  ptr = mmap(0LL, sza, 7, 8226, -1, 0LL);
  if ( ptr == (_QWORD *)-1LL )
  {
    puts("Unable to allocate memory!\n");
    v1 = __errno_location();
    v2 = strerror(*v1);
    printf("Error: %s\n", v2);
    _exit(1);
  }
  *ptr = sza;
  mprotect(ptr, pg_size, 0);
  mprotect((char *)ptr + sza - pg_size, pg_size, 0);
  return (char *)ptr + pg_size;
}

void __cdecl secure_free(void *ptr)
{
  size_t sz;
  __int64 pg_size;

  pg_size = sysconf(30);
  mprotect((char *)ptr - pg_size, pg_size, 1);
  sz = *(_QWORD *)((char *)ptr - pg_size);
  memset(ptr, 0, sz - 2 * pg_size);
  munmap((char *)ptr - pg_size, sz);
}

char *__cdecl secure_strdup(const char *s)
{
  char *buf;
  size_t len;

  len = strlen(s) + 1;
  buf = (char *)secure_malloc(len);
  memcpy(buf, s, len + 1);
  return buf;
}

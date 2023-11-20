
struct __attribute__((aligned(8))) Secret
{
  char pad[4];
  char secret[32];
  char pad2;
  __attribute__((aligned(16))) __int64 length;
  void (__fastcall *decrypt)(const char *, char *, unsigned __int64);
  __int64 (__fastcall *encrypt)(const char *, const char *);
  char *data;
};

struct Command
{
  char *name;
  __int64 description;
  void (__fastcall *handler)(char *);
};

union __attribute__((aligned(8))) Val
{
  char *str;
  __int64 integer;
  struct tm *(__fastcall *gmtime)(const time_t *timer);
  Secret *secret;
};

struct Node
{
  int node_type;
  char name[36];
  void (__fastcall *print_node_val)(Node *);
  void (__fastcall *set_node_val)(Node *);
  Node *next;
  Val val;
  __int64 val2;
};

Command commands[] =
{
  { "add", "add", &cmd_add },
  { "list", "list", &cmd_list },
  { "edit", "edit", &cmd_edit },
  { "delete", "delete", &cmd_delete },
  { "copy", "copy", &cmd_copy },
  { "help", "help", &cmd_help },
  { "exit", "exit", &cmd_exit }
};

char *node_type_names[5] =
{ "uint", "int", "str", "time", "sec" };

char *node_type_descs[5] =
{ "Unsigned integer", "Signed integer", "String", "Timestamp", "Secret Value" };

Node *node_head;


int __cdecl main(int argc, const char **argv, const char **envp)
{
  char *name;
  char *s2;
  Command *i;
  int v7;

  while ( 1 )
  {
    do
      s2 = (char *)prompt_user("command");
    while ( !*s2 );
    v7 = 0;
    if ( !s2 )
      return 0;
    for ( i = commands; i->name; ++i )
    {
      name = i->name;
      if ( !strcmp(i->name, s2) )
      {
        i->handler(name);
        v7 = 1;
        break;
      }
    }
    if ( !v7 )
      printf("Command %s not found!\n", s2);
  }
}

void cmd_add()
{
  const char *s1;
  Node *v1;
  const char *a2;
  int a1;
  int i;
  int j;

  a2 = prompt_user_key(0LL);
  puts("Node type?");
  for ( i = 0; i <= 4; ++i )
    printf("(%4s) %s\n", node_type_names[i], node_type_descs[i]);
  a1 = 5;
LABEL_10:
  while ( a1 == 5 )
  {
    s1 = prompt_user("type");
    for ( j = 0; j <= 4; ++j )
    {
      if ( !strcmp(s1, node_type_names[j]) )
      {
        a1 = j;
        goto LABEL_10;
      }
    }
  }
  v1 = add_node(a1);
  if ( v1 )
  {
    set_node_name(v1, a2);
    if ( v1->set_node_val )
      v1->set_node_val(v1);
  }
  else
  {
    puts("Error making new node!");
  }
}

void cmd_edit()
{
  Node *node_by_name;
  char *v1;

  v1 = prompt_user_key(0LL);
  node_by_name = get_node_by_name(v1);
  if ( node_by_name )
  {
    if ( node_by_name->set_node_val )
      node_by_name->set_node_val(node_by_name);
  }
  else
  {
    puts("node not found!");
  }
}

void cmd_copy()
{
  Node *dest;
  Node *src;
  char *a2;
  char *a2a;

  a2 = (char *)prompt_user_key("source key");
  src = get_node_by_name(a2);
  if ( src )
  {
    a2a = (char *)prompt_user_key("new key");
    dest = (Node *)malloc(node_size[src->node_type]);
    memcpy(dest, src, node_size[src->node_type]);
    set_node_name(dest, a2a);
    insert_node(dest);
  }
  else
  {
    puts("node not found!");
  }
}

void cmd_list()
{
  Node *i;

  for ( i = get_node_head(); i; i = i->next )
  {
    printf("%32s: ", i->name);
    if ( i->print_node_val )
      i->print_node_val(i);
    putchar(10);
  }
}

void cmd_delete()
{
  Node *a1;
  const char *v1;

  v1 = (const char *)prompt_user_key(0LL);
  a1 = get_node_by_name(v1);
  if ( a1 )
    delete_node(a1);
  else
    puts("Node not found!");
}

void cmd_help()
{
  Command *i;

  for ( i = commands; i->name; ++i )
    printf("%-12s %s\n", i->name, (const char *)i->description);
  putchar('\n');
}

void __noreturn cmd_exit()
{
  exit(0);
}

Node *get_node_head()
{
  return node_head;
}

Node *__fastcall alloc_node(int a1)
{
  Node *result;
  Node *v2;

  switch ( a1 )
  {
    case 0:
      v2 = (Node *)malloc(0x50uLL);
      v2->print_node_val = print_node_int;
      v2->set_node_val = set_node_uint;
      goto LABEL_8;
    case 1:
      v2 = (Node *)malloc(0x50uLL);
      v2->print_node_val = print_node_int;
      v2->set_node_val = set_node_int;
      goto LABEL_8;
    case 2:
      v2 = (Node *)malloc(0x50uLL);
      v2->print_node_val = print_node_str;
      v2->set_node_val = set_node_str;
      goto LABEL_8;
    case 3:
      v2 = (Node *)malloc(0x50uLL);
      v2->print_node_val = print_node_time;
      v2->set_node_val = set_node_time;
      v2->val.gmtime = (struct tm *(__fastcall *)(const time_t *))&gmtime;
      goto LABEL_8;
    case 4:
      v2 = (Node *)malloc(0x50uLL);
      v2->print_node_val = print_node_secret;
      v2->set_node_val = set_node_secret;
      v2->val.secret = (Secret *)malloc(0x50uLL);
      v2->val.secret->encrypt = encrypt_secret_data;
      v2->val.secret->decrypt = decrypt_secret_data;
LABEL_8:
      v2->node_type = a1;
      result = v2;
      break;
    default:
      printf("Allocating unknown node type!!!");
      result = 0LL;
      break;
  }
  return result;
}

Node *__fastcall add_node(unsigned int a1)
{
  Node *v2;

  v2 = alloc_node(a1);
  if ( !v2 )
    return 0LL;
  v2->next = node_head;
  node_head = v2;
  return v2;
}

void __fastcall insert_node(Node *a1)
{
  a1->next = node_head;
  node_head = a1;
}

void __fastcall free_node(Node *a1)
{
  if ( a1->node_type == 2 )
  {
    free(a1->val.str);
  }
  else if ( a1->node_type == 4 )
  {
    free(a1->val.secret->data);
    free(a1->val.secret);
  }
  free(a1);
}

void __fastcall delete_node(Node *a1)
{
  Node *i;

  if ( a1 )
  {
    if ( a1 == node_head )
    {
      node_head = a1->next;
      a1->next = 0LL;
      free_node(a1);
    }
    else
    {
      for ( i = node_head; i; i = i->next )
      {
        if ( a1 == i->next )
        {
          i->next = i->next->next;
          a1->next = 0LL;
          free_node(a1);
          return;
        }
      }
    }
  }
}

Node *__fastcall get_node_by_name(const char *a1)
{
  Node *i;

  for ( i = node_head; i; i = i->next )
  {
    if ( !strncmp(a1, i->name, 0x1FuLL) )
      return i;
  }
  return 0LL;
}

void __fastcall set_node_name(Node *a1, const char *a2)
{
  strncpy(a1->name, a2, 31uLL);
  a1->name[31] = 0;
}

void __fastcall print_node_int(Node *a1)
{
  if ( a1->node_type )
  {
    if ( a1->node_type == 1 )
      printf("%ld", a1->val.integer);
  }
  else
  {
    printf("%lu", a1->val.integer);
  }
}

void __fastcall print_node_str(Node *a1)
{
  printf("%s", a1->val.str);
}

void __fastcall print_node_time(Node *a1)
{
  char s[72];
  struct tm *tp;

  tp = a1->val.gmtime(&a1->val2);
  strftime(s, 0x40uLL, "%Y%m%d %H%M%S", tp);
  printf("%s", s);
}

void __fastcall set_node_uint(Node *a1)
{
  char *endptr;
  unsigned __int64 v2;
  char *nptr;

  nptr = prompt_user("Num?");
  v2 = strtoul(nptr, &endptr, 0);
  if ( *nptr == 45 || v2 == -1LL && *__errno_location() == 34 || *endptr )
  {
    puts("Error: out of range!");
  }
  else
  {
    printf("%s %s %lu\n", nptr, endptr, v2);
    a1->val.integer = v2;
  }
}

void __fastcall set_node_int(Node *a1)
{
  char *endptr;
  __int64 v2;
  char *nptr;

  nptr = prompt_user("Num?");
  v2 = strtol(nptr, &endptr, 0);
  if ( v2 == 0x7FFFFFFFFFFFFFFFLL && *__errno_location() == 34 || *endptr )
    printf("Error: out of range!");
  else
    a1->val.integer = v2;
}

void __fastcall set_node_str(Node *a1)
{
  const char *s;

  s = prompt_user("value");
  if ( s )
    a1->val.str = strdup(s);
}

void __fastcall set_node_time(Node *a1)
{
  a1->val2 = time(0LL);
}

void print_node_secret(Node *a1)
{
  printf("[REDACTED]");
}

void __fastcall set_node_secret(Node *a1)
{
  Val v1;
  Val v2;
  const char *src;
  const char *srca;

  src = prompt_user("key");
  if ( src )
  {
    strncpy(a1->val.secret->secret, src, 0x20uLL);
    a1->val.secret->pad2 = 0;
    srca = prompt_user("value");
    if ( srca )
    {
      v1.secret = (Secret *)a1->val;
      v1.secret->data = strdup(srca);
      v2.secret = (Secret *)a1->val;
      v2.secret->length = v2.secret->encrypt(v2.secret->secret, v2.secret->data);
    }
  }
}

__int64 __fastcall encrypt_secret_data(const char *a1, const char *a2)
{
  size_t v3;
  unsigned __int64 v4;
  unsigned __int64 i;

  v4 = strlen(a2);
  v3 = strlen(a1);
  for ( i = 0LL; i < v4; ++i )
    a2[i] ^= a1[i % v3];
  return v4;
}

void __fastcall decrypt_secret_data(const char *a1, char *a2, unsigned __int64 a3)
{
  size_t v4;
  unsigned __int64 i;

  v4 = strlen(a1);
  for ( i = 0LL; i < a3; ++i )
    a2[i] ^= a1[i % v4];
}

char *__fastcall prompt_user(const char *a1)
{
  if ( !inp_buf )
    inp_buf = (char *)malloc(0x1000uLL);
  printf("%s> ", a1);
  if ( !fgets(inp_buf, 4096, stdin) )
    return 0LL;
  trim_inplace(inp_buf);
  return inp_buf;
}

char *__fastcall prompt_user_key(const char *a1)
{
  const char *v2;

  v2 = a1;
  if ( !a1 )
    v2 = "key name";
  if ( !key_buf )
    key_buf = (char *)malloc(0x20uLL);
  printf("%s> ", v2);
  if ( !fgets(key_buf, 32, stdin) )
    return 0LL;
  trim_inplace(key_buf);
  return key_buf;
}

void __fastcall trim_inplace(char *a1)
{
  size_t n;
  char *src;
  char *i;
  char *v4;

  for ( i = &a1[strlen(a1) - 1]; ((*__ctype_b_loc())[*i] & 0x2000) != 0; --i )
    ;
  v4 = i + 1;
  for ( src = a1; ((*__ctype_b_loc())[*src] & 0x2000) != 0; ++src )
    ;
  if ( v4 > src )
  {
    n = v4 - src;
    if ( a1 != src )
      memmove(a1, src, n);
    a1[n] = 0;
  }
  else
  {
    *a1 = 0;
  }
}

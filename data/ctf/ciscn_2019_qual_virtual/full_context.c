struct Link
{
  __int64 *val;
  int stack_top;
  int stack_rsp;
  __int64 content[];
};
struct Link
{
  __int64 *val;
  int stack_top;
  int stack_rsp;
  __int64 content[];
};

__int64 __fastcall main(int a1, char **a2, char **a3)
{
  char *s;
  Link *stack;
  Link *instr_list;
  Link *link;
  char *tmp;

  s = (char *)malloc(0x20uLL);
  stack = create_link(64);
  instr_list = create_link(128);
  link = create_link(64);
  tmp = (char *)malloc(0x400uLL);
  puts("Your program name:");
  read_str(s, 32);
  puts("Your instruction:");
  read_str(tmp, 1024);
  read_instr((__int64)instr_list, tmp);
  puts("Your stack data:");
  read_str(tmp, 1024);
  place_stack((__int64)stack, tmp);
  if ( (unsigned int)run(instr_list, stack, link) )
  {
    puts("-------");
    puts(s);
    print(stack);
    puts("-------");
  }
  else
  {
    puts("Your Program Crash :)");
  }
  free(tmp);
  free_(instr_list);
  free_(stack);
  free_(link);
  return 0LL;
}

void __fastcall free_(Link *a1)
{
  if ( a1 )
  {
    free(a1->val);
    free(a1);
  }
}

Link *__fastcall create_link(int a1)
{
  Link *ptr;
  void *s;

  ptr = (Link *)malloc(0x10uLL);
  if ( !ptr )
    return 0LL;
  s = malloc(8LL * a1);
  if ( s )
  {
    memset(s, 0, 8LL * a1);
    ptr->val = (__int64 *)s;
    ptr->stack_top = a1;
    ptr->stack_rsp = -1;
    return ptr;
  }
  else
  {
    free(ptr);
    return 0LL;
  }
}

__int64 __fastcall push_internal(Link *stack, __int64 val)
{
  int v3;

  if ( !stack )
    return 0LL;
  v3 = stack->stack_rsp + 1;
  if ( v3 == stack->stack_top )
    return 0LL;
  stack->val[v3] = val;
  stack->stack_rsp = v3;
  return 1LL;
}

__int64 __fastcall pop_internal(Link *a1, _QWORD *a2)
{
  if ( !a1 )
    return 0LL;
  if ( a1->stack_rsp == -1 )
    return 0LL;
  *a2 = a1->val[a1->stack_rsp--];
  return 1LL;
}

void __fastcall sub_40151A(__int64 a1, char *a2)
{
  int v2;
  int i;
  const char *nptr;
  _QWORD *ptr;

  if ( a1 )
  {
    ptr = malloc(8LL * *(int *)(a1 + 8));
    v2 = 0;
    for ( nptr = strtok(a2, delim); v2 < *(_DWORD *)(a1 + 8) && nptr; nptr = strtok(0LL, delim) )
      ptr[v2++] = atol(nptr);
    for ( i = v2 - 1; i >= 0 && (unsigned int)push_internal(a1, ptr[i]); --i )
      ;
    free(ptr);
  }
}

void __fastcall sub_40161D(__int64 a1, char *a2)
{
  int v2;
  int i;
  const char *s1;
  _QWORD *ptr;

  if ( a1 )
  {
    ptr = malloc(8LL * *(int *)(a1 + 8));
    v2 = 0;
    for ( s1 = strtok(a2, delim); v2 < *(_DWORD *)(a1 + 8) && s1; s1 = strtok(0LL, delim) )
    {
      if ( !strcmp(s1, "push") )
      {
        ptr[v2] = 17LL;
      }
      else if ( !strcmp(s1, "pop") )
      {
        ptr[v2] = 18LL;
      }
      else if ( !strcmp(s1, "add") )
      {
        ptr[v2] = 33LL;
      }
      else if ( !strcmp(s1, "sub") )
      {
        ptr[v2] = 34LL;
      }
      else if ( !strcmp(s1, "mul") )
      {
        ptr[v2] = 35LL;
      }
      else if ( !strcmp(s1, "div") )
      {
        ptr[v2] = 36LL;
      }
      else if ( !strcmp(s1, "load") )
      {
        ptr[v2] = 49LL;
      }
      else if ( !strcmp(s1, "save") )
      {
        ptr[v2] = 50LL;
      }
      else
      {
        ptr[v2] = 255LL;
      }
      ++v2;
    }
    for ( i = v2 - 1; i >= 0 && (unsigned int)push_internal(a1, ptr[i]); --i )
      ;
    free(ptr);
  }
}

void __fastcall print(Link *a1)
{
  int i;

  if ( a1 && a1->stack_rsp != -1 )
  {
    for ( i = 0; i < a1->stack_rsp; ++i )
      printf("%d ", a1->val[i]);
    printf("%d\n", a1->val[a1->stack_rsp]);
  }
}

__int64 __fastcall run(Link *instr, Link *stack, Link *mem)
{
  unsigned int v5;
  __int64 v6;

  v5 = 1;
  while ( v5 && (unsigned int)pop_internal(instr, &v6) )
  {
    switch ( v6 )
    {
      case 17LL:
        v5 = get_from_stack(mem, stack);
        break;
      case 18LL:
        v5 = move_to_stack(mem, stack);
        break;
      case 33LL:
        v5 = add(mem);
        break;
      case 34LL:
        v5 = sub(mem);
        break;
      case 35LL:
        v5 = mul(mem);
        break;
      case 36LL:
        v5 = div(mem);
        break;
      case 49LL:
        v5 = load(mem);
        break;
      case 50LL:
        v5 = save(mem);
        break;
      default:
        v5 = 0;
        break;
    }
  }
  return v5;
}

_BOOL8 __fastcall get_from_stack(Link *a1, Link *stack)
{
  __int64 v3;

  return (unsigned int)pop_internal(stack, &v3) && (unsigned int)push_internal(a1, v3);
}

_BOOL8 __fastcall move_to_stack(Link *a1, Link *stack)
{
  __int64 v3;

  return (unsigned int)pop_internal(a1, &v3) && (unsigned int)push_internal(stack, v3);
}

__int64 __fastcall add(Link *a1)
{
  __int64 v2;
  __int64 v3;

  if ( (unsigned int)pop_internal(a1, &v2) && (unsigned int)pop_internal(a1, &v3) )
    return push_internal(a1, v3 + v2);
  else
    return 0LL;
}

__int64 __fastcall sub(Link *a1)
{
  __int64 v2;
  __int64 v3;

  if ( (unsigned int)pop_internal(a1, &v2) && (unsigned int)pop_internal(a1, &v3) )
    return push_internal(a1, v2 - v3);
  else
    return 0LL;
}

__int64 __fastcall mul(Link *a1)
{
  __int64 v2;
  __int64 v3;

  if ( (unsigned int)pop_internal(a1, &v2) && (unsigned int)pop_internal(a1, &v3) )
    return push_internal(a1, v3 * v2);
  else
    return 0LL;
}

__int64 __fastcall div(Link *a1)
{
  __int64 v2;
  __int64 v3;

  if ( (unsigned int)pop_internal(a1, &v2) && (unsigned int)pop_internal(a1, &v3) )
    return push_internal(a1, v2 / v3);
  else
    return 0LL;
}

__int64 __fastcall load(Link *a1)
{
  __int64 v2;

  if ( (unsigned int)pop_internal(a1, &v2) )
    return push_internal(a1, a1->val[a1->stack_rsp + v2]);
  else
    return 0LL;
}

__int64 __fastcall save(Link *a1)
{
  __int64 v2;
  __int64 v3;

  if ( !(unsigned int)pop_internal(a1, &v2) || !(unsigned int)pop_internal(a1, &v3) )
    return 0LL;
  a1->val[a1->stack_rsp + v2] = v3;
  return 1LL;
}


void __fastcall read_str(char *a1, int a2)
{
  read_str_impl(a1, a2, 10);
}

void __fastcall read_str_impl(char *a1, int a2, char a3)
{
  int i;

  for ( i = 0; i < a2; ++i )
  {
    if ( (unsigned int)read(0, &a1[i], 1uLL) != 1 )
      exit(-1);
    if ( a3 == a1[i] )
    {
      a1[i] = 0;
      return;
    }
  }
  a1[a2 - 1] = 0;
}

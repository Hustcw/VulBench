char *line_4718;
Entry *(__fastcall **fp)(Entry *a1);
Entry *root;


int __cdecl __noreturn main(int argc, const char **argv, const char **envp)
{
  unsigned int v3;
  char *v4;
  unsigned __int64 v5;
  char *v6;
  ssize_t v7;
  char *v8;
  unsigned __int64 v9;
  char *v10;
  int v11;
  char *v12;
  char *v13;

  setvbuf(stdout, 0LL, 2, 0LL);
  setvbuf(stderr, 0LL, 2, 0LL);
  fp = (Entry *(__fastcall **)(Entry *))malloc(8uLL);
  if ( !fp )
    err(1, "uhhh?");
  if ( getenv("DEBUG") )
    *fp = debug_end_of_entry;
  else
    *fp = end_of_entry;
  v3 = 0;
  print_menu(0LL);
  v4 = line_4718;
  if ( !line_4718 )
    goto LABEL_14;
  while ( 1 )
  {
    do
    {
      v5 = 0LL;
      v6 = v4;
      while ( 1 )
      {
        v7 = read(0, v6, 2048 - v5);
        if ( !v7 )
          err(1, "remote end disappeared");
        v8 = &line_4718[v5];
        if ( line_4718[v5] == '\n' )
          break;
        v9 = v5 + 1;
        v5 += v7;
        v10 = &line_4718[v9];
        v6 = &line_4718[v5];
        while ( v10 != v6 )
        {
          v8 = v10;
          v11 = (unsigned __int8)*v10++;
          if ( v11 == 10 )
            goto LABEL_13;
        }
        if ( v5 > 0x7FF )
          err(1, "expected newline in < %d bytes\n", 2048LL);
      }
LABEL_13:
      v12 = line_4718;
      *v8 = 0;
      v3 = parse_line(v3, v12);
      print_menu(v3);
      v4 = line_4718;
    }
    while ( line_4718 );
LABEL_14:
    v13 = (char *)malloc(0x800uLL);
    line_4718 = v13;
    if ( !v13 )
      err(1, "malloc");
    v4 = v13;
  }
}

Entry *__fastcall end_of_entry(Entry *result)
{
  while ( result->next )
    result = result->next;
  return result;
}

Entry *__fastcall debug_end_of_entry(Entry *a1)
{
  Entry *v1;
  Entry *i;

  v1 = a1;
  printf("[debug] root is %p\n", a1);
  for ( i = v1->next; i; i = v1->next )
  {
    printf("  [debug] next is %p\n", i);
    v1 = v1->next;
  }
  printf("  [debug] returning %p to caller\n", v1);
  return v1;
}

void __fastcall print_menu(int a1)
{
  __int64 v1;
  size_t v2;
  const char *v3;

  switch ( a1 )
  {
    case 0:
      v1 = 116LL;
      v2 = 116LL;
      v3 = "\n"
           "Q. When does a joke become a Dad joke?\n"
           "A. When it becomes apparent.\n"
           "\n"
           "1. Add an entry\n"
           "2. Print entries\n"
           "3. Quit\n"
           "\n"
           "--> ";
      break;
    case 1:
      v1 = 185LL;
      v2 = 185LL;
      v3 = "\n"
           "My duck got arrested.\n"
           ".. Apparently he's a quackhead.\n"
           ".. I tried to bail him out, they wouldn't let me. Said he was a flight risk.\n"
           "\n"
           "1. Set name\n"
           "2. Set small\n"
           "3. Set large\n"
           "4. cd ..\n"
           "\n"
           "--> ";
      break;
    case 2:
      v1 = 137LL;
      v2 = 137LL;
      v3 = "\n"
           "Person A: I once met a dog with no nose.\n"
           "Person B: How does he smell?\n"
           "Person A: Terrible.\n"
           "\n"
           "What name would you like for this entry?\n"
           "--> ";
      break;
    case 3:
      v1 = 154LL;
      v2 = 154LL;
      v3 = "\n"
           "My fridge is full of German sausages... I made the wurst mistake when I went shopping last time.\n"
           "\n"
           "What value do you want to set for the small value?\n"
           "--> ";
      break;
    case 4:
      v1 = 88LL;
      v2 = 88LL;
      v3 = "\nWhy did Fred fall off a bike?\nBecause Fred was a fish.\n\nWhat size should large be?\n--> ";
      break;
    default:
      err(1, "invalid state reached?");
  }
  if ( write(1, v3, v2) != v1 )
    err(1, "writing menu to stdout");
}

__int64 __fastcall parse_line(unsigned int a1, char *nptr)
{
  unsigned int v2;
  int v5;
  Entry *v6;
  char *v7;
  Entry *i;
  int v9;
  Entry *v10;
  Entry *v11;
  Entry *v12;
  __int64 v13;
  char *v14;
  Entry *v15;
  size_t v16;

  v2 = a1;
  if ( !a1 )
  {
    v5 = strtol(nptr, 0LL, 10);
    switch ( v5 )
    {
      case 1:
        v10 = root;
        if ( root )
        {
          while ( v10->next )
            v10 = v10->next;
          v2 = 1;
          v11 = (Entry *)malloc(0x100uLL);
          v10->next = v11;
          if ( !v11 )
            err(1, "out of memory");
        }
        else
        {
          v2 = 1;
          root = (Entry *)malloc(0x100uLL);
          v16 = malloc_usable_size(root);
          printf("malloc_usable_size is %d, and sizeof(struct entry) is %d\n", v16, 0x100LL);
        }
        return v2;
      case 2:
        for ( i = root; i; i = i->next )
        {
          printf("Name: %s\n", i->name);
          printf("Small: %s\n", i->small);
          printf("Large: %p\n", i->large);
          if ( !i->next )
            break;
          puts("-- next --");
        }
        return v2;
      case 3:
        exit(1);
    }
    if ( write(
           0,
           "\n"
           "What is the fastest liquid on earth?\n"
           "Milk, because it is pasteurized before you see it\n"
           "\n"
           "Also, you made an error somewhere\n",
           0x7BuLL) == 123 )
      return 0LL;
    goto LABEL_23;
  }
  if ( a1 != 1 )
  {
    switch ( a1 )
    {
      case 2u:
        v2 = 1;
        v15 = (*fp)(root);
        strcpy(v15->name, nptr);
        return v2;
      case 3u:
        v6 = (*fp)(root);
        v7 = (char *)__strdup(nptr);
        v6->small = v7;
        if ( !v7 )
          err(1, "out of memory setting tmp->small");
        break;
      case 4u:
        v12 = (*fp)(root);
        v13 = strtoll(nptr, 0LL, 10);
        v14 = (char *)malloc(v13);
        v12->large = v14;
        if ( !v14 )
          err(1, "out of memory setting tmp->large");
        break;
      default:
        return v2;
    }
    return 1LL;
  }
  v9 = strtol(nptr, 0LL, 10);
  switch ( v9 )
  {
    case 1:
      return 2;
    case 2:
      return 3;
    case 3:
      return 4;
    case 4:
      return 0;
  }
  if ( write(
         0,
         "\nWho is General Failure, and why is he reading my hard disk?!\n\nAlso, you made an error somewhere\n",
         0x61uLL) != 97 )
LABEL_23:
    err(1, "writing error message");
  return 1LL;
}
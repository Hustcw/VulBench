
struct Note
{
  int size[16];
  char *content[16];
};

int readint()
{
  char v1[40];

  read_str(v1, 32);
  return strtol(v1);
}

void __cdecl delete()
{
  unsigned int v0;

  v0 = readint();
  if ( !check(v0) )
    exit(0);
  list.size[v0] = 0;
  free((int)list.content[v0]);
  list.content[v0] = 0;
}

void __cdecl edit()
{
  unsigned int v0;

  v0 = readint();
  if ( !check(v0) )
    exit(0);
  read_str(list.content[v0], list.size[v0]);
  list.size[v0] = strlen_0(list.content[v0]);
}

void __cdecl add()
{
  int i;
  int v1;

  v1 = -1;
  for ( i = 0; i <= 15; ++i )
  {
    if ( !list.content[i] )
    {
      v1 = i;
      break;
    }
  }
  if ( v1 == -1 )
    exit(0);
  list.size[v1] = readint();
  list.content[v1] = (char *)malloc(list.size[v1]);
  read_str(list.content[v1], list.size[v1]);
}

int __cdecl __noreturn main(int argc, const char **argv, const char **envp)
{
  int v3;

  while ( 1 )
  {
    while ( 1 )
    {
      v3 = readint();
      if ( v3 != 2 )
        break;
      delete();
    }
    if ( v3 > 2 )
    {
      if ( v3 == 3 )
      {
        edit();
      }
      else if ( v3 == 4 )
      {
        exit(0);
      }
    }
    else if ( v3 == 1 )
    {
      add();
    }
  }
}
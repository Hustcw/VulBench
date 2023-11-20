char *note[10];
char *note[10];

unsigned __int8 *__cdecl read_input(unsigned __int8 *buf, size_t nbytes)
{
  unsigned __int8 *result; // eax
  ssize_t v3; // [esp+Ch] [ebp-Ch]

  v3 = read(0, buf, nbytes);
  if ( v3 <= 0 )
  {
    puts("read error");
    exit(1);
  }
  result = (unsigned __int8 *)buf[v3 - 1];
  if ( (_BYTE)result == 10 )
  {
    result = &buf[v3 - 1];
    *result = 0;
  }
  return result;
}

int read_int()
{
  char buf[16]; // [esp+Ch] [ebp-1Ch] BYREF
  unsigned int v2; // [esp+1Ch] [ebp-Ch]

  v2 = __readgsdword(0x14u);
  if ( read(0, buf, 0xFu) <= 0 )
  {
    puts("read error");
    exit(1);
  }
  return atoi(buf);
}

int __cdecl is_printable(char *s)
{
  size_t i; // [esp+Ch] [ebp-Ch]

  for ( i = 0; strlen(s) > i; ++i )
  {
    if ( s[i] <= 31 || s[i] == 127 )
      return 0;
  }
  return 1;
}

unsigned int add_note()
{
  int v1; // [esp+8h] [ebp-60h]
  char s[80]; // [esp+Ch] [ebp-5Ch] BYREF
  unsigned int v3; // [esp+5Ch] [ebp-Ch]

  v3 = __readgsdword(0x14u);
  printf("Index :");
  v1 = read_int();
  if ( v1 > 10 )
  {
    puts("Out of bound !!");
    exit(0);
  }
  printf("Name :");
  read_input((unsigned __int8 *)s, 0x50u);
  if ( !is_printable(s) )
  {
    puts("It must be a printable name !");
    exit(-1);
  }
  note[v1] = strdup(s);
  puts("Done !");
  return __readgsdword(0x14u) ^ v3;
}

int del_note()
{
  int result; // eax
  int v1; // [esp+Ch] [ebp-Ch]

  printf("Index :");
  v1 = read_int();
  if ( v1 > 10 )
  {
    puts("Out of bound !!");
    exit(0);
  }
  free(note[v1]);
  result = v1;
  note[v1] = 0;
  return result;
}

char *show_note()
{
  char *result; // eax
  int v1; // [esp+Ch] [ebp-Ch]

  printf("Index :");
  v1 = read_int();
  if ( v1 > 10 )
  {
    puts("Out of bound !!");
    exit(0);
  }
  result = note[v1];
  if ( result )
    return (char *)printf("Name : %s\n", note[v1]);
  return result;
}

int __cdecl __noreturn main(int argc, const char **argv, const char **envp)
{
  int v3; // eax

  while ( 1 )
  {
    while ( 1 )
    {
      v3 = read_int();
      if ( v3 != 2 )
        break;
      show_note();
    }
    if ( v3 > 2 )
    {
      if ( v3 == 3 )
      {
        del_note();
      }
      else
      {
        if ( v3 == 4 )
          exit(0);
LABEL_13:
        puts("Invalid choice");
      }
    }
    else
    {
      if ( v3 != 1 )
        goto LABEL_13;
      add_note();
    }
  }
}

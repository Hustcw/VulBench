char text[512];
FILE *fp;
int init;
char filepath[8];

void show_menu()
{
  puts("=-=-=-=-=-=-=-=-=-=-=-=");
  puts("1. Open the book");
  puts("2. Read the book");
  puts("3. Revise the contents");
  puts("4. Close the book");
  puts("=-=-=-=-=-=-=-=-=-=-=-=");
  printf("> ");
}

void __fastcall error(const char *a1, const char *a2)
{
  size_t v2;
  size_t v3;
  size_t v4;
  size_t v5;
  char *s;
  char *v7;
  void *ptr;

  s = (char *)a1;
  if ( a1 && *a1 )
  {
    v7 = ": ";
  }
  else
  {
    v7 = (char *)&unk_15DE;
    s = (char *)&unk_15DE;
  }
  v2 = strlen(s);
  v3 = strlen(v7) + v2;
  v4 = strlen(a2);
  ptr = malloc(v3 + v4 + 2);
  v5 = malloc_usable_size(ptr);
  snprintf((char *)ptr, v5, "%s%s%s\n", s, v7, a2);
  fprintf(stderr, (const char *)ptr);
  free(ptr);
}

__int64 __fastcall readline(void *a1, int a2)
{
  unsigned int v3;

  v3 = read(0, a1, a2);
  if ( *((_BYTE *)a1 + (int)v3 - 1) == 10 )
    --v3;
  if ( !v3 )
  {
    error("read", "Received nothing");
    exit(1);
  }
  *((_BYTE *)a1 + (int)v3) = 0;
  return v3;
}

int read_int()
{
  char nptr[8];

  readline(nptr, 7);
  return atoi(nptr);
}

void grimoire_open()
{
  if ( fp )
  {
    puts("The desk is occupied with another book.");
  }
  else
  {
    fp = fopen(filepath, "r");
    if ( fp )
    {
      puts("You opened the forbidden grimoire.");
    }
    else
    {
      error(filepath, "No such file or directory");
      puts("You lost the grimoire...");
    }
  }
}

void grimoire_close()
{
  if ( fp )
  {
    puts("You closed the book before something bad happens.");
    fclose(fp);
    fp = 0LL;
    init = 0;
  }
  else
  {
    puts("You don't even open the book.");
  }
}

void grimoire_read()
{
  unsigned __int16 v0;
  char s[520];

  if ( !fp )
  {
    puts("You don't even open the book.");
    return;
  }
  if ( !init )
  {
    init = 1;
    fseek(fp, 0LL, 2);
    v0 = ftell(fp);
    fseek(fp, 0LL, 0);
    memset(s, 0, 0x200uLL);
    if ( !fread(s, 1uLL, v0, fp) )
    {
      error("fread", "Empty file stream");
      return;
    }
    qmemcpy(text, s, sizeof(text));
  }
  puts("*----------------------------------------*");
  printf("%s", text);
  puts("*----------------------------------------*");
}

void grimoire_edit()
{
  unsigned __int16 v0;
  unsigned __int16 v1;
  char buf[520];

  if ( init )
  {
    printf("Offset: ");
    v1 = read_int();
    if ( v1 <= 0x200u )
    {
      printf("Text: ");
      v0 = read(0, buf, 0x200uLL);
      if ( !v0 )
      {
        error("read", "Received nothing");
        exit(1);
      }
      if ( buf[v0 - 1] == 10 )
        --v0;
      buf[v0] = 0;
      memcpy(&text[v1], buf, v0);
    }
    else
    {
      puts("You can't add a new page.");
    }
  }
  else
  {
    puts("You must read the book before editing it.");
  }
}

void __fastcall handler(int a1)
{
  if ( a1 == 14 )
  {
    puts("\nIt's time to say goodbye.");
    exit(1);
  }
}

void initialize()
{
  strcpy(filepath, "grimoire.txt");
  init = 0;
}

int __cdecl __noreturn main(int argc, const char **argv, const char **envp)
{
  int v3;

  initialize();
  while ( 1 )
  {
    while ( 1 )
    {
      show_menu();
      v3 = read_int();
      if ( v3 != 2 )
        break;
      grimoire_read();
    }
    if ( v3 > 2 )
    {
      if ( v3 == 3 )
      {
        grimoire_edit();
      }
      else if ( v3 == 4 )
      {
        grimoire_close();
      }
      else
      {
LABEL_13:
        puts("Invalid choice.");
      }
    }
    else
    {
      if ( v3 != 1 )
        goto LABEL_13;
      grimoire_open();
    }
  }
}
char *a1[20];

char *a1[20];

void __fastcall read_str(char *a1, int a2)
{
  char buf; // [rsp+13h] [rbp-Dh] BYREF
  int i; // [rsp+14h] [rbp-Ch]
  unsigned __int64 v4; // [rsp+18h] [rbp-8h]

  v4 = __readfsqword(0x28u);
  for ( i = 0; i < a2; ++i )
  {
    if ( (unsigned int)read(0, &buf, 1uLL) == -1 )
    {
      puts("error!");
      exit(0);
    }
    a1[i] = buf;
    if ( buf == 10 )
    {
      a1[i] = 0;
      return;
    }
  }
  a1[i - 1] = 0;
}

int read_int()
{
  char nptr[24]; // [rsp+0h] [rbp-20h] BYREF
  unsigned __int64 v2; // [rsp+18h] [rbp-8h]

  v2 = __readfsqword(0x28u);
  read_str(nptr, 16);
  return atoi(nptr);
}

void __fastcall new_name()
{
  int i; // [rsp+8h] [rbp-8h]
  int a2; // [rsp+Ch] [rbp-4h]

  for ( i = 0; a1[i] && i <= 19; ++i )
    ;
  if ( i <= 19 )
  {
    printf("Name Size:");
    a2 = read_int();
    if ( a2 <= 15 || a2 > 96 )
    {
      puts("Invalid size !!");
    }
    else
    {
      printf("Name:");
      a1[i] = (char *)malloc(a2);
      read_str(a1[i], a2);
      puts("Done!");
    }
  }
  else
  {
    puts("Not any more !!");
  }
}

int show_name()
{
  return printf("There are no gifts here\n");
}

void __fastcall delete_name()
{
  unsigned int v0; // [rsp+Ch] [rbp-4h]

  printf("The id you want to delete:");
  v0 = read_int();
  if ( v0 <= 0x13 && a1[v0] )
  {
    free(a1[v0]);
    a1[v0] = 0LL;
    while ( (int)(v0 + 1) <= 19 )
    {
      a1[v0] = a1[v0 + 1];
      ++v0;
    }
    puts("Done!");
  }
  else
  {
    puts("Invalid id !!");
  }
}

void __fastcall __noreturn main(int a1, char **a2, char **a3)
{
  int v3; // eax

  while ( 1 )
  {
    while ( 1 )
    {
      v3 = read_int();
      if ( v3 != 2 )
        break;
      show_name();
    }
    if ( v3 > 2 )
    {
      if ( v3 == 3 )
      {
        delete_name();
      }
      else
      {
        if ( v3 == 4 )
        {
          puts("Bye!");
          exit(0);
        }
LABEL_13:
        puts("Invalid Choice !");
      }
    }
    else
    {
      if ( v3 != 1 )
        goto LABEL_13;
      add_name();
    }
  }
}

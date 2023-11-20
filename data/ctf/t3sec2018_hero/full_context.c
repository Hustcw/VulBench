char *power[12];
char *name[10];
char *power[12];
char *name[10];

void add()
{
  char *v0;
  int i;

  for ( i = 0; i <= 9 && name[i]; ++i )
    ;
  if ( i == 10 )
  {
    puts("You can't add more heros!");
  }
  else
  {
    name[i] = (char *)malloc(0x68uLL);
    power[i] = (char *)malloc(0xF8uLL);
    puts("What's your hero's name:");
    v0 = name[i];
    v0[read(0, v0, 0x68uLL)] = 0;
    puts("What's your hero's power:");
    read(0, power[i], 0xF8uLL);
    puts("Done!");
  }
}

void show()
{
  unsigned int v0;
  char buf[24];
  unsigned __int64 v2;

  v2 = __readfsqword(0x28u);
  puts("What hero do you want to show?");
  read(0, buf, 0x10uLL);
  v0 = atoi(buf);
  if ( v0 <= 9 && name[v0] )
  {
    printf("Hero:%s\nPower:%s\n", name[v0], power[v0]);
    puts("Done!");
  }
  else
  {
    puts("No such hero!");
  }
}

void del()
{
  unsigned int v0;
  char buf[24];
  unsigned __int64 v2;

  v2 = __readfsqword(0x28u);
  puts("What hero do you want to remove?");
  read(0, buf, 0x10uLL);
  v0 = atoi(buf);
  if ( v0 <= 9 && name[v0] )
  {
    free(name[v0]);
    free(power[v0]);
    name[v0] = 0LL;
    power[v0] = 0LL;
    puts("Done!");
  }
  else
  {
    puts("No such hero!");
  }
}

void edit()
{
  char *v0;
  unsigned int v1;
  char buf[24];
  unsigned __int64 v3;

  v3 = __readfsqword(0x28u);
  puts("What hero do you want to edit?");
  read(0, buf, 0x10uLL);
  v1 = atoi(buf);
  if ( v1 <= 9 && name[v1] )
  {
    free(name[v1]);
    name[v1] = (char *)malloc(0x68uLL);
    puts("What's your hero's name:");
    v0 = name[v1];
    v0[read(0, v0, 0x68uLL)] = 0;
    free(power[v1]);
    power[v1] = (char *)malloc(0xF8uLL);
    puts("What's your hero's power:");
    read(0, power[v1], 0xF8uLL);
    puts("Done!");
  }
  else
  {
    puts("No such hero!");
  }
}

void menu()
{
  puts("1. add hero");
  puts("2. show hero");
  puts("3. edit hero");
  puts("4. remove hero");
  puts("5. exit");
  printf("Your choice: ");
}

int __cdecl main(int argc, const char **argv, const char **envp)
{
  char buf[24];
  unsigned __int64 v5;

  v5 = __readfsqword(0x28u);
  while ( 1 )
  {
    menu();
    read(0, buf, 0x10uLL);
    switch ( atoi(buf) )
    {
      case 1:
        add();
        break;
      case 2:
        show();
        break;
      case 3:
        edit();
        break;
      case 4:
        del();
        break;
      case 5:
        puts("Bye bye!");
        exit(0);
      default:
        puts("Invalid choice!");
        break;
    }
  }
}

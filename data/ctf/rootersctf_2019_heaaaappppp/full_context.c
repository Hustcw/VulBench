struct User
{
  char *username;
  __int64 age;
};

User *root;
struct User
{
  char *username;
  __int64 age;
};

User *root;

void __noreturn bye()
{
  puts("You must create a user first");
  exit(0);
}

void createUser()
{
  User *v0;
  char buf[40];
  unsigned __int64 v2;

  v2 = __readfsqword(0x28u);
  root = (User *)malloc(0x10uLL);
  printf("Enter age of user: ");
  __isoc99_scanf("%d", &root->age);
  printf("Enter username: ");
  read(0, buf, 0x1FuLL);
  v0 = root;
  v0->username = strdup(buf);
}

void editUsername()
{
  if ( !root )
    bye();
  printf("Enter age of user: ");
  __isoc99_scanf("%d", &root->age);
  printf("Enter username: ");
  read(0, root->username, 0x1FuLL);
}

void deleteUser()
{
  if ( !root )
    bye();
  free(root);
}

void sendMessage()
{
  char buf[136];
  unsigned __int64 v1;

  v1 = __readfsqword(0x28u);
  puts("Enter message to be sent: ");
  read(0, buf, 0x7FuLL);
  puts("Message recieved: ");
  puts(buf);
  puts("\nSaving it for admin to see!\n");
  message = strdup(buf);
}

int __cdecl main(int argc, const char **argv, const char **envp)
{
  int v4;
  unsigned __int64 v5;

  v5 = __readfsqword(0x28u);
  while ( 1 )
  {
    puts("### USER ADMINISTRATION ###\n");
    puts("0) Create user");
    puts("1) Edit user name");
    puts("2) Delete user");
    puts("3) Send admin a message");
    puts("4) exit");
    printf("Enter your choice: ");
    __isoc99_scanf("%d", &v4);
    switch ( v4 )
    {
      case 0:
        createUser();
        break;
      case 1:
        editUsername();
        break;
      case 2:
        deleteUser();
        break;
      case 3:
        sendMessage();
        break;
      case 4:
        exit(0);
      default:
        puts("Wrong choice try again...");
        break;
    }
  }
}

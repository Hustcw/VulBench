int __cdecl main(int argc, const char **argv, const char **envp)
{
  int v4;
  unsigned __int64 v5;

  v5 = __readfsqword(0x28u);
  beNice();
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

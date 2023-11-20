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
unsigned __int64 createUser()
{
  char **v0;
  char buf[40];
  unsigned __int64 v3;

  v3 = __readfsqword(0x28u);
  root = malloc(0x10uLL);
  printf("Enter age of user: ");
  __isoc99_scanf("%d", (char *)root + 8);
  printf("Enter username: ");
  read(0, buf, 0x1FuLL);
  v0 = (char **)root;
  *v0 = strdup(buf);
  return __readfsqword(0x28u) ^ v3;
}

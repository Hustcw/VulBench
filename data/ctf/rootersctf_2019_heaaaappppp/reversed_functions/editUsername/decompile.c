void editUsername()
{
  if ( !root )
    bye();
  printf("Enter age of user: ");
  __isoc99_scanf("%d", &root->age);
  printf("Enter username: ");
  read(0, root->username, 0x1FuLL);
}
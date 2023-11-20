ssize_t editUsername()
{
  if ( !root )
    bye();
  printf("Enter age of user: ");
  __isoc99_scanf("%d", (char *)root + 8);
  printf("Enter username: ");
  return read(0, *(void **)root, 0x1FuLL);
}

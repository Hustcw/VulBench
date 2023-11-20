int sub_8048637()
{
  char s[256];
  char v2;
  size_t nbytes;
  char *v4;

  puts("Welcome to my game server");
  puts("First, you need to tell me you name?");
  fgets(byte_804A180, 256, stdin);
  v4 = strrchr(byte_804A180, 10);
  if ( v4 )
    *v4 = 0;
  printf("Hello %s\n", byte_804A180);
  puts("What's you occupation?");
  fgets(byte_804A080, 256, stdin);
  v4 = strrchr(byte_804A080, 10);
  if ( v4 )
    *v4 = 0;
  printf("Well, my noble %s\n", byte_804A080);
  nbytes = snprintf(
             s,
             0x100u,
             "Our %s is a noble %s. He is come from north and well change out would.",
             byte_804A180,
             byte_804A080);
  puts("Here is you introduce");
  puts(s);
  puts("Do you want to edit you introduce by yourself?[Y/N]");
  v2 = getchar();
  getchar();
  if ( v2 == 89 )
    read(0, s, nbytes);
  return printf("name : %s\noccupation : %s\nintroduce : %s\n", byte_804A180, byte_804A080, s);
}

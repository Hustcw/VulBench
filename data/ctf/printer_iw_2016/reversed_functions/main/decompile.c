int __cdecl main()
{
  int v1; // [esp+Ch] [ebp-1Ch] BYREF
  char cp[20]; // [esp+10h] [ebp-18h] BYREF

  setbuf(stdout, 0);
  v1 = 0;
  puts("This is a remote printer!");
  printf("Enter IPv4 address:");
  __isoc99_scanf("%15s", cp);
  printf("Enter port:");
  __isoc99_scanf("%d", &v1);
  printf("Thank you, I'm trying to print %s:%d now!\n", cp, v1);
  sub_8048786(cp, v1);
  return 0;
}
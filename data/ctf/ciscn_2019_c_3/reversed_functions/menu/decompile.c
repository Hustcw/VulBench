__int64 menu()
{
  puts_flush("Welcome to my bar!!");
  putchar(10);
  puts_flush("Be careful that a group of drunks are coming to you.");
  putchar(10);
  printf("——You can choose a weapon to fight them.——");
  putchar(10);
  puts_flush("1: Create a weapon");
  puts_flush("2: Show me weapon");
  puts_flush("3: Fight!!Fight!!Fight!!");
  puts_flush("5: You are a loser!!byebye!!");
  return puts_flush("Command: ");
}
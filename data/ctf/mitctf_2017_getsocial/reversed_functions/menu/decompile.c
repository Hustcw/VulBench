int menu()
{
  puts("If you can write a million tweets, maybe I'll show you a secret.");
  return puts(
      "Commands:\n"
      "\t[0] print tweets\n"
      "\t[1] count tweets\n"
      "\t[2] overwrite an existing tweet\n"
      "\t[3] compose a new tweet");
}
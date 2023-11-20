int __cdecl main(int argc, const char **argv, const char **envp)
{
  char v4[5];

  setvbuf(stdout, 0, 2, 0);
  setvbuf(_bss_start, 0, 2, 0);
  puts("*************************************************");
  puts("            /\\____/\\    __");
  puts("          .'  \"\"\"\"  `,-'  `--.__");
  puts("     __,- :   -  -   ;  \" ::     `-. -.__");
  puts("  ,-sssss `._  `' _,'\"     ,'~~~::`.sssss-.");
  puts(" |ssssss ,' ,_`--'_    __,' ::  `  `.ssssss|");
  puts("|sssssss `-._____~ `,,'_______,---_;; ssssss|");
  puts(" |ssssssssss     `--'~{__   ____   ,'ssssss|");
  puts("  `-ssssssssssssssssss ~~~~~~~~~~~~ ssss.-'");
  puts("      `---.sssssssssssssssssssss.---' ");
  puts("************************************************");
  puts("Hey!Do you like cats?");
  __isoc99_scanf("%c", v4);
  if ( v4[0] == 121 || v4[0] == 89 )
  {
    play();
  }
  else if ( v4[0] == 110 || v4[0] == 78 )
  {
    puts("No...there is no flag for the guy who don't like cats..");
  }
  else
  {
    puts("answer my question OK?");
  }
  return 0;
}

unsigned __int64 banner()
{
  char format[12];
  unsigned __int64 v2;

  v2 = __readfsqword(0x28u);
  puts("Welcome to note management system!");
  printf("Enter your name: ");
  __isoc99_scanf("%s", format);
  printf("Hello, ");
  printf(format);
  puts("\n-------------------------------------");
  return __readfsqword(0x28u) ^ v2;
}
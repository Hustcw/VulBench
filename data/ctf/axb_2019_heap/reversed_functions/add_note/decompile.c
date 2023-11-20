unsigned __int64 add_note()
{
  unsigned int v0;
  unsigned int v1;
  unsigned int size;
  unsigned int size_4;
  unsigned __int64 v5;

  v5 = __readfsqword(0x28u);
  printf("Enter the index you want to create (0-10):");
  __isoc99_scanf("%d", &size_4);
  if ( size_4 < 0xB )
  {
    if ( counts > 0xAu )
    {
      puts("full!");
      exit(0);
    }
    puts("Enter a size:");
    __isoc99_scanf("%d", &size);
    if ( key == 43 )
    {
      puts("Enter the content: ");
      v0 = size_4;
      note[v0].content = (__int64)malloc(size);
      note[size_4].size = size;
      if ( !note[size_4].content )
      {
        fwrite("error", 1uLL, 5uLL, stderr);
        exit(0);
      }
    }
    else
    {
      if ( size <= 0x80 )
      {
        puts("You can't hack me!");
        return __readfsqword(0x28u) ^ v5;
      }
      puts("Enter the content: ");
      v1 = size_4;
      note[v1].content = (__int64)malloc(size);
      note[size_4].size = size;
      if ( !note[size_4].content )
      {
        fwrite("error", 1uLL, 5uLL, stderr);
        exit(0);
      }
    }
    if ( !(unsigned int)check_pass(&note[size_4]) )
    {
      puts("go out!hacker!");
      exit(0);
    }
    get_input(note[size_4].content, size);
    ++counts;
    puts("Done!");
  }
  else
  {
    puts("You can't hack me!");
  }
  return __readfsqword(0x28u) ^ v5;
}
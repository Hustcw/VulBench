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
      *((_QWORD *)&note + 2 * (int)v0) = malloc(size);
      *((_DWORD *)&note + 4 * (int)size_4 + 2) = size;
      if ( !*((_QWORD *)&note + 2 * (int)size_4) )
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
      *((_QWORD *)&note + 2 * (int)v1) = malloc(size);
      *((_DWORD *)&note + 4 * (int)size_4 + 2) = size;
      if ( !*((_QWORD *)&note + 2 * (int)size_4) )
      {
        fwrite("error", 1uLL, 5uLL, stderr);
        exit(0);
      }
    }
    if ( !check_pass((_QWORD *)&note + 2 * (int)size_4) )
    {
      puts("go out!hacker!");
      exit(0);
    }
    get_input(*((_QWORD *)&note + 2 * (int)size_4), size);
    ++counts;
    puts("Done!");
  }
  else
  {
    puts("You can't hack me!");
  }
  return __readfsqword(0x28u) ^ v5;
}

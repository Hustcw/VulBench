unsigned __int64 create_heap()
{
  int i;
  size_t size;
  char buf[8];
  unsigned __int64 v4;

  v4 = __readfsqword(0x28u);
  for ( i = 0; i <= 9; ++i )
  {
    if ( !heaparray[i] )
    {
      printf("Size of Heap : ");
      read(0, buf, 8uLL);
      size = atoi(buf);
      heaparray[i] = (char *)malloc(size);
      if ( !heaparray[i] )
      {
        puts("Allocate Error");
        exit(2);
      }
      printf("Content of heap:");
      read_input(heaparray[i], size);
      puts("SuccessFul");
      return __readfsqword(0x28u) ^ v4;
    }
  }
  return __readfsqword(0x28u) ^ v4;
}
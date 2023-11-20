void vote()
{
  __int64 *p_time;
  unsigned int v1;
  pthread_t newthread;
  unsigned __int64 v3;

  v3 = __readfsqword(0x28u);
  print("Please enter the index: ");
  v1 = read_int();
  if ( v1 <= 0xF )
  {
    if ( ptr[v1] )
    {
      ++ptr[v1]->count;
      p_time = &ptr[v1]->time;
      *p_time = time(0LL);
      idx = v1;
      pthread_create(&newthread, 0LL, start_routine, 0LL);
    }
  }
}
unsigned __int64 sub_400F09()
{
  time_t *v0;
  int v2;
  pthread_t newthread;
  unsigned __int64 v4;

  v4 = __readfsqword(0x28u);
  sub_400C52("Please enter the index: ");
  v2 = sub_400C90();
  if ( (unsigned int)v2 <= 0xF && *(&ptr + v2) )
  {
    ++*(_QWORD *)*(&ptr + v2);
    v0 = (time_t *)((char *)*(&ptr + v2) + 8);
    *v0 = time(0LL);
    dword_602160 = v2;
    pthread_create(&newthread, 0LL, start_routine, 0LL);
  }
  return __readfsqword(0x28u) ^ v4;
}

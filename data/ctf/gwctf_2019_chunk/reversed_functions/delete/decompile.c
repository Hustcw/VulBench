void delete()
{
  int v0;
  int v1;
  unsigned __int64 v2;

  v2 = __readfsqword(0x28u);
  v0 = 0;
  puts("Which one to throw?");
  _isoc99_scanf("%d", &v0);
  if ( (unsigned int)v0 < 0xB )
  {
    free(chunk[v0]);
    chunk[v0] = 0LL;
    --number;
    puts("Done!\n");
  }
  else
  {
    v1 = puts("Wrong!\n");
  }
}
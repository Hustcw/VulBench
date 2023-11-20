__int64 delete()
{
  unsigned int v1;
  unsigned __int64 v3;

  v3 = __readfsqword(0x28u);
  v1 = 0;
  puts("Which one to throw?");
  _isoc99_scanf(&unk_1108, &v1);
  if ( v1 < 0xB )
  {
    free((void *)chunk[v1]);
    chunk[v1] = 0LL;
    --number;
    return (unsigned int)puts("Done!\n");
  }
  else
  {
    return (unsigned int)puts("Wrong!\n");
  }
}

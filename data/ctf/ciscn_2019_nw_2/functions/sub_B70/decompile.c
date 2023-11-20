unsigned __int64 sub_B70()
{
  void *v1;
  unsigned int v2;
  unsigned __int64 v3;

  v3 = __readfsqword(0x28u);
  if ( dword_202010 )
  {
    puts("index:");
    __isoc99_scanf("%d", &v2);
    _IO_getc(stdin);
    if ( v2 <= 9 )
    {
      v1 = (void *)qword_202040[v2];
      if ( v1 )
      {
        free(v1);
        --dword_202010;
      }
    }
  }
  else
  {
    puts("no more free available");
  }
  return __readfsqword(0x28u) ^ v3;
}

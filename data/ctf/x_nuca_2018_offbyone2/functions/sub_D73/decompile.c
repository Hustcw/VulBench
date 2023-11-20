unsigned __int64 sub_D73()
{
  unsigned int v1;
  unsigned __int64 v2;

  v2 = __readfsqword(0x28u);
  printf("index: ");
  __isoc99_scanf("%d", &v1);
  if ( v1 <= 0xF && *((_QWORD *)&unk_2020C0 + (int)v1) )
  {
    free(*((void **)&unk_2020C0 + (int)v1));
    *((_QWORD *)&unk_2020C0 + (int)v1) = 0LL;
    puts("done.");
  }
  else
  {
    puts("invalid index.");
  }
  return __readfsqword(0x28u) ^ v2;
}

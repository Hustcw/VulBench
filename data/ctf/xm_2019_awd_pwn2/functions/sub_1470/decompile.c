unsigned __int64 sub_1470()
{
  unsigned int v1;
  unsigned __int64 v2;

  v2 = __readfsqword(0x28u);
  printf("idx:");
  v1 = sub_12EC();
  if ( v1 <= 0x13 && qword_4060[v1] )
  {
    free((void *)qword_4060[v1]);
    puts("Done!");
  }
  else
  {
    puts("invalid");
  }
  return __readfsqword(0x28u) ^ v2;
}

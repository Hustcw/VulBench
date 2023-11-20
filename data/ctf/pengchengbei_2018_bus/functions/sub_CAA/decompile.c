unsigned __int64 sub_CAA()
{
  int i;
  int v2;
  __int64 v3;
  void *ptr;
  unsigned __int64 v5;

  v5 = __readfsqword(0x28u);
  for ( i = 0; i <= 31 && qword_202080[i]; ++i )
    ;
  ptr = malloc(0x80uLL);
  printf("Where do you want to go: ");
  sub_B72((__int64)ptr, 128LL);
  v2 = sub_C37((const char *)ptr);
  if ( v2 == -1 )
  {
    qword_202080[i] = ptr;
    ++qword_202060;
  }
  else
  {
    puts("OK,more people huh?");
    i = v2;
    free(ptr);
  }
  printf("How many people: ");
  __isoc99_scanf("%lu", &v3);
  qword_202180[i] += v3;
  puts("Done!");
  return __readfsqword(0x28u) ^ v5;
}

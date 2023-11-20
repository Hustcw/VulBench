void sub_CAA()
{
  int i;
  int v1;
  __int64 v2;
  char *dest;
  unsigned __int64 v4;

  v4 = __readfsqword(0x28u);
  for ( i = 0; i <= 31 && destination[i]; ++i )
    ;
  dest = (char *)malloc(0x80uLL);
  printf("Where do you want to go: ");
  sub_B72(dest, 128LL);
  v1 = sub_C37(dest);
  if ( v1 == -1 )
  {
    destination[i] = dest;
    ++dest_cnt;
  }
  else
  {
    puts("OK,more people huh?");
    i = v1;
    free(dest);
  }
  printf("How many people: ");
  __isoc99_scanf("%lu", &v2);
  people_count[i] += v2;
  puts("Done!");
}
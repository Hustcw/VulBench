void sub_E37()
{
  unsigned int v0;
  unsigned __int64 v1;

  v1 = __readfsqword(0x28u);
  printf("index: ");
  __isoc99_scanf("%d", &v0);
  if ( v0 <= 0xF && byte_2020C0[v0] )
  {
    puts(byte_2020C0[v0]);
    puts("done.");
  }
  else
  {
    puts("invalid index.");
  }
}
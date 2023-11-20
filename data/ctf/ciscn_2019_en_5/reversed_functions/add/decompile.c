void add()
{
  int i; // [rsp+Ch] [rbp-24h]
  int j; // [rsp+10h] [rbp-20h]
  int a2; // [rsp+14h] [rbp-1Ch]
  unsigned __int64 size; // [rsp+18h] [rbp-18h]
  char *a1; // [rsp+20h] [rbp-10h]

  for ( i = 0; i <= 19 && content[i]; ++i )
    ;
  if ( i <= 20 )
  {
    printf("length> ");
    a2 = read_int();
    if ( a2 > 7 && a2 <= 512 )
    {
      size = (int)((a2 + 15) & 0xFFFFFFF8);
      a1 = (char *)malloc(size);
      for ( j = 0; j <= size; ++j )
        a1[j] = 0;
      printf("content> ");
      read_str(a1, a2);
      content[i] = a1;
      content_size[i] = size;
      puts("done");
    }
    else
    {
      puts("invalid length");
    }
  }
  else
  {
    puts("full");
  }
}
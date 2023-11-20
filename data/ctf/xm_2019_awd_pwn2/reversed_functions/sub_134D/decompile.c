unsigned __int64 sub_134D()
{
  int i; // [rsp+0h] [rbp-10h]
  int v2; // [rsp+4h] [rbp-Ch]
  unsigned __int64 v3; // [rsp+8h] [rbp-8h]

  v3 = __readfsqword(0x28u);
  printf("size:");
  v2 = read_int();
  if ( v2 > 0 && v2 <= 4095 )
  {
    for ( i = 0; i <= 19 && qword_4060[i]; ++i )
      ;
    if ( i <= 19 )
    {
      qword_4060[i] = malloc(v2);
      printf("content:");
      read_str((char *)qword_4060[i], v2);
      puts("Done!");
    }
    else
    {
      puts("full");
    }
  }
  else
  {
    puts("invalid");
  }
  return __readfsqword(0x28u) ^ v3;
}
void __fastcall new_name()
{
  int i; // [rsp+8h] [rbp-8h]
  int a2; // [rsp+Ch] [rbp-4h]

  for ( i = 0; a1[i] && i <= 19; ++i )
    ;
  if ( i <= 19 )
  {
    printf("Name Size:");
    a2 = read_int();
    if ( a2 <= 15 || a2 > 96 )
    {
      puts("Invalid size !!");
    }
    else
    {
      printf("Name:");
      a1[i] = (char *)malloc(a2);
      read_str(a1[i], a2);
      puts("Done!");
    }
  }
  else
  {
    puts("Not any more !!");
  }
}
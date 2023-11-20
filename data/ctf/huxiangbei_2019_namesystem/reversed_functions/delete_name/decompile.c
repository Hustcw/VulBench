void __fastcall delete_name()
{
  unsigned int v0; // [rsp+Ch] [rbp-4h]

  printf("The id you want to delete:");
  v0 = read_int();
  if ( v0 <= 0x13 && a1[v0] )
  {
    free(a1[v0]);
    a1[v0] = 0LL;
    while ( (int)(v0 + 1) <= 19 )
    {
      a1[v0] = a1[v0 + 1];
      ++v0;
    }
    puts("Done!");
  }
  else
  {
    puts("Invalid id !!");
  }
}
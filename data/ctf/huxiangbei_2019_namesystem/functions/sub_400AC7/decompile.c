int sub_400AC7()
{
  int v1;

  printf("The id you want to delete:");
  v1 = sub_400941();
  if ( (unsigned int)v1 > 0x13 || !*(&ptr + v1) )
    return puts("Invalid id !!");
  free(*(&ptr + v1));
  *(&ptr + v1) = 0LL;
  while ( v1 + 1 <= 19 )
  {
    *(&ptr + v1) = *(&ptr + v1 + 1);
    ++v1;
  }
  return puts("Done!");
}

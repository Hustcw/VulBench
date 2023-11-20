int sub_400CC6()
{
  int i;

  puts("List of indexed papers:");
  for ( i = 0; i < dword_60208C; ++i )
    printf("[%d] %s \"%s\"\n", (unsigned int)i, &byte_6020A0[1088 * i + 256], &byte_6020A0[1088 * i]);
  return puts("\n");
}

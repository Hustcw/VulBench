int __fastcall sub_400D52(const char *a1)
{
  printf("Paper name:\n\t\"%s\"\nAuthors:\n\t%s\n", a1, a1 + 256);
  printf("Abstract:\n\t");
  if ( a1[512] )
    printf(a1 + 512);
  else
    printf("N/A");
  printf("\nTags:\n\t");
  if ( a1[1024] )
    printf(a1 + 1024);
  else
    printf("N/A");
  return puts("\n\n");
}

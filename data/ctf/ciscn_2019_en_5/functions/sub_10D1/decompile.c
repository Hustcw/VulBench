void __noreturn sub_10D1()
{
  printf("remarks> ");
  sub_B41(*((_BYTE **)ptr + 4), 64);
  printf("good bye %s\n", (const char *)ptr);
  free(ptr);
  exit(0);
}

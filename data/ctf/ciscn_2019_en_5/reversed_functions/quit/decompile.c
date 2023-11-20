void __noreturn quit()
{
  printf("remarks> ");
  read_str(*((_BYTE **)a1 + 4), 64);
  printf("good bye %s\n", a1);
  free(a1);
  exit(0);
}
unsigned __int64 sub_BD9()
{
  unsigned __int64 v1;
  char s[24];
  unsigned __int64 v3;

  v3 = __readfsqword(0x28u);
  puts("Which goods you need to modify?");
  fgets(s, 24, stdin);
  v1 = strtoul(s, 0LL, 0);
  printf("OK, what would you like to modify %s to?\n", *(const char **)qword_2021E0[v1]);
  *(_BYTE *)(*(_QWORD *)qword_2021E0[v1] + read(0, *(void **)qword_2021E0[v1], 8uLL)) = 0;
  return __readfsqword(0x28u) ^ v3;
}

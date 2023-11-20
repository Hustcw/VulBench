void sub_BD9()
{
  unsigned __int64 v0;
  char s[24];
  unsigned __int64 v2;

  v2 = __readfsqword(0x28u);
  puts("Which goods you need to modify?");
  fgets(s, 24, stdin);
  v0 = strtoul(s, 0LL, 0);
  printf("OK, what would you like to modify %s to?\n", qword_2021E0[v0]->field_0);
  qword_2021E0[v0]->field_0[read(0, qword_2021E0[v0]->field_0, 8uLL)] = 0;
}
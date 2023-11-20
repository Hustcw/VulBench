void show()
{
  char nptr;
  int v1;
  unsigned __int64 v2;

  v2 = __readfsqword(0x28u);
  printf("Which book do you want to show?");
  read_str(&nptr, 16);
  v1 = atoi(&nptr);
  printf("Content: %s", chunk[v1]);
}
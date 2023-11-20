char *write_mail()
{
  int v0;
  char *result;
  char *v2;

  printf("Content Length: ");
  v0 = readint();
  v2 = (char *)new_mail(v0);
  printf("Title: ");
  gets(v2 + 4);
  printf("Content: ");
  gets(v2 + 72);
  *(_DWORD *)v2 = root;
  result = v2;
  root = (int)v2;
  return result;
}

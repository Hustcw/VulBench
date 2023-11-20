void write_mail()
{
  int v0;
  Mail *v1;

  printf("Content Length: ");
  v0 = readint();
  v1 = (Mail *)new_mail(v0);
  printf("Title: ");
  gets(v1->title);
  printf("Content: ");
  gets(v1->content);
  v1->root = root;
  root = v1;
}
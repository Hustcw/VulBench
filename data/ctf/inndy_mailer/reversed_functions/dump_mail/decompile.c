void dump_mail()
{
  Mail *v0;
  int v1;

  v0 = root;
  v1 = 1;
  while ( v0 )
  {
    printf("-- Mail %d:\n", v1);
    printf("Title: %s\n", v0->title);
    printf("Content: ");
    fwrite(v0->content, 1u, v0->content_len, stdout);
    printf("\n-- End mail %d\n", v1++);
    v0 = v0->root;
  }
  puts("-- No more mail!");
}
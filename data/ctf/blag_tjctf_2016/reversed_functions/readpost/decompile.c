void readpost()
{
  int v0;
  Post *v1;
  char v2[8];
  unsigned int v3;

  v3 = __readgsdword(0x14u);
  puts("Index?");
  readline(v2, 8, stdin);
  __isoc99_sscanf(v2, "%d", &v0);
  if ( v0 < numposts && v0 >= 0 )
  {
    v1 = posts[v0];
    if ( isadmin || !v1->b )
      printf("%s by %s:\n%s\n", v1->title, v1->author, v1->body);
    else
      puts("Admin only!");
  }
  else
  {
    puts("Invalid index!");
  }
}
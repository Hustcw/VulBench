void delete()
{
  unsigned int v0;
  unsigned __int64 v1;

  v1 = __readfsqword(0x28u);
  puts("Input the index:");
  v0 = 0;
  _isoc99_scanf("%d", &v0);
  if ( v0 <= 9 && notes[v0] )
  {
    free(notes[v0]);
    notes[v0] = 0LL;
    size[v0] = 0;
    puts("Delete success");
  }
  else
  {
    puts("Delete fail");
  }
}
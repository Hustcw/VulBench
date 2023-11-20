void update()
{
  int v0;
  unsigned int nbytes;
  int nbytes_4;
  unsigned __int64 v3;

  v3 = __readfsqword(0x28u);
  puts("Input the index:");
  v0 = 0;
  nbytes = 0;
  _isoc99_scanf("%d", &v0);
  if ( v0 <= 9 && notes[v0] )
  {
    puts("Input size:");
    _isoc99_scanf("%d", &nbytes);
    if ( size[v0] < nbytes )
      nbytes = size[v0];
    puts("Input new content:");
    nbytes_4 = read(0, notes[v0], nbytes);
    if ( size[v0] == nbytes_4 )
      notes[v0][nbytes_4] = 0;
  }
  else
  {
    puts("Edit fail");
  }
}
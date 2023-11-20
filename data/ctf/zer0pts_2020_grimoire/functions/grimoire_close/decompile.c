unsigned __int64 grimoire_close()
{
  unsigned __int64 v1;

  v1 = __readfsqword(0x28u);
  if ( fp )
  {
    puts("You closed the book before something bad happens.");
    fclose(fp);
    fp = 0LL;
    init = 0;
  }
  else
  {
    puts("You don't even open the book.");
  }
  return __readfsqword(0x28u) ^ v1;
}

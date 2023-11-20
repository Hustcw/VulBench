unsigned __int64 grimoire_open()
{
  unsigned __int64 v1;

  v1 = __readfsqword(0x28u);
  if ( fp )
  {
    puts("The desk is occupied with another book.");
  }
  else
  {
    fp = fopen(filepath, "r");
    if ( fp )
    {
      puts("You opened the forbidden grimoire.");
    }
    else
    {
      error(filepath, "No such file or directory");
      puts("You lost the grimoire...");
    }
  }
  return __readfsqword(0x28u) ^ v1;
}

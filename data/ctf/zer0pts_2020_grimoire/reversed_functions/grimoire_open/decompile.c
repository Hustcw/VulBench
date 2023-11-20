void grimoire_open()
{
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
}
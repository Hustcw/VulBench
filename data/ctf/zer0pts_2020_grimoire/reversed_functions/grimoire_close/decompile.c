void grimoire_close()
{
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
}
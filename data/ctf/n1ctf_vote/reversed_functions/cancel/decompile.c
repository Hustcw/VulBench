void cancel()
{
  unsigned int v0;

  print("Please enter the index: ");
  v0 = read_int();
  if ( v0 <= 0xF && ptr[v0] )
  {
    if ( --vote_list[v0] == --ptr[v0]->count )
    {
      if ( vote_list[v0] < 0 )
        free(ptr[v0]);
    }
    else if ( vote_list[v0] < 0 )
    {
      printf("%s", ptr[idx]->name);
      fflush(stdout);
      println(" has freed");
      free(ptr[v0]);
      ptr[v0] = 0LL;
    }
  }
}
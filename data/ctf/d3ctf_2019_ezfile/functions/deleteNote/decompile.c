void __cdecl deleteNote()
{
  unsigned int i;

  myputs("input the index to delete >>", 0);
  i = getNumber();
  if ( i < 0x10 )
  {
    if ( notes[i] )
    {
      free(notes[i]);
      states[i] = 0;
      myputs("complete", 1);
    }
    else
    {
      myputs("in using", 1);
    }
  }
  else
  {
    myputs("out of index", 1);
  }
}

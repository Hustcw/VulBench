void __cdecl addNote()
{
  int v0;
  unsigned int size;
  int sizea;
  int i;

  for ( i = 0; i <= 14 && notes[i]; ++i )
    ;
  if ( i == 15 )
  {
    myputs("full!", 1);
  }
  else
  {
    notes[i] = (char *)malloc(0x10uLL);
    myputs("size of your note >>", 0);
    size = getNumber();
    if ( size > 0x18 )
      v0 = 24;
    else
      v0 = size;
    sizea = v0;
    if ( !notes[i] )
    {
      myputs("error in malloc note", 1);
      exit(0);
    }
    myputs("input your content >>", 0);
    getContent(notes[i], sizea);
    states[i] = 1;
    myputs("success", 1);
  }
}

void __cdecl doSomeThing(char *seed, int index)
{
  unsigned __int8 start;
  int i;

  if ( (unsigned int)index <= 0xF && states[index] )
  {
    start = seed[index];
    for ( i = 0; i <= 15; ++i )
      notes[index][i] ^= key[start + i];
    myputs("success", 1);
  }
}

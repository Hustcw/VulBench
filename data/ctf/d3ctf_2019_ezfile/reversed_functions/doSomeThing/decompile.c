void __cdecl doSomeThing(char *seed, int index)
{
  unsigned __int8 start; // [rsp+1Bh] [rbp-5h]
  int i; // [rsp+1Ch] [rbp-4h]

  if ( (unsigned int)index <= 0xF && states[index] )
  {
    start = seed[index];
    for ( i = 0; i <= 15; ++i )
      notes[index][i] ^= key[start + i];
    myputs("success", 1);
  }
}
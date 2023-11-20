unsigned __int64 sub_B0E()
{
  int v1;
  unsigned int i;
  unsigned __int64 v3;

  v3 = __readfsqword(0x28u);
  if ( dword_202050 > 5 )
  {
    puts("You can't add any more notes!");
    exit(0);
  }
  for ( i = 0; i <= 4 && *((_QWORD *)&unk_202070 + 4 * i); ++i )
    ;
  puts("How long is your note?");
  _isoc99_scanf("%u", &v1);
  if ( i > 0x80 )
  {
    puts("Too long!");
    exit(0);
  }
  *((_QWORD *)&unk_202070 + 4 * i) = 1LL;
  *((_QWORD *)&unk_202078 + 4 * i) = malloc((unsigned int)(v1 + 1));
  puts("Input your note name and note content:");
  sub_AD6((char *)&unk_202060 + 32 * i, 0x15u);
  sub_AD6(*((char **)&unk_202078 + 4 * i), v1);
  ++dword_202050;
  puts("Done!");
  return __readfsqword(0x28u) ^ v3;
}

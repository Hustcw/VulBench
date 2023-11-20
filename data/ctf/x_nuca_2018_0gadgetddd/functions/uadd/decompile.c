__int64 uadd()
{
  int i;
  int j;
  int v3;
  char s[264];
  unsigned __int64 v5;

  v5 = __readfsqword(0x28u);
  write(1, "please input the note size: ", 0x1CuLL);
  v3 = input_choice();
  if ( v3 > 256 )
  {
    write(1, "Stop heap abuse!!\n", 0x12uLL);
    exit(0);
  }
  for ( i = 0; i <= 15 && *((_DWORD *)&notebook + 40 * i); ++i )
    ;
  if ( i > 15 )
  {
    write(1, "Too much note!!\n", 0x10uLL);
    exit(0);
  }
  memset((void *)(160LL * i + 6299880), 0, 0x90uLL);
  memset(s, 0, 0x100uLL);
  *(_QWORD *)&dword_6020E4[40 * i + 37] = malloc(v3);
  write(1, "Please input the title: ", 0x18uLL);
  input2addr((__int64)s, 144);
  write(1, "Please input the content: ", 0x1AuLL);
  if ( read(0, *(void **)&dword_6020E4[40 * i + 37], v3) < 0 )
    exit(1);
  *((_DWORD *)&notebook + 40 * i) = 1;
  dword_6020E4[40 * i] = v3;
  for ( j = 0; j <= 144; ++j )
  {
    *((_BYTE *)&dword_6020E4[40 * i + 1] + j) = s[j];
    if ( !s[j] )
      break;
  }
  return 0LL;
}

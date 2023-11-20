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
  for ( i = 0; i <= 15 && notebook[i].used; ++i )
    ;
  if ( i > 15 )
  {
    write(1, "Too much note!!\n", 0x10uLL);
    exit(0);
  }
  memset(notebook[i].title, 0, 0x90uLL);
  memset(s, 0, 0x100uLL);
  notebook[i].content = (char *)malloc(v3);
  write(1, "Please input the title: ", 0x18uLL);
  input2addr(s, 0x90);
  write(1, "Please input the content: ", 0x1AuLL);
  if ( read(0, notebook[i].content, v3) < 0 )
    exit(1);
  notebook[i].used = 1;
  notebook[i].size = v3;
  for ( j = 0; j <= 0x90; ++j )
  {
    notebook[i].title[j] = s[j];
    if ( !s[j] )
      break;
  }
  return 0LL;
}
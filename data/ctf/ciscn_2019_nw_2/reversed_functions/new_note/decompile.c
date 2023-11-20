void new_note()
{
  __int64 v0; // rax
  __int64 v1; // rbx

  v0 = 1LL;
  if ( qword_202040[0] )
  {
    do
      v1 = (int)v0++;
    while ( qword_202040[v1] );
  }
  else
  {
    v1 = 0LL;
  }
  qword_202040[v1] = (Note *)malloc(0x70uLL);
  puts("title:");
  read(0, qword_202040[v1], 8uLL);
  puts("content:");
  read(0, qword_202040[v1]->content, 0x68uLL);
  __printf_chk(1LL, "%s %s", qword_202040[v1]->title, qword_202040[v1]->content);
}
void __cdecl myputs(const char *str, int newline)
{
  int v2;
  int len;

  len = 0;
  do
    v2 = len++;
  while ( str[v2] );
  write(1, str, len - 1);
  if ( newline )
    write(1, &unk_1348, 1uLL);
}

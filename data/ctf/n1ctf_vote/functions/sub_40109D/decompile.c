void sub_40109D()
{
  int v0;

  sub_400C52("Please enter the index: ");
  v0 = sub_400C90();
  if ( (unsigned int)v0 <= 0xF && *(&ptr + v0) )
  {
    if ( --qword_602180[v0] == --*(_QWORD *)*(&ptr + v0) )
    {
      if ( qword_602180[v0] < 0 )
        free(*(&ptr + v0));
    }
    else if ( qword_602180[v0] < 0 )
    {
      printf("%s", (const char *)*(&ptr + dword_602160) + 16);
      fflush(stdout);
      sub_400C00(" has freed");
      free(*(&ptr + v0));
      *(&ptr + v0) = 0LL;
    }
  }
}

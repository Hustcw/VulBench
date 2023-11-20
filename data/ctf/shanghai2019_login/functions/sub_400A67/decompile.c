unsigned __int64 sub_400A67()
{
  unsigned int v1;
  int v2;
  char s[264];
  unsigned __int64 v4;

  v4 = __readfsqword(0x28u);
  puts("Input the user id:");
  v1 = 0;
  _isoc99_scanf("%d", &v1);
  if ( v1 > 9 )
  {
    puts("Wrong id!");
  }
  else if ( qword_602040[v1] )
  {
    puts("Input the passwords length:");
    v2 = 0;
    _isoc99_scanf("%d", &v2);
    if ( v2 > 255 )
    {
      puts("Illegal length!");
    }
    else
    {
      memset(s, 0, 0x100uLL);
      puts("Input the password:");
      read(0, s, v2);
      if ( !strcmp(s, *(const char **)qword_602040[v1]) )
      {
        sub_400A54();
        (*(void (__fastcall **)(_QWORD))(qword_602040[v1] + 8LL))(*(_QWORD *)qword_602040[v1]);
      }
      else
      {
        puts("Wrong password!");
      }
    }
  }
  else
  {
    puts("No such user!");
  }
  return __readfsqword(0x28u) ^ v4;
}

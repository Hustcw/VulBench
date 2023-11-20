void sub_400A67()
{
  unsigned int v0;
  int v1;
  char s[264];
  unsigned __int64 v3;

  v3 = __readfsqword(0x28u);
  puts("Input the user id:");
  v0 = 0;
  _isoc99_scanf("%d", &v0);
  if ( v0 > 9 )
  {
    puts("Wrong id!");
  }
  else if ( *((_QWORD *)&qword_602040 + (int)v0) )
  {
    puts("Input the passwords length:");
    v1 = 0;
    _isoc99_scanf("%d", &v1);
    if ( v1 > 255 )
    {
      puts("Illegal length!");
    }
    else
    {
      memset(s, 0, 0x100uLL);
      puts("Input the password:");
      read(0, s, v1);
      if ( !strcmp(s, **((const char ***)&qword_602040 + (int)v0)) )
      {
        sub_400A54();
        (*(void (__fastcall **)(_QWORD))(*((_QWORD *)&qword_602040 + (int)v0) + 8LL))(**((_QWORD **)&qword_602040
                                                                                       + (int)v0));
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
}
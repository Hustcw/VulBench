void sub_4008C5()
{
  unsigned int v0;
  unsigned int v1;
  void *buf;
  _QWORD *v3;
  unsigned __int64 v4;

  v4 = __readfsqword(0x28u);
  puts("Input the user id:");
  v0 = 0;
  v1 = 0;
  _isoc99_scanf("%d", &v0);
  if ( v0 > 5 )
  {
    puts("Wrong id!");
  }
  else if ( qword_602040[v0] )
  {
    puts("User already exists!");
  }
  else
  {
    puts("Input the password length:");
    _isoc99_scanf("%d", &v1);
    if ( v1 < 0x101 )
    {
      buf = malloc((int)v1);
      if ( buf )
      {
        puts("Input password:");
        read(0, buf, (int)v1);
        v3 = malloc(0x18uLL);
        v3[1] = sub_40089E;
        *v3 = buf;
        *((_DWORD *)v3 + 4) = v1;
        qword_602040[v0] = v3;
        puts("Register success!");
      }
      else
      {
        puts("malloc error!");
      }
    }
    else
    {
      puts("Illegal length!");
    }
  }
}
unsigned __int64 sub_4008C5()
{
  unsigned int v1;
  unsigned int v2;
  void *buf;
  _QWORD *v4;
  unsigned __int64 v5;

  v5 = __readfsqword(0x28u);
  puts("Input the user id:");
  v1 = 0;
  v2 = 0;
  _isoc99_scanf("%d", &v1);
  if ( v1 > 5 )
  {
    puts("Wrong id!");
  }
  else if ( qword_602040[v1] )
  {
    puts("User already exists!");
  }
  else
  {
    puts("Input the password length:");
    _isoc99_scanf("%d", &v2);
    if ( v2 < 0x101 )
    {
      buf = malloc((int)v2);
      if ( buf )
      {
        puts("Input password:");
        read(0, buf, (int)v2);
        v4 = malloc(0x18uLL);
        v4[1] = sub_40089E;
        *v4 = buf;
        *((_DWORD *)v4 + 4) = v2;
        qword_602040[v1] = v4;
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
  return __readfsqword(0x28u) ^ v5;
}

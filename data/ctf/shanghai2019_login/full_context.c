_QWORD qword_602040[6];

int __fastcall sub_40089E(const char *a1)
{
  puts("You password is:");
  return puts(a1);
}

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

int sub_400A54()
{
  return puts("Login success!");
}

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

void sub_400C2A()
{
  unsigned int v0;
  unsigned __int64 v1;

  v1 = __readfsqword(0x28u);
  puts("Input the user id:");
  v0 = 0;
  _isoc99_scanf("%d", &v0);
  if ( v0 > 5 )
  {
    puts("Wrong id!");
  }
  else if ( qword_602040[v0] )
  {
    free(*(void **)qword_602040[v0]);
    free((void *)qword_602040[v0]);
    puts("Delete success!");
  }
  else
  {
    puts("No such user!");
  }
}

void sub_400D05()
{
  unsigned int v0;
  unsigned __int64 v1;

  v1 = __readfsqword(0x28u);
  puts("Input the user id:");
  v0 = 0;
  _isoc99_scanf("%d", &v0);
  if ( v0 > 5 )
  {
    puts("Wrong id!");
  }
  else if ( qword_602040[v0] )
  {
    puts("Input new pass:");
    read(0, *(void **)qword_602040[v0], *(int *)(qword_602040[v0] + 16LL));
  }
  else
  {
    puts("No such user!");
  }
}

__int64 __fastcall main(__int64 a1, char **a2, char **a3)
{
  int v4;

  while ( 1 )
  {
    v4 = 0;
    puts("Choice:");
    _isoc99_scanf("%d", &v4);
    switch ( v4 )
    {
      case 1:
        sub_400A67();
        break;
      case 2:
        sub_4008C5();
        break;
      case 3:
        sub_400C2A();
        break;
      case 4:
        sub_400D05();
        break;
      case 5:
        puts("Exit");
        return 0LL;
      default:
        puts("What?");
        break;
    }
  }
}
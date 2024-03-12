int n; // weak
char t[8]; // idb

void __fastcall show_num(int *a1)
{
  __int64 v1; // rax
  __int64 v2; // rax
  int j; // [rsp+1Ch] [rbp-4h]
  int i; // [rsp+1Ch] [rbp-4h]

  if ( n > 19 )
  {
    for ( i = 0; i <= 19; ++i )
    {
      v2 = std::ostream::operator<<(&std::cout, (unsigned int)a1[i]);
      std::operator<<<std::char_traits<char>>(v2, &unk_401274);
    }
  }
  else
  {
    for ( j = 0; j < n; ++j )
    {
      v1 = std::ostream::operator<<(&std::cout, (unsigned int)a1[j]);
      std::operator<<<std::char_traits<char>>(v1, &unk_401274);
    }
  }
  std::ostream::operator<<(&std::cout, &std::endl<char,std::char_traits<char>>);
}

void show_menu(void)
{
  __int64 v0; // rax
  __int64 v1; // rax
  __int64 v2; // rax
  __int64 v3; // rax

  v0 = std::operator<<<std::char_traits<char>>(&std::cout, "1.change num.");
  std::ostream::operator<<(v0, &std::endl<char,std::char_traits<char>>);
  v1 = std::operator<<<std::char_traits<char>>(&std::cout, "2.get array.");
  std::ostream::operator<<(v1, &std::endl<char,std::char_traits<char>>);
  v2 = std::operator<<<std::char_traits<char>>(&std::cout, "3.unique.");
  std::ostream::operator<<(v2, &std::endl<char,std::char_traits<char>>);
  v3 = std::operator<<<std::char_traits<char>>(&std::cout, "4.exit.");
  std::ostream::operator<<(v3, &std::endl<char,std::char_traits<char>>);
  std::operator<<<std::char_traits<char>>(&std::cout, "> ");
}

void __fastcall do_unique(__gnu_cxx::__ops *a1)
{
  std::unique<int *>(a1, (_DWORD *)a1 + n);
  show_num((int *)a1);
}

void change_num(void)
{
  std::operator>><char,std::char_traits<char>>(&std::cin, t);
  n = atoi(t);
  memset(t, 0, sizeof(t));
}

void __fastcall get_array(int *a1)
{
  unsigned int v1; // ebx
  __int64 v2; // rax
  __int64 v3; // rax
  __int64 v4; // rax
  int i; // [rsp+1Ch] [rbp-14h]

  v1 = n;
  v2 = std::operator<<<std::char_traits<char>>(&std::cout, "input ");
  v3 = std::ostream::operator<<(v2, v1);
  v4 = std::operator<<<std::char_traits<char>>(v3, " num:");
  std::ostream::operator<<(v4, &std::endl<char,std::char_traits<char>>);
  for ( i = 0; i < n; ++i )
  {
    std::operator>><char,std::char_traits<char>>(&std::cin, t);
    a1[i] = atoi(t);
    memset(t, 0, sizeof(t));
  }
}

int __cdecl main(int argc, const char **argv, const char **envp)
{
  __int64 v3; // rax
  __int64 v4; // rax
  char v6; // [rsp+Fh] [rbp-61h] BYREF
  int a1[22]; // [rsp+10h] [rbp-60h] BYREF
  unsigned __int64 v8; // [rsp+68h] [rbp-8h]

  v8 = __readfsqword(0x28u);
  v3 = std::operator<<<std::char_traits<char>>(&std::cout, "Welcome come to QCTF 2018.");
  std::ostream::operator<<(v3, &std::endl<char,std::char_traits<char>>);
  v4 = std::operator<<<std::char_traits<char>>(&std::cout, "input n:");
  std::ostream::operator<<(v4, &std::endl<char,std::char_traits<char>>);
  std::operator>><char,std::char_traits<char>>(&std::cin, t);
  n = atoi(t);
  do
  {
    while ( 1 )
    {
      while ( 1 )
      {
        while ( 1 )
        {
          show_menu();
          std::operator>><char,std::char_traits<char>>(&std::cin, &v6);
          v6 -= 48;
          fflush(stdin);
          if ( v6 != 2 )
            break;
          get_array(a1);
        }
        if ( v6 > 2 )
          break;
        if ( v6 == 1 )
          change_num();
      }
      if ( v6 != 3 )
        break;
      do_unique(a1);
    }
  }
  while ( v6 != 4 );
  return 0;
}
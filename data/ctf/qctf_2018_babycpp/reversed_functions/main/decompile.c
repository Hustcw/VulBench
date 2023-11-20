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
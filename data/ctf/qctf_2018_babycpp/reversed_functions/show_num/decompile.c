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
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
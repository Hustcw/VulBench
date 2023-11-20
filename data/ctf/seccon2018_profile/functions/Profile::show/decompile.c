__int64 __fastcall Profile::show(Profile *this)
{
  __int64 v1;
  __int64 v2;
  unsigned int v3;
  __int64 v4;
  __int64 v5;
  __int64 v6;
  __int64 v7;

  v1 = std::operator<<<std::char_traits<char>>(&std::cout, "Name : ");
  v2 = std::operator<<<char>(v1, (char *)this + 32);
  std::ostream::operator<<(v2, &std::endl<char,std::char_traits<char>>);
  v3 = *((_DWORD *)this + 16);
  v4 = std::operator<<<std::char_traits<char>>(&std::cout, "Age  : ");
  v5 = std::ostream::operator<<(v4, v3);
  std::ostream::operator<<(v5, &std::endl<char,std::char_traits<char>>);
  v6 = std::operator<<<std::char_traits<char>>(&std::cout, "Msg  : ");
  v7 = std::operator<<<char>(v6, this);
  return std::ostream::operator<<(v7, &std::endl<char,std::char_traits<char>>);
}

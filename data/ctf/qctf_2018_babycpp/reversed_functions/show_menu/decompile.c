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
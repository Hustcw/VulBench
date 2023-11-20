void change_num(void)
{
  std::operator>><char,std::char_traits<char>>(&std::cin, t);
  n = atoi(t);
  memset(t, 0, sizeof(t));
}
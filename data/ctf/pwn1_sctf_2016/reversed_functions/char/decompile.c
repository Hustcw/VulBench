std::string *__stdcall std::operator+<char>(std::string *a1, std::string *a2, std::string *a3)
{
  std::string::string(a1, a2);
  std::string::append(a1, a3);
  return a1;
}
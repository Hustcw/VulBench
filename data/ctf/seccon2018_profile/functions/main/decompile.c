int __cdecl main(int argc, const char **argv, const char **envp)
{
  __int64 v3;
  __int64 v4;
  __int64 v5;
  __int64 v6;
  __int64 v7;
  __int64 v8;
  __int64 v9;
  __int64 v10;
  __int64 v11;
  int v13;
  char v14[32];
  char v15[32];
  char v16[32];
  char v17[72];
  unsigned __int64 v18;

  v18 = __readfsqword(0x28u);
  Profile::Profile((Profile *)v17);
  std::string::basic_string(v14, argv);
  v3 = std::operator<<<std::char_traits<char>>(&std::cout, "Please introduce yourself!");
  std::ostream::operator<<(v3, &std::endl<char,std::char_traits<char>>);
  std::operator<<<std::char_traits<char>>(&std::cout, "Name >> ");
  std::operator>><char>(&std::cin, v14);
  std::string::basic_string(v15, v14);
  Profile::set_name(v17, v15);
  std::string::~string(v15);
  std::operator<<<std::char_traits<char>>(&std::cout, "Age >> ");
  std::istream::operator>>(&std::cin, &v13);
  Profile::set_age((Profile *)v17, v13);
  std::operator<<<std::char_traits<char>>(&std::cout, "Message >> ");
  std::operator>><char>(&std::cin, v14);
  std::string::basic_string(v16, v14);
  Profile::set_msg(v17, v16);
  std::string::~string(v16);
  do
  {
    v4 = std::ostream::operator<<(&std::cout, &std::endl<char,std::char_traits<char>>);
    v5 = std::operator<<<std::char_traits<char>>(v4, "1 : update message");
    v6 = std::ostream::operator<<(v5, &std::endl<char,std::char_traits<char>>);
    v7 = std::operator<<<std::char_traits<char>>(v6, "2 : show profile");
    v8 = std::ostream::operator<<(v7, &std::endl<char,std::char_traits<char>>);
    v9 = std::operator<<<std::char_traits<char>>(v8, "0 : exit");
    v10 = std::ostream::operator<<(v9, &std::endl<char,std::char_traits<char>>);
    std::operator<<<std::char_traits<char>>(v10, ">> ");
    std::istream::operator>>(&std::cin, &v13);
    getchar();
    if ( v13 == 1 )
    {
      Profile::update_msg((Profile *)v17);
    }
    else if ( v13 == 2 )
    {
      Profile::show((Profile *)v17);
    }
    else
    {
      v11 = std::operator<<<std::char_traits<char>>(&std::cout, "Wrong input...");
      std::ostream::operator<<(v11, &std::endl<char,std::char_traits<char>>);
    }
  }
  while ( v13 );
  std::string::~string(v14);
  Profile::~Profile((Profile *)v17);
  return 0;
}

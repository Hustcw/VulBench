

__int64 __fastcall Profile::update_msg(Profile *this)
{
  __int64 v1;
  void *ptr;
  size_t v4;

  ptr = (void *)std::string::c_str(this);
  v4 = malloc_usable_size(ptr);
  if ( v4 )
  {
    std::operator<<<std::char_traits<char>>(&std::cout, "Input new message >> ");
    return getn((char *)ptr, v4);
  }
  else
  {
    v1 = std::operator<<<std::char_traits<char>>(&std::cout, "Unable to update message.");
    return std::ostream::operator<<(v1, &std::endl<char,std::char_traits<char>>);
  }
}

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

__int64 __fastcall getn(char *a1, unsigned int a2)
{
  char buf;
  unsigned int i;

  for ( i = 0; i < a2; ++i )
  {
    read(0, &buf, 1uLL);
    if ( buf == 10 )
      break;
    a1[i] = buf;
  }
  return i;
}

void __fastcall Profile::Profile(Profile *this, __int64 a2)
{
  std::string::basic_string(this, a2);
  std::string::basic_string((char *)this + 32, a2);
  std::string::operator=((char *)this + 32, &unk_401734);
  *((_DWORD *)this + 16) = 0;
  std::string::operator=(this, &unk_401734);
}

__int64 __fastcall Profile::set_name(__int64 a1, __int64 a2)
{
  return std::string::operator=(a1 + 32, a2);
}

Profile *__fastcall Profile::set_age(Profile *this, int a2)
{
  Profile *result;

  result = this;
  *((_DWORD *)this + 16) = a2;
  return result;
}

__int64 __fastcall Profile::set_msg(__int64 a1, __int64 a2)
{
  return std::string::operator=(a1, a2);
}

void __fastcall Profile::~Profile(Profile *this)
{
  std::string::~string((char *)this + 32);
  std::string::~string(this);
}

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

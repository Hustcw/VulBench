std::string *__stdcall replace(std::string *a1, std::string *a2, std::string *a3)
{
  int v4;
  int v5;
  char v6[4];
  char v7[7];
  char v8;
  int v9;
  char v10[4];
  int v11;
  int v12;
  char v13;
  int v14[2];
  char v15[4];
  int v16;
  char v17[4];
  int v18;
  char v19[4];
  char v20[8];

  while ( std::string::find(a2, a3, 0) != -1 )
  {
    std::allocator<char>::allocator(&v8);
    v9 = std::string::find(a2, a3, 0);
    std::string::begin((std::string *)v10);
    __gnu_cxx::__normal_iterator<char *,std::string>::operator+(&v11);
    std::string::begin((std::string *)&v12);
    std::string::string<__gnu_cxx::__normal_iterator<char *,std::string>>(v7, v12, v11, &v8);
    std::allocator<char>::~allocator(&v8, v4);
    std::allocator<char>::allocator(&v13);
    std::string::end((std::string *)v14);
    v14[1] = std::string::length(a3);
    v16 = std::string::find(a2, a3, 0);
    std::string::begin((std::string *)v17);
    __gnu_cxx::__normal_iterator<char *,std::string>::operator+(v15);
    __gnu_cxx::__normal_iterator<char *,std::string>::operator+(&v18);
    std::string::string<__gnu_cxx::__normal_iterator<char *,std::string>>(v6, v18, v14[0], &v13);
    std::allocator<char>::~allocator(&v13, v5);
    std::operator+<char>((std::string *)v20);
    std::operator+<char>((std::string *)v19);
    std::string::operator=(a2, v19, v6);
    std::string::~string(v19);
    std::string::~string(v20);
    std::string::~string(v6);
    std::string::~string(v7);
  }
  std::string::string(a1, a2);
  return a1;
}

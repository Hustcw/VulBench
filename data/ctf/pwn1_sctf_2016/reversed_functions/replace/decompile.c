std::string *__stdcall replace(std::string *a1, std::string *a2, std::string *a3, std::string *a4)
{
  int v5; 
  int v6; 
  char v7[4]; 
  char v8[7]; 
  char v9; 
  int v10; 
  int v11; 
  int v12; 
  int v13; 
  char v14; 
  int v15; 
  int v16; 
  int v17; 
  int v18; 
  int v19; 
  int v20; 
  char v21[4]; 
  char v22[8]; 

  while ( std::string::find(a2, a3, 0) != -1 )
  {
    std::allocator<char>::allocator(&v9);
    v10 = std::string::find(a2, a3, 0);
    std::string::begin((std::string *)&v11);
    __gnu_cxx::__normal_iterator<char *,std::string>::operator+(&v12, &v11, &v10);
    std::string::begin((std::string *)&v13);
    std::string::string<__gnu_cxx::__normal_iterator<char *,std::string>>((int)v8, v13, v12, (std::string *)&v9);
    std::allocator<char>::~allocator(&v9, v5);
    std::allocator<char>::allocator(&v14);
    std::string::end((std::string *)&v15);
    v16 = std::string::length(a3);
    v18 = std::string::find(a2, a3, 0);
    std::string::begin((std::string *)&v19);
    __gnu_cxx::__normal_iterator<char *,std::string>::operator+(&v17, &v19, &v18);
    __gnu_cxx::__normal_iterator<char *,std::string>::operator+(&v20, &v17, &v16);
    std::string::string<__gnu_cxx::__normal_iterator<char *,std::string>>((int)v7, v20, v15, (std::string *)&v14);
    std::allocator<char>::~allocator(&v14, v6);
    std::operator+<char>((std::string *)v22, (std::string *)v8, a4);
    std::operator+<char>((std::string *)v21, (std::string *)v22, (std::string *)v7);
    std::string::operator=(a2, v21);
    std::string::~string(v21);
    std::string::~string(v22);
    std::string::~string(v7);
    std::string::~string(v8);
  }
  std::string::string(a1, a2);
  return a1;
}
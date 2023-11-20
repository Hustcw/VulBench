#include <defs.h>
#include <defs.h>

int get_flag()
{
  return system("cat flag.txt");
}


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


int vuln()
{
  const char *v0; 
  int v2; 
  int v3; 
  char s[32]; 
  char v5[4]; 
  char v6[7]; 
  char v7; 
  char v8[7]; 
  char v9[5]; 

  printf("Tell me something about yourself: ");
  fgets(s, 32, edata);
  std::string::operator=(&input, s);
  std::allocator<char>::allocator(&v7);
  std::string::string(v6, "you", &v7);
  std::allocator<char>::allocator(v9);
  std::string::string(v8, "I", v9);
  replace((std::string *)v5, (std::string *)&input, (std::string *)v8, (std::string *)v6);
  std::string::operator=(&input, v5);
  std::string::~string(v5);
  std::string::~string(v8);
  std::allocator<char>::~allocator(v9, v2);
  std::string::~string(v6);
  std::allocator<char>::~allocator(&v7, v3);
  v0 = (const char *)std::string::c_str((std::string *)&input);
  strcpy(s, v0);
  return printf("So, %s\n", s);
}


int __cdecl main(int argc, const char **argv, const char **envp)
{
  vuln();
  return 0;
}

_DWORD *__userpurge __gnu_cxx::__normal_iterator<char *,std::string>::operator+@<eax>(
        _DWORD *a1,
        _DWORD *a2,
        _DWORD *a3)
{
  int v4[3]; 

  v4[0] = *a2 + *a3;
  __gnu_cxx::__normal_iterator<char *,std::string>::__normal_iterator(a1, v4);
  return a1;
}



int __cdecl std::string::string<__gnu_cxx::__normal_iterator<char *,std::string>>(
        int a1,
        int a2,
        int a3,
        std::string *a4)
{
  int v4; 

  v4 = std::string::_S_construct<__gnu_cxx::__normal_iterator<char *,std::string>>(a2, a3, a4);
  return std::string::_Alloc_hider::_Alloc_hider(a1, v4, a4);
}



std::string *__stdcall std::operator+<char>(std::string *a1, std::string *a2, std::string *a3)
{
  std::string::string(a1, a2);
  std::string::append(a1, a3);
  return a1;
}


_DWORD *__cdecl __gnu_cxx::__normal_iterator<char *,std::string>::__normal_iterator(_DWORD *a1, _DWORD *a2)
{
  _DWORD *result; 

  result = a1;
  *a1 = *a2;
  return result;
}


int __cdecl std::string::_S_construct<__gnu_cxx::__normal_iterator<char *,std::string>>(
        int a1,
        int a2,
        std::string *a3)
{
  return std::string::_S_construct_aux<__gnu_cxx::__normal_iterator<char *,std::string>>(a1, a2, a3);
}


int __cdecl std::string::_S_construct_aux<__gnu_cxx::__normal_iterator<char *,std::string>>(
        int a1,
        int a2,
        std::string *a3)
{
  return std::string::_S_construct<__gnu_cxx::__normal_iterator<char *,std::string>>(a1, a2, a3);
}


int __cdecl std::string::_S_construct<__gnu_cxx::__normal_iterator<char *,std::string>>(
        int a1,
        int a2,
        std::string *a3)
{
  char v3; 
  bool v4; 
  bool v5; 
  std::string::_Rep *v6; 
  int v9; 
  std::string *v10; 
  char v11; 
  std::string::_Rep *v12; 
  unsigned int v13; 

  v3 = 0;
  v4 = 0;
  if ( __gnu_cxx::operator==<char *,std::string>((int)&a1, (int)&a2) )
  {
    std::allocator<char>::allocator(&v11);
    v3 = 1;
    v10 = a3;
    if ( (unsigned __int8)std::operator==<char>() )
      v4 = 1;
  }
  v5 = v4;
  if ( v3 )
  {
    v10 = (std::string *)&v11;
    std::allocator<char>::~allocator();
  }
  if ( v5 )
  {
    v6 = (std::string::_Rep *)std::string::_S_empty_rep(v10);
    return std::string::_Rep::_M_refdata(v6);
  }
  else
  {
    if ( (unsigned __int8)__gnu_cxx::__is_null_pointer<__gnu_cxx::__normal_iterator<char *,std::string>>()
      && __gnu_cxx::operator!=<char *,std::string>((int)&a1, (int)&a2) )
    {
      std::__throw_logic_error("basic_string::_S_construct null not valid");
    }
    v13 = std::distance<__gnu_cxx::__normal_iterator<char *,std::string>>(a1, a2);
    v12 = (std::string::_Rep *)std::string::_Rep::_S_create(v13, 0, a3);
    v9 = std::string::_Rep::_M_refdata(v12);
    std::string::_S_copy_chars(v9, a1, a2);
    std::string::_Rep::_M_set_length_and_sharable(v12, v13);
    return std::string::_Rep::_M_refdata(v12);
  }
}

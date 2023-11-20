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
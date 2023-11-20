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
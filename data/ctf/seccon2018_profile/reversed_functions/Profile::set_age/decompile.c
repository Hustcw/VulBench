Profile *__fastcall Profile::set_age(Profile *this, int a2)
{
  Profile *result;

  result = this;
  *((_DWORD *)this + 16) = a2;
  return result;
}
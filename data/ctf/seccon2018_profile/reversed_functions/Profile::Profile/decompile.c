void __fastcall Profile::Profile(Profile *this, __int64 a2)
{
  std::string::basic_string(this, a2);
  std::string::basic_string((char *)this + 32, a2);
  std::string::operator=((char *)this + 32, &unk_401734);
  *((_DWORD *)this + 16) = 0;
  std::string::operator=(this, &unk_401734);
}
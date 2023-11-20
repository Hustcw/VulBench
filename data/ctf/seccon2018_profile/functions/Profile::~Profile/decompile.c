void __fastcall Profile::~Profile(Profile *this)
{
  std::string::~string((char *)this + 32);
  std::string::~string(this);
}

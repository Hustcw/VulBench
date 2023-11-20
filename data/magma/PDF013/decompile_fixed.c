void __fastcall FileSpec::FileSpec(FileSpec *this, const Object *fileSpecA)
{
  Object *p_fileSpec;
  const GooString *String;
  const Object *v4;
  const GooString *v5;
  Object v6;
  Object other;

  p_fileSpec = &this->fileSpec;
  Object::Object(&this->fileSpec);
  Object::Object(&this->fileStream);
  this->ok = 1;
  *(_OWORD *)&this->fileName = 0LL;
  *(_OWORD *)&this->embFile = 0LL;
  Object::copy(fileSpecA);
  Object::operator=(&this->fileSpec, &v6);
  Object::~Object(&v6);
  getFileSpecName(fileSpecA);
  if ( Object::isString(&v6) )
  {
    String = Object::getString(&v6);
    this->fileName = GooString::copy(String);
    if ( Object::isDict(p_fileSpec) )
    {
      Object::dictLookup(p_fileSpec, "EF", 0);
      Object::operator=(&v6, &other);
      Object::~Object(&other);
      if ( Object::isDict(&v6)
        && (v4 = Object::dictLookupNF(&v6, "F"),
            Object::copy(v4),
            Object::operator=(&this->fileStream, &other),
            Object::~Object(&other),
            !Object::isRef(&this->fileStream)) )
      {
        this->ok = 0;
        Object::setToNull(&this->fileStream);
        error(
          ErrorCategory::errSyntaxError,
          -1LL,
          "Invalid FileSpec: Embedded file stream is not an indirect reference");
      }
      else
      {
        Object::dictLookup(p_fileSpec, "Desc", 0);
        Object::operator=(&v6, &other);
        Object::~Object(&other);
        if ( Object::isString(&v6) )
        {
          v5 = Object::getString(&v6);
          this->desc = GooString::copy(v5);
        }
      }
    }
  }
  else
  {
    this->ok = 0;
    error(ErrorCategory::errSyntaxError, -1LL, "Invalid FileSpec");
  }
  Object::~Object(&v6);
}

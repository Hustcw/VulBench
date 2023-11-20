bool __fastcall XRef::parseEntry(XRef *this, Goffset offset, XRefEntry *entry)
{
  __int64 v4;
  Stream *v5;
  bool v6;
  bool isCmd;
  Goffset Int64;
  Object v10;
  Parser v11;

  if ( !entry )
    return 0;
  v4 = *(_QWORD *)this;
  Object::Object(&v10, ObjType::objNull);
  v5 = (Stream *)(*(__int64 (__fastcall **)(__int64, Goffset, _QWORD, __int64, Object *))(*(_QWORD *)v4 + 216LL))(
                   v4,
                   offset,
                   0LL,
                   20LL,
                   &v10);
  Parser::Parser((Parser *)&v11.lexer.tokBuf[39], 0LL, v5, 1);
  Object::~Object(&v10);
  Object::Object(&v10);
  Object::Object((Object *)&v11.lexer.tokBuf[7]);
  Object::Object((Object *)&v11.lexer.strPtr);
  Parser::getObj(&v11, (bool)&v11.lexer.tokBuf[39], 0LL, CryptAlgorithm::cryptRC4, 0, 0, 0, 0, 0, 0);
  Object::operator=(&v10, (Object *)&v11);
  if ( !Object::isInt(&v10) && !Object::isInt64(&v10) )
    goto LABEL_8;
  Parser::getObj(
    (Parser *)&v11.lexer.curStr.8,
    (bool)&v11.lexer.tokBuf[39],
    0LL,
    CryptAlgorithm::cryptRC4,
    0,
    0,
    0,
    0,
    0,
    0);
  Object::operator=((Object *)&v11.lexer.tokBuf[7], (Object *)&v11.lexer.curStr.8);
  if ( !Object::isInt((const Object *)&v11.lexer.tokBuf[7]) )
  {
    Object::~Object((Object *)&v11.lexer.curStr.8);
LABEL_8:
    Object::~Object((Object *)&v11);
    goto LABEL_9;
  }
  Parser::getObj(
    (Parser *)&v11.lexer.tokBuf[23],
    (bool)&v11.lexer.tokBuf[39],
    0LL,
    CryptAlgorithm::cryptRC4,
    0,
    0,
    0,
    0,
    0,
    0);
  Object::operator=((Object *)&v11.lexer.strPtr, (Object *)&v11.lexer.tokBuf[23]);
  if ( Object::isCmd((const Object *)&v11.lexer.strPtr, "n") )
  {
    Object::~Object((Object *)&v11.lexer.tokBuf[23]);
    Object::~Object((Object *)&v11.lexer.curStr.8);
    Object::~Object((Object *)&v11);
LABEL_11:
    if ( Object::isInt64(&v10) )
      Int64 = Object::getInt64(&v10);
    else
      Int64 = Object::getInt(&v10);
    entry->offset = Int64;
    entry->gen = Object::getInt((const Object *)&v11.lexer.tokBuf[7]);
    entry->type = Object::isCmd((const Object *)&v11.lexer.strPtr, "n");
    Object::setToNull((Object_0 *)&entry->obj);
    entry->flags = 0;
    v6 = 1;
    goto LABEL_15;
  }
  isCmd = Object::isCmd((const Object *)&v11.lexer.strPtr, "f");
  Object::~Object((Object *)&v11.lexer.tokBuf[23]);
  Object::~Object((Object *)&v11.lexer.curStr.8);
  Object::~Object((Object *)&v11);
  if ( isCmd )
    goto LABEL_11;
LABEL_9:
  v6 = 0;
LABEL_15:
  Object::~Object((Object *)&v11.lexer.strPtr);
  Object::~Object((Object *)&v11.lexer.tokBuf[7]);
  Object::~Object(&v10);
  Parser::~Parser((Parser *)&v11.lexer.tokBuf[39]);
  return v6;
}


XRefEntry *__fastcall XRef::getEntry(XRef *this, int i, bool complainIfMissing)
{
  __int64 v5;
  __int64 v6;
  __int64 v7;

  if ( *((_DWORD *)this + 7) > i )
  {
    v5 = *((_QWORD *)this + 2);
    v6 = i;
    if ( *(_DWORD *)(v5 + 40LL * i + 12) != 3 )
      return (XRefEntry *)(v5 + 40 * v6);
  }
  if ( *((_BYTE *)this + 200) || (v7 = *((_QWORD *)this + 24)) == 0 )
  {
    XRef::readXRefUntil(this, i, 0LL);
    if ( *((_DWORD *)this + 7) > i )
    {
      v6 = i;
      v5 = *((_QWORD *)this + 2);
      if ( *(_DWORD *)(v5 + 40LL * i + 12) == 3 )
      {
        if ( complainIfMissing )
        {
          error(ErrorCategory::errSyntaxError, -1LL, "Invalid XRef entry {0:d}", (unsigned int)i);
          v5 = *((_QWORD *)this + 2);
        }
        *(_DWORD *)(v5 + 40LL * i + 12) = 0;
      }
      return (XRefEntry *)(v5 + 40 * v6);
    }
  }
  else
  {
    v6 = i;
    if ( XRef::parseEntry(this, 20 * i + v7, (XRefEntry *)(*((_QWORD *)this + 2) + 40LL * i)) )
    {
      v5 = *((_QWORD *)this + 2);
      return (XRefEntry *)(v5 + 40 * v6);
    }
    error(ErrorCategory::errSyntaxError, -1LL, "Failed to parse XRef entry [{0:d}].", (unsigned int)i);
  }
  return &`anonymous namespace'::dummyXRefEntry;
}

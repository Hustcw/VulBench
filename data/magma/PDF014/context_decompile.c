class XRef {
    ...
	  XRefEntry *entries; // xref entries
    int capacity; // size of <entries> array
    int size; // number of entries
    ...
}

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
    Object::setToNull(&entry->obj);
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

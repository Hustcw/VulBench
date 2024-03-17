Stream *__fastcall Parser::makeStream(
        Parser *this,
        Object *dict,
        const unsigned __int8 *fileKey,
        CryptAlgorithm encAlgorithm,
        int keyLength,
        int objNum,
        int objGen,
        int recursion,
        bool strict)
{
  XRef *XRef;
  XRefEntry *v13;
  XRefEntry *v14;
  bool Flag;
  Goffset v16;
  Stream *v17;
  Stream *Stream;
  __int64 v19;
  __int64 Int;
  int v21;
  Goffset Pos;
  XRef *v23;
  Stream *v24;
  __int64 v25;
  const unsigned __int8 *v26;
  Goffset v27;
  Object *v28;
  Stream *v29;
  DecryptStream *v30;
  Dict *v31;
  XRef *v32;
  XRefEntry *Entry;
  __int64 v35;
  CryptAlgorithm algoA;
  int v37;
  Object v39;
  Goffset streamEnd;
  Object val;
  Ref v42;

  XRef = Lexer::getXRef(&this->lexer);
  if ( !XRef || (v13 = XRef::getEntry(XRef, objNum, 0)) == 0LL )
  {
LABEL_7:
    Lexer::skipToNextLine(&this->lexer);
    Stream = Lexer::getStream(&this->lexer);
    if ( !Stream )
      return 0LL;
    v19 = (*((__int64 (__fastcall **)(Stream *))Stream->_vptr$Stream + 13))(Stream);
    Object::dictLookup(dict, "Length", recursion);
    v37 = keyLength;
    algoA = encAlgorithm;
    if ( Object::isInt(&v39) )
    {
      Int = Object::getInt(&v39);
      v21 = objNum;
    }
    else if ( Object::isInt64(&v39) )
    {
      Int = Object::getInt64(&v39);
      v21 = objNum;
    }
    else
    {
      Pos = Parser::getPos(this);
      Int = 0LL;
      error(ErrorCategory::errSyntaxError, Pos, "Bad 'Length' attribute in stream");
      v17 = 0LL;
      v21 = objNum;
      if ( strict )
        goto LABEL_37;
    }
    if ( Lexer::hasXRef(&this->lexer) )
    {
      v23 = Lexer::getXRef(&this->lexer);
      if ( XRef::getStreamEnd(v23, v19, &streamEnd) )
        Int = streamEnd - v19;
    }
    if ( Lexer::getStream(&this->lexer) )
    {
      v24 = Lexer::getStream(&this->lexer);
      v25 = (*((__int64 (__fastcall **)(Stream *))v24->_vptr$Stream + 17))(v24);
      if ( this->lexer.lookCharLastValueCached != -3 )
      {
        --v19;
        this->lexer.lookCharLastValueCached = -3;
      }
      v17 = 0LL;
      if ( Int < 0 || v19 > 0x7FFFFFFFFFFFEC77LL - Int + 5000 )
        goto LABEL_37;
      v35 = v25;
      Lexer::setPos(&this->lexer, v19 + Int);
      Parser::shift(this, -1);
      Parser::shift(this, "endstream", v21);
      if ( Object::isCmd(&this->buf1, "endstream") )
      {
        Parser::shift(this, -1);
        v26 = fileKey;
LABEL_32:
        v28 = std::move<Object &>(dict);
        v29 = makeSubStream(
                          v35,
                          v19,
                          1LL,
                          Int,
                          v28);
        if ( v26 )
        {
          v30 = (DecryptStream *)operator new(0x178uLL);
          v42.gen = objGen;
          v42.num = objNum;
          DecryptStream::DecryptStream(v30, v29, v26, algoA, v37, v42);
          v29 = v30;
        }
        v31 = (Dict *)(*((__int64 (__fastcall **)(Stream *))v29->_vptr$Stream + 19))(v29);
        v17 = Stream::addFilters(v29, v31, recursion);
        v32 = Lexer::getXRef(&this->lexer);
        if ( v32 )
        {
          Entry = XRef::getEntry(v32, objNum, 0);
          if ( Entry )
            XRefEntry::setFlag(Entry, XRefEntry::Flag::Parsing, 0);
        }
        goto LABEL_37;
      }
      v27 = Parser::getPos(this);
      v17 = 0LL;
      error(ErrorCategory::errSyntaxError, v27, "Missing 'endstream' or incorrect stream length");
      if ( !strict )
      {
        v26 = fileKey;
        if ( Lexer::hasXRef(&this->lexer) && Lexer::getStream(&this->lexer) )
        {
          Int = Lexer::getPos(&this->lexer) - v19;
          if ( Object::isCmd(&this->buf1, "endstream") )
          {
            Object::Object(&val, Int);
            Object::dictSet(dict, "Length", &val);
            Object::~Object(&val);
          }
        }
        else if ( Int < 0x7FFFFFFFFFFFEC77LL - v19 )
        {
          Int += 5000LL;
        }
        goto LABEL_32;
      }
    }
    else
    {
      v17 = 0LL;
    }
LABEL_37:
    Object::~Object(&v39);
    return v17;
  }
  v14 = v13;
  Flag = XRefEntry::getFlag(v13, XRefEntry::Flag::Parsing);
  if ( !(objNum | objGen) || !Flag )
  {
    XRefEntry::setFlag(v14, XRefEntry::Flag::Parsing, 1);
    goto LABEL_7;
  }
  v16 = Parser::getPos(this);
  v17 = 0LL;
  error(
    ErrorCategory::errSyntaxError,
    v16,
    "Object '{0:d} {1:d} obj' is being already parsed",
    (unsigned int)objNum,
    (unsigned int)objGen);
  return v17;
}

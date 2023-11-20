Stream *__fastcall Parser::makeStream(
        Parser *this,
        Object *dict,
        unsigned __int8 *fileKey,
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
  __int64 Int;
  Stream *Stream;
  __int64 v19;
  Goffset Pos;
  XRef *v21;
  Stream *v22;
  __int64 v23;
  Goffset v24;
  Object *v25;
  Stream *v26;
  unsigned __int8 *v27;
  DecryptStream *v28;
  Dict *v29;
  XRef *v30;
  XRefEntry *Entry;
  CryptAlgorithm algoA;
  int v34;
  Object v35;
  unsigned __int8 *v36;
  Goffset streamEnd;
  Object val;
  Ref v39;

  v36 = fileKey;
  XRef = Lexer::getXRef(&this->lexer);
  if ( !XRef || (v13 = XRef::getEntry(XRef, objNum, 0)) == 0LL )
  {
LABEL_7:
    Lexer::skipToNextLine(&this->lexer);
    Stream = Lexer::getStream(&this->lexer);
    if ( !Stream )
      return 0LL;
    algoA = encAlgorithm;
    v19 = (*((__int64 (__fastcall **)(Stream *))Stream->_vptr$Stream + 13))(Stream);
    Object::dictLookup(dict, "Length", recursion);
    v34 = keyLength;
    if ( Object::isInt(&v35) )
    {
      Int = Object::getInt(&v35);
    }
    else if ( Object::isInt64(&v35) )
    {
      Int = Object::getInt64(&v35);
    }
    else
    {
      Pos = Parser::getPos(this);
      Int = 0LL;
      error(ErrorCategory::errSyntaxError, Pos, "Bad 'Length' attribute in stream");
      if ( strict )
        goto LABEL_35;
    }
    if ( Lexer::hasXRef(&this->lexer) )
    {
      v21 = Lexer::getXRef(&this->lexer);
      if ( XRef::getStreamEnd(v21, v19, &streamEnd) )
        Int = streamEnd - v19;
    }
    if ( Lexer::getStream(&this->lexer) )
    {
      v22 = Lexer::getStream(&this->lexer);
      v23 = (*((__int64 (__fastcall **)(Stream *))v22->_vptr$Stream + 17))(v22);
      if ( this->lexer.lookCharLastValueCached != -3 )
      {
        --v19;
        this->lexer.lookCharLastValueCached = -3;
      }
      if ( Int >= 0 )
      {
        Lexer::setPos(&this->lexer, Int + v19);
        Parser::shift(this, -1);
        Parser::shift(this, "endstream", objNum);
        if ( Object::isCmd(&this->buf1, "endstream") )
        {
          Parser::shift(this, -1);
LABEL_30:
          v25 = std::move<Object &>(dict);
          v26 = (Stream *)(*(__int64 (__fastcall **)(__int64, __int64, __int64, __int64, Object *))(*(_QWORD *)v23
                                                                                                  + 216LL))(
                            v23,
                            v19,
                            1LL,
                            Int,
                            v25);
          v27 = v36;
          if ( v36 )
          {
            v28 = (DecryptStream *)operator new(0x178uLL);
            v39.gen = objGen;
            v39.num = objNum;
            DecryptStream::DecryptStream(v28, v26, v27, algoA, v34, v39);
            v26 = v28;
          }
          v29 = (Dict *)(*((__int64 (__fastcall **)(Stream *))v26->_vptr$Stream + 19))(v26);
          Int = (__int64)Stream::addFilters(v26, v29, recursion);
          v30 = Lexer::getXRef(&this->lexer);
          if ( v30 )
          {
            Entry = XRef::getEntry(v30, objNum, 0);
            if ( Entry )
              XRefEntry::setFlag(Entry, XRefEntry::Flag::Parsing, 0);
          }
          goto LABEL_35;
        }
        v24 = Parser::getPos(this);
        error(ErrorCategory::errSyntaxError, v24, "Missing 'endstream' or incorrect stream length");
        if ( !strict )
        {
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
          else
          {
            Int += 5000LL;
          }
          goto LABEL_30;
        }
      }
    }
    Int = 0LL;
LABEL_35:
    Object::~Object(&v35);
    return (Stream *)Int;
  }
  v14 = v13;
  Flag = XRefEntry::getFlag(v13, XRefEntry::Flag::Parsing);
  if ( !(objNum | objGen) || !Flag )
  {
    XRefEntry::setFlag(v14, XRefEntry::Flag::Parsing, 1);
    goto LABEL_7;
  }
  v16 = Parser::getPos(this);
  Int = 0LL;
  error(
    ErrorCategory::errSyntaxError,
    v16,
    "Object '{0:d} {1:d} obj' is being already parsed",
    (unsigned int)objNum,
    (unsigned int)objGen);
  return (Stream *)Int;
}

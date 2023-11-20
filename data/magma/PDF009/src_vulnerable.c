Stream *Parser::makeStream(Object &&dict, const unsigned char *fileKey,
                           CryptAlgorithm encAlgorithm, int keyLength,
                           int objNum, int objGen, int recursion, bool strict) {
  BaseStream *baseStr;
  Stream *str;
  Goffset length;
  Goffset pos, endPos;

  if (XRef *xref = lexer.getXRef()) {
    XRefEntry *entry = xref->getEntry(objNum, false);
    if (entry) {
      if (!entry->getFlag(XRefEntry::Parsing) || (objNum == 0 && objGen == 0)) {
        entry->setFlag(XRefEntry::Parsing, true);
      } else {
        error(errSyntaxError, getPos(),
              "Object '{0:d} {1:d} obj' is being already parsed", objNum,
              objGen);
        return nullptr;
      }
    }
  }

  // get stream start position
  lexer.skipToNextLine();
  if (!(str = lexer.getStream())) {
    return nullptr;
  }
  pos = str->getPos();

  // get length
  Object obj = dict.dictLookup("Length", recursion);
  if (obj.isInt()) {
    length = obj.getInt();
  } else if (obj.isInt64()) {
    length = obj.getInt64();
  } else {
    error(errSyntaxError, getPos(), "Bad 'Length' attribute in stream");
    if (strict)
      return nullptr;
    length = 0;
  }

  // check for length in damaged file
  if (lexer.hasXRef() && lexer.getXRef()->getStreamEnd(pos, &endPos)) {
    length = endPos - pos;
  }

  // in badly damaged PDF files, we can run off the end of the input
  // stream immediately after the "stream" token
  if (!lexer.getStream()) {
    return nullptr;
  }
  baseStr = lexer.getStream()->getBaseStream();

  // skip over stream data
  if (Lexer::LOOK_VALUE_NOT_CACHED != lexer.lookCharLastValueCached) {
    // take into account the fact that we've cached one value
    pos = pos - 1;
    lexer.lookCharLastValueCached = Lexer::LOOK_VALUE_NOT_CACHED;
  }
  if (unlikely(length < 0)) {
    return nullptr;
  }
  if (unlikely(pos > LLONG_MAX - length)) {
    return nullptr;
  }
  lexer.setPos(pos + length);

  // refill token buffers and check for 'endstream'
  shift();                    // kill '>>'
  shift("endstream", objNum); // kill 'stream'
  if (buf1.isCmd("endstream")) {
    shift();
  } else {
    error(errSyntaxError, getPos(),
          "Missing 'endstream' or incorrect stream length");
    if (strict)
      return nullptr;
    if (lexer.hasXRef() && lexer.getStream()) {
      // shift until we find the proper endstream or we change to another object
      // or reach eof
      length = lexer.getPos() - pos;
      if (buf1.isCmd("endstream")) {
        dict.dictSet("Length", Object(length));
      }
    } else {
      // When building the xref we can't use it so use this
      // kludge for broken PDF files: just add 5k to the length, and
      // hope its enough
      length += 5000;
    }
  }

  // make base stream
  str = baseStr->makeSubStream(pos, true, length, std::move(dict));

  // handle decryption
  if (fileKey) {
    str = new DecryptStream(str, fileKey, encAlgorithm, keyLength,
                            {objNum, objGen});
  }

  // get filters
  str = str->addFilters(str->getDict(), recursion);

  if (XRef *xref = lexer.getXRef()) {
    // Don't try to reuse the entry from the block at the start
    // of the function, xref can change in the middle because of
    // reconstruction
    XRefEntry *entry = xref->getEntry(objNum, false);
    if (entry) {
      entry->setFlag(XRefEntry::Parsing, false);
    }
  }

  return str;
}


void __fastcall FoFiTrueType::dumpString(
        const FoFiTrueType *this,
        const unsigned __int8 *s,
        int length,
        FoFiOutputFunc outputFunc,
        void *outputStream)
{
  __int64 v6;
  __int64 v7;
  __int64 i;
  GooString *v9;
  const char *v10;
  int v11;
  int v12;
  FoFiOutputFunc v13;
  int v14;
  void (*v15)(void *, const char *, int);
  int v16;

  outputFunc(outputStream, "<", 1);
  if ( length > 0 )
  {
    v6 = length;
    v7 = 0LL;
    v16 = length;
    while ( 1 )
    {
      while ( 1 )
      {
        for ( i = 0LL; i != 32; ++i )
        {
          if ( v7 + i >= v6 )
            break;
          v9 = GooString::format("{0:02x}", s[v7 + i]);
          v10 = std::string::c_str(v9);
          v11 = GooString::getLength(v9);
          outputFunc(outputStream, v10, v11);
          if ( v9 )
          {
            std::string::~string(v9);
            operator delete(v9);
          }
        }
        if ( (unsigned int)v7 % 0xFFE0 != 65472 )
          break;
        outputFunc(outputStream, ">\n<", 3);
        v7 += 32LL;
        length = v16;
LABEL_4:
        if ( (int)v7 >= length )
          goto LABEL_13;
      }
      v7 += 32LL;
      length = v16;
      if ( (int)v7 >= v16 )
        goto LABEL_4;
      outputFunc(outputStream, "\n", 1);
    }
  }
LABEL_13:
  v12 = length & 3;
  v13 = outputFunc;
  if ( v12 )
  {
    v14 = v12 - 4;
    do
    {
      v15 = v13;
      v13(outputStream, "00", 2);
      v13 = v15;
      ++v14;
    }
    while ( v14 );
  }
  v13(outputStream, "00>\n", 4);
}

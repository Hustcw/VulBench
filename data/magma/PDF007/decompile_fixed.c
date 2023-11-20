unsigned __int8 *__fastcall ImageStream::getLine(ImageStream_0 *this)
{
  unsigned __int8 *inputLine;
  unsigned __int8 *v2;
  int Chars;
  __int64 v5;
  int nBits;
  unsigned __int8 *v7;
  __int64 v8;
  unsigned __int8 v9;
  unsigned __int8 *v10;
  __int64 v11;
  char v12;
  unsigned __int8 *v13;
  __int64 v14;
  int v15;
  unsigned __int64 v16;
  unsigned int v17;
  int v18;
  __int64 v19;
  __int64 v20;
  __int64 v21;

  inputLine = this->inputLine;
  v2 = 0LL;
  if ( inputLine )
  {
    Chars = Stream::doGetChars(this->str, this->inputLineSize, inputLine);
    if ( Chars != -1 )
      LODWORD(v2) = Chars;
    if ( (int)v2 < this->inputLineSize )
    {
      v5 = (int)v2;
      do
        this->inputLine[v5++] = -1;
      while ( v5 < this->inputLineSize );
    }
    nBits = this->nBits;
    if ( nBits == 16 )
    {
      if ( this->nVals > 0 )
      {
        v10 = this->inputLine;
        v11 = 0LL;
        do
        {
          this->imgLine[v11] = v10[2 * v11];
          ++v11;
        }
        while ( v11 < this->nVals );
      }
    }
    else if ( nBits != 8 )
    {
      if ( nBits == 1 )
      {
        if ( this->nVals > 0 )
        {
          v7 = this->inputLine;
          v8 = 0LL;
          do
          {
            v9 = *v7++;
            this->imgLine[v8] = v9 >> 7;
            this->imgLine[v8 + 1] = (v9 & 0x40) != 0;
            this->imgLine[v8 + 2] = (v9 & 0x20) != 0;
            this->imgLine[v8 + 3] = (v9 & 0x10) != 0;
            this->imgLine[v8 + 4] = (v9 & 8) != 0;
            this->imgLine[v8 + 5] = (v9 & 4) != 0;
            this->imgLine[v8 + 6] = (v9 & 2) != 0;
            this->imgLine[v8 + 7] = v9 & 1;
            v8 += 8LL;
          }
          while ( v8 < this->nVals );
        }
      }
      else if ( this->nVals > 0 )
      {
        v12 = ~(unsigned __int8)(-1 << nBits);
        v13 = this->inputLine;
        v14 = 0LL;
        v15 = 0;
        v16 = 0LL;
        if ( nBits > 0 )
          goto LABEL_22;
        while ( 1 )
        {
          this->imgLine[v14] = v12 & (v16 >> ((unsigned __int8)v15 - (unsigned __int8)nBits));
          nBits = this->nBits;
          v15 -= nBits;
          if ( ++v14 >= this->nVals )
            break;
          if ( v15 < nBits )
          {
LABEL_22:
            v17 = nBits + ~v15;
            if ( (((unsigned __int8)(v17 >> 3) + 1) & 3) != 0 )
            {
              v18 = -(((unsigned __int8)((unsigned int)(nBits + ~v15) >> 3) + 1) & 3);
              do
              {
                v19 = *v13++;
                v16 = v19 | (v16 << 8);
                v15 += 8;
                ++v18;
              }
              while ( v18 );
            }
            if ( v17 >= 0x18 )
            {
              do
              {
                v20 = ((((((v16 << 8) | *v13) << 8) | v13[1]) << 8) | v13[2]) << 8;
                v21 = v13[3];
                v13 += 4;
                v16 = v20 | v21;
                v15 += 32;
              }
              while ( v15 < nBits );
            }
          }
        }
      }
    }
    return this->imgLine;
  }
  return v2;
}


int __fastcall EmbedStream::getChars(EmbedStream *this, int nChars, unsigned __int8 *buffer)
{
  __int64 bufLen;
  __int64 bufPos;
  int Chars;
  int v8;
  Goffset length;
  __int64 bufMax;
  __int64 v11;
  __int64 v12;
  unsigned __int8 *bufData;

  if ( nChars <= 0 )
    return 0;
  if ( this->replay )
  {
    bufLen = this->bufLen;
    bufPos = this->bufPos;
    Chars = -1;
    if ( bufLen > bufPos )
    {
      v8 = bufLen - bufPos;
      if ( v8 <= nChars )
        nChars = v8;
      memcpy(buffer, this->bufData, nChars);
      return v8;
    }
  }
  else
  {
    if ( this->limited )
    {
      length = this->length;
      if ( length >= nChars )
        LODWORD(length) = nChars;
      nChars = length;
    }
    Chars = Stream::doGetChars(this->str, nChars, buffer);
    if ( this->record )
    {
      bufMax = this->bufMax;
      v11 = this->bufLen;
      v12 = v11 + Chars;
      if ( v12 >= bufMax )
      {
        do
          bufMax *= 2LL;
        while ( v12 >= bufMax );
        this->bufMax = bufMax;
        bufData = (unsigned __int8 *)grealloc(this->bufData, bufMax, 0);
        this->bufData = bufData;
        v11 = this->bufLen;
      }
      else
      {
        bufData = this->bufData;
      }
      memcpy(&bufData[v11], buffer, Chars);
      this->bufLen += Chars;
    }
  }
  return Chars;
}

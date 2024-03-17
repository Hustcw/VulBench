class POPPLER_PRIVATE_EXPORT Stream {
		...
    inline int doGetChars(int nChars, unsigned char *buffer)
    {
        if (hasGetChars()) {
            return getChars(nChars, buffer);
        } else {
            for (int i = 0; i < nChars; ++i) {
                const int c = getChar();
                if (likely(c != EOF))
                    buffer[i] = c;
                else
                    return i;
            }
            return nChars;
        }
    }
		...
}

class BaseStreamStream : public Stream
{
		...
    std::unique_ptr<Stream> str;
		...
};

class POPPLER_PRIVATE_EXPORT BaseStream : public Stream {
		...
}

class POPPLER_PRIVATE_EXPORT EmbedStream : public BaseStream {
		...
		bool hasGetChars() override { return true; }
    int getChars(int nChars, unsigned char *buffer) override;
		...
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

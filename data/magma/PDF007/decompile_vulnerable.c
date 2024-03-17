unsigned __int8 *__fastcall ImageStream::getLine(ImageStream_0 *this)
{
  unsigned __int8 *inputLine;
  __int64 v3;
  int nBits;
  unsigned __int8 *v5;
  __int64 v6;
  unsigned __int8 v7;
  unsigned __int8 *v8;
  __int64 v9;
  char v10;
  unsigned __int8 *v11;
  __int64 v12;
  int v13;
  unsigned __int64 v14;
  unsigned int v15;
  int v16;
  __int64 v17;
  __int64 v18;
  __int64 v19;

  inputLine = this->inputLine;
  if ( !inputLine )
    return 0LL;
  LODWORD(v3) = Stream::doGetChars(this->str, this->inputLineSize, inputLine);
  if ( (int)v3 < this->inputLineSize )
  {
    v3 = (int)v3;
    do
      this->inputLine[v3++] = -1;
    while ( v3 < this->inputLineSize );
  }
  nBits = this->nBits;
  if ( nBits == 16 )
  {
    if ( this->nVals > 0 )
    {
      v8 = this->inputLine;
      v9 = 0LL;
      do
      {
        this->imgLine[v9] = v8[2 * v9];
        ++v9;
      }
      while ( v9 < this->nVals );
    }
  }
  else if ( nBits != 8 )
  {
    if ( nBits == 1 )
    {
      if ( this->nVals > 0 )
      {
        v5 = this->inputLine;
        v6 = 0LL;
        do
        {
          v7 = *v5++;
          this->imgLine[v6] = v7 >> 7;
          this->imgLine[v6 + 1] = (v7 & 0x40) != 0;
          this->imgLine[v6 + 2] = (v7 & 0x20) != 0;
          this->imgLine[v6 + 3] = (v7 & 0x10) != 0;
          this->imgLine[v6 + 4] = (v7 & 8) != 0;
          this->imgLine[v6 + 5] = (v7 & 4) != 0;
          this->imgLine[v6 + 6] = (v7 & 2) != 0;
          this->imgLine[v6 + 7] = v7 & 1;
          v6 += 8LL;
        }
        while ( v6 < this->nVals );
      }
    }
    else if ( this->nVals > 0 )
    {
      v10 = ~(unsigned __int8)(-1 << nBits);
      v11 = this->inputLine;
      v12 = 0LL;
      v13 = 0;
      v14 = 0LL;
      if ( nBits > 0 )
        goto LABEL_20;
      while ( 1 )
      {
        this->imgLine[v12] = v10 & (v14 >> ((unsigned __int8)v13 - (unsigned __int8)nBits));
        nBits = this->nBits;
        v13 -= nBits;
        if ( ++v12 >= this->nVals )
          break;
        if ( v13 < nBits )
        {
LABEL_20:
          v15 = nBits + ~v13;
          if ( (((unsigned __int8)(v15 >> 3) + 1) & 3) != 0 )
          {
            v16 = -(((unsigned __int8)((unsigned int)(nBits + ~v13) >> 3) + 1) & 3);
            do
            {
              v17 = *v11++;
              v14 = v17 | (v14 << 8);
              v13 += 8;
              ++v16;
            }
            while ( v16 );
          }
          if ( v15 >= 0x18 )
          {
            do
            {
              v18 = ((((((v14 << 8) | *v11) << 8) | v11[1]) << 8) | v11[2]) << 8;
              v19 = v11[3];
              v11 += 4;
              v14 = v18 | v19;
              v13 += 32;
            }
            while ( v13 < nBits );
          }
        }
      }
    }
  }
  return this->imgLine;
}

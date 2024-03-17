unsigned __int8 *__fastcall Stream::toUnsignedChars(Stream *this, int *length, int initialSize, int sizeIncrement)
{
  int v5;
  unsigned __int8 *v7;
  int Chars;
  int v9;

  v5 = initialSize;
  v7 = (unsigned __int8 *)gmalloc(initialSize, 0);
  *length = 0;
  (*((void (__fastcall **)(Stream *))this->_vptr$Stream + 3))(this);
  Chars = Stream::doGetChars(this, initialSize, &v7[*length]);
  if ( Chars )
  {
    v9 = sizeIncrement + v5;
    do
    {
      *length += Chars;
      if ( Chars != v5 )
        break;
      if ( (*((unsigned int (__fastcall **)(Stream *))this->_vptr$Stream + 6))(this) == -1 )
        break;
      v7 = (unsigned __int8 *)grealloc(v7, v9, 0);
      Chars = Stream::doGetChars(this, sizeIncrement, &v7[*length]);
      v9 += sizeIncrement;
      v5 = sizeIncrement;
    }
    while ( Chars );
  }
  return v7;
}
void __fastcall ImageStream::ImageStream(ImageStream_0 *this, Stream *strA, int widthA, int nCompsA, int nBitsA)
{
  int v6;
  unsigned __int8 *v7;
  int nBits;
  unsigned int nVals;
  int v10;

  this->str = strA;
  this->width = widthA;
  this->nComps = nCompsA;
  this->nBits = nBitsA;
  this->nVals = widthA * nCompsA;
  v6 = (nBitsA * widthA * nCompsA + 7) >> 3;
  this->inputLineSize = v6;
  if ( nBitsA <= 0 || widthA * nCompsA > (int)(0x7FFFFFFFu / nBitsA - 7) || 0x7FFFFFFF / nCompsA < widthA )
  {
    this->inputLineSize = -1;
    v6 = -1;
  }
  v7 = (unsigned __int8 *)gmallocn_checkoverflow(v6, 1);
  this->inputLine = v7;
  nBits = this->nBits;
  if ( nBits != 8 )
  {
    nVals = (this->nVals + 7) & 0xFFFFFFF8;
    if ( nBits != 1 )
      nVals = this->nVals;
    v10 = -1;
    if ( this->width <= 0x7FFFFFFF / this->nComps )
      v10 = nVals;
    v7 = (unsigned __int8 *)gmallocn_checkoverflow(v10, 1);
  }
  this->imgLine = v7;
  this->imgIdx = this->nVals;
}

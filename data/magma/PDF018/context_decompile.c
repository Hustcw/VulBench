void __fastcall AnnotInk::parseInkList(AnnotInk *this, Array *array)
{
  int Length;
  AnnotPath **v3;
  __int64 v4;
  AnnotPath *v5;
  Array *v6;
  Object v7[3];

  Length = Array::getLength(array);
  this->inkListLength = Length;
  v3 = (AnnotPath **)gmallocn(Length, 8, 0);
  this->inkList = v3;
  memset(v3, 0, 8LL * this->inkListLength);
  if ( this->inkListLength > 0 )
  {
    v4 = 0LL;
    do
    {
      Array::get(array, v4, 0);
      if ( Object::isArray(v7) )
      {
        v5 = (AnnotPath *)operator new(0x18uLL);
        v6 = Object::getArray(v7);
        AnnotPath::AnnotPath(v5, v6);
        this->inkList[v4] = v5;
      }
      Object::~Object(v7);
      ++v4;
    }
    while ( v4 < this->inkListLength );
  }
}
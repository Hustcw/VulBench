Stream *__fastcall BaseMemStream<char>::makeSubStream(
        BaseMemStream<char> *this,
        Goffset startA,
        bool limited,
        Goffset lengthA,
        Object *dictA)
{
  Goffset v6; // r12
  Goffset v7; // rdx
  Goffset length; // rax
  Goffset start; // rcx
  BaseMemStream<char> *v10; // rbx
  char *buf; // r13
  Object *v12; // rax

  if ( limited )
  {
    v6 = lengthA;
    v7 = lengthA + startA;
    length = this->length;
    start = this->start;
    if ( v7 <= length + start )
      goto LABEL_6;
  }
  else
  {
    length = this->length;
    start = this->start;
  }
  v6 = length + start - startA;
LABEL_6:
  v10 = (BaseMemStream<char> *)operator new(0x48uLL);
  buf = this->buf;
  v12 = std::move<Object &>(dictA);
  BaseMemStream<char>::BaseMemStream(v10, buf, startA, v6, v12);
  return v10;
}
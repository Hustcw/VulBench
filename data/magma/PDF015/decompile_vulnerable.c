bool __fastcall EmbFile::save2(EmbFile *this, FILE *f)
{
  int Char;

  Object::streamReset(&this->m_objStr);
  while ( 1 )
  {
    Char = Object::streamGetChar(&this->m_objStr);
    if ( Char == -1 )
      break;
    fputc(Char, f);
  }
  return 1;
}

bool __fastcall EmbFile::save2(EmbFile *this, FILE *f)
{
  Object *p_m_objStr;
  int Char;
  bool i;

  p_m_objStr = &this->m_objStr;
  if ( !Object::isStream(&this->m_objStr) )
    return 0;
  Object::streamReset(p_m_objStr);
  Char = Object::streamGetChar(p_m_objStr);
  for ( i = 1; Char != -1; Char = Object::streamGetChar(p_m_objStr) )
    fputc(Char, f);
  return i;
}

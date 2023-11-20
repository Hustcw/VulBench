bool EmbFile::save2(FILE *f) {
  int c;

  if (unlikely(!m_objStr.isStream()))
    return false;
  m_objStr.streamReset();
  while ((c = m_objStr.streamGetChar()) != EOF) {
    fputc(c, f);
  }
  return true;
}

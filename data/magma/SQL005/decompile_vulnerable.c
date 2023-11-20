const unsigned __int8 *__fastcall sqlite3_value_text(sqlite3_value *pVal)
{
  return (const unsigned __int8 *)sqlite3ValueText(pVal, 1u);
}


const void *__fastcall sqlite3ValueText(sqlite3_value *pVal, u8 enc)
{
  sqlite3 *db;
  u16 flags;

  if ( !pVal )
    return 0LL;
  db = pVal->db;
  if ( db && !sqlite3_mutex_held(db->mutex) )
    __assert_fail(
      "pVal->db==0 || sqlite3_mutex_held(pVal->db->mutex)",
      "sqlite3.c",
      0x1325Eu,
      "const void *sqlite3ValueText(sqlite3_value *, u8)");
  if ( (enc & 0xF4) != 0 )
    __assert_fail(
      "(enc&3)==(enc&~SQLITE_UTF16_ALIGNED)",
      "sqlite3.c",
      0x1325Fu,
      "const void *sqlite3ValueText(sqlite3_value *, u8)");
  if ( sqlite3VdbeMemIsRowSet(pVal) )
    __assert_fail(
      "!sqlite3VdbeMemIsRowSet(pVal)",
      "sqlite3.c",
      0x13260u,
      "const void *sqlite3ValueText(sqlite3_value *, u8)");
  flags = pVal->flags;
  if ( (flags & 0x202) != 514 || pVal->enc != enc )
  {
    if ( (flags & 1) == 0 )
      return valueToText(pVal, enc);
    return 0LL;
  }
  if ( !sqlite3VdbeMemValidStrRep(pVal) )
    __assert_fail(
      "sqlite3VdbeMemValidStrRep(pVal)",
      "sqlite3.c",
      0x13262u,
      "const void *sqlite3ValueText(sqlite3_value *, u8)");
  return pVal->z;
}

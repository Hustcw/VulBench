int __fastcall xmlStrlen(const xmlChar *str)
{
  __int64 v1;

  LODWORD(v1) = 0;
  if ( str && *str )
  {
    v1 = 0LL;
    while ( str[++v1] != 0 )
      ;
  }
  return v1;
}

xmlChar *__fastcall xmlStrncat(xmlChar *cur, const xmlChar *add, int len)
{
  xmlChar *v3;
  int v5;
  int v6;
  xmlChar *v7;
  xmlChar *v8;

  v3 = cur;
  if ( !add || !len )
    return v3;
  if ( len < 0 )
    return 0LL;
  if ( cur )
  {
    v5 = xmlStrlen(cur);
    if ( v5 >= 0 )
    {
      v6 = v5;
      v7 = (xmlChar *)xmlRealloc(cur, v5 + len + 1);
      if ( v7 )
      {
        v8 = v7;
        memcpy(&v7[v6], add, len);
        v8[len + v6] = 0;
        return v8;
      }
      else
      {
        xmlErrMemory(0LL, 0LL);
      }
      return v3;
    }
    return 0LL;
  }
  return xmlStrndup(add, len);
}

xmlChar *__fastcall xmlStrncat(xmlChar *cur, const xmlChar *add, int len)
{
  xmlChar *v3;
  int v5;
  xmlChar *v6;
  xmlChar *v7;

  v3 = cur;
  if ( add && len )
  {
    if ( len < 0 )
    {
      return 0LL;
    }
    else
    {
      if ( !cur )
        return xmlStrndup(add, len);
      v5 = xmlStrlen(cur);
      v6 = (xmlChar *)xmlRealloc(cur, v5 + len + 1);
      if ( v6 )
      {
        v7 = v6;
        memcpy(&v6[v5], add, len);
        v7[len + v5] = 0;
        return v7;
      }
      else
      {
        xmlErrMemory(0LL, 0LL);
      }
    }
  }
  return v3;
}

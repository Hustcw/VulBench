xmlChar *__fastcall xmlStrncatNew(const xmlChar *str1, const xmlChar *str2, int len)
{
  int v3;
  int v4;
  int v5;
  xmlChar *v6;
  xmlChar *v7;

  v3 = len;
  if ( len < 0 )
  {
    v3 = xmlStrlen(str2);
    if ( v3 < 0 )
      return 0LL;
  }
  if ( !str2 || !v3 )
    return xmlStrdup(str1);
  if ( !str1 )
    return xmlStrndup(str2, v3);
  v4 = xmlStrlen(str1);
  if ( v4 < 0 )
    return 0LL;
  v5 = v4;
  v6 = (xmlChar *)xmlMalloc(v4 + v3 + 1);
  if ( v6 )
  {
    v7 = v6;
    memcpy(v6, str1, v5);
    memcpy(&v7[v5], str2, v3);
    v7[v3 + v5] = 0;
    return v7;
  }
  xmlErrMemory(0LL, 0LL);
  return xmlStrndup(str1, v5);
}


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

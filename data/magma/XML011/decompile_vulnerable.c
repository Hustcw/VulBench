xmlChar *__fastcall xmlStrncatNew(const xmlChar *str1, const xmlChar *str2, int len)
{
  int v3;
  int v4;
  xmlChar *v5;
  xmlChar *v6;

  v3 = len;
  if ( len < 0 )
  {
    v3 = xmlStrlen(str2);
    if ( !str2 )
      return xmlStrdup(str1);
  }
  else if ( !str2 )
  {
    return xmlStrdup(str1);
  }
  if ( !v3 )
    return xmlStrdup(str1);
  if ( !str1 )
    return xmlStrndup(str2, v3);
  v4 = xmlStrlen(str1);
  v5 = (xmlChar *)xmlMalloc(v4 + v3 + 1);
  if ( v5 )
  {
    v6 = v5;
    memcpy(v5, str1, v4);
    memcpy(&v6[v4], str2, v3);
    v6[v3 + v4] = 0;
    return v6;
  }
  else
  {
    xmlErrMemory(0LL, 0LL);
    return xmlStrndup(str1, v4);
  }
}


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

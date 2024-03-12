

xmlChar *xmlStrncatNew(const xmlChar *str1, const xmlChar *str2, int len) {
  int size;
  xmlChar *ret;

  if (len < 0) {
    len = xmlStrlen(str2);
  }
  if ((str2 == NULL) || (len == 0))
    return (xmlStrdup(str1));
  if (str1 == NULL)
    return (xmlStrndup(str2, len));

  size = xmlStrlen(str1);
  ret = (xmlChar *)xmlMalloc((size + len + 1) * sizeof(xmlChar));
  if (ret == NULL) {
    xmlErrMemory(NULL, NULL);
    return (xmlStrndup(str1, size));
  }
  memcpy(ret, str1, size * sizeof(xmlChar));
  memcpy(&ret[size], str2, len * sizeof(xmlChar));
  ret[size + len] = 0;
  return (ret);
}
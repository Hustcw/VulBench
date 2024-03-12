xmlChar *xmlStrncat(xmlChar *cur, const xmlChar *add, int len) {
  int size;
  xmlChar *ret;

  if ((add == NULL) || (len == 0))
    return (cur);
  if (len < 0)
    return (NULL);
  if (cur == NULL)
    return (xmlStrndup(add, len));

  size = xmlStrlen(cur);
  ret = (xmlChar *)xmlRealloc(cur, (size + len + 1) * sizeof(xmlChar));
  if (ret == NULL) {
    xmlErrMemory(NULL, NULL);
    return (cur);
  }
  memcpy(&ret[size], add, len * sizeof(xmlChar));
  ret[size + len] = 0;
  return (ret);
}
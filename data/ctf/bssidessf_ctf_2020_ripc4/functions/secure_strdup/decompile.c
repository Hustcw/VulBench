char *__cdecl secure_strdup(const char *s)
{
  char *buf;
  size_t len;

  len = strlen(s) + 1;
  buf = (char *)secure_malloc(len);
  memcpy(buf, s, len + 1);
  return buf;
}

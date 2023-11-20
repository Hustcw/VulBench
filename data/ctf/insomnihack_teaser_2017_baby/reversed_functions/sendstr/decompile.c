__int64 __fastcall sendstr(unsigned int a1, const char *a2)
{
  size_t v2;

  v2 = strlen(a2);
  return sendlen(a1, a2, v2);
}
__int64 __fastcall sendstr(int a1, const char *a2)
{
  unsigned __int64 v2;

  v2 = strlen(a2);
  return sendlen(a1, (__int64)a2, v2);
}

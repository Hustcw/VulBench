void __cdecl overwrite(int a1, char *s)
{
  size_t v2;
  int v3;
  Tweet *dest;

  dest = head;
  v3 = 0;
  while (dest)
  {
    if (v3 == a1)
    {
      v2 = strlen(s);
      memcpy(dest, s, v2);
      return;
    }
    dest = dest->next;
    ++v3;
  }
}
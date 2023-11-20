unsigned __int64 __fastcall add(int a1, int a2, int a3)
{
  unsigned __int64 v4;

  v4 = __readfsqword(0x28u);
  to[++w] = a2;
  len[w] = a3;
  next[w] = head[a1];
  head[a1] = w;
  return __readfsqword(0x28u) ^ v4;
}

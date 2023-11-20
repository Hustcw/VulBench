void __fastcall add(int a1, int a2, int a3)
{
  to[++w] = a2;
  len[w] = a3;
  next[w] = head[a1];
  head[a1] = w;
}
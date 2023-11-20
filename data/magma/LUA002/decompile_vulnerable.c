int __fastcall changedline(const Proto *p, int oldpc, int newpc)
{
  __int64 v4;
  int v5;
  int v6;
  bool v7;
  int v8;

  if ( newpc - oldpc <= 63 )
  {
    v4 = oldpc;
    v5 = 0;
    while ( 1 )
    {
      v6 = p->lineinfo[v4 + 1];
      if ( v6 == -128 )
        break;
      ++v4;
      v5 += v6;
      if ( newpc == v4 )
      {
        v7 = v5 == 0;
        return !v7;
      }
    }
  }
  v8 = luaG_getfuncline(p, oldpc);
  v7 = v8 == luaG_getfuncline(p, newpc);
  return !v7;
}

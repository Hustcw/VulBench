int __fastcall changedline(const Proto *p, int oldpc, int newpc)
{
  ls_byte *lineinfo;
  __int64 v5;
  int v6;
  int v7;
  bool v8;
  int v9;
  int result;

  lineinfo = p->lineinfo;
  if ( lineinfo )
  {
    if ( newpc - oldpc <= 63 )
    {
      v5 = oldpc;
      v6 = 0;
      while ( 1 )
      {
        v7 = lineinfo[v5 + 1];
        if ( v7 == -128 )
          break;
        ++v5;
        v6 += v7;
        if ( newpc == v5 )
        {
          v8 = v6 == 0;
          goto LABEL_8;
        }
      }
    }
    v9 = luaG_getfuncline(p, oldpc);
    v8 = v9 == luaG_getfuncline(p, newpc);
LABEL_8:
    LOBYTE(result) = !v8;
  }
  else
  {
    LOBYTE(result) = 0;
  }
  return (unsigned __int8)result;
}

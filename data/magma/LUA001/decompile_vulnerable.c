const char *__fastcall findvararg(CallInfo *ci, int n, StkId *pos)
{
  __int64 nextraargs;

  if ( !*(_BYTE *)(*(_QWORD *)&ci->func->val.value_.gc[1].tt + 11LL) )
    return 0LL;
  nextraargs = ci->u.l.nextraargs;
  if ( (int)nextraargs < n )
    return 0LL;
  *pos = &ci->func[n - nextraargs - 1];
  return "(vararg)";
}


const char *__fastcall luaG_findlocal(lua_State *L, CallInfo *ci, int n, StkId *pos)
{
  StkId v6;
  const Proto *v7;
  int v8;
  const char *result;
  CallInfo *p_top;

  v6 = ci->func + 1;
  if ( (ci->callstatus & 2) == 0 )
  {
    if ( n < 0 )
      return findvararg(ci, -n, pos);
    v7 = *(const Proto **)&ci->func->val.value_.gc[1].tt;
    v8 = currentpc(ci);
    result = luaF_getlocalname(v7, n, v8);
    if ( result )
      goto LABEL_11;
  }
  if ( L->ci == ci )
    p_top = (CallInfo *)&L->top;
  else
    p_top = ci->next;
  result = 0LL;
  if ( n > 0 && p_top->func - v6 >= n )
  {
    result = "(C temporary)";
    if ( (ci->callstatus & 2) == 0 )
      result = "(temporary)";
LABEL_11:
    if ( pos )
      *pos = &v6[n - 1];
  }
  return result;
}

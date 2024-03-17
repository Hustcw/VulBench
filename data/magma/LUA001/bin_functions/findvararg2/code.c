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
const char *__fastcall findvararg(CallInfo *ci, int n, StkId *pos)
{
  if ( !*(_BYTE *)(*(_QWORD *)&ci->func->val.value_.gc[1].tt + 11LL) || -ci->u.l.nextraargs > n )
    return 0LL;
  *pos = &ci->func[~n - ci->u.l.nextraargs];
  return "(vararg)";
}
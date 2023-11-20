static const char *findvararg(CallInfo *ci, int n, StkId *pos) {
  if (clLvalue(s2v(ci->func))->p->is_vararg) {
    int nextra = ci->u.l.nextraargs;
    if (n >= -nextra) { /* 'n' is negative */
      *pos = ci->func - nextra - (n + 1);
      return "(vararg)"; /* generic name for any vararg */
    }
  }
  return NULL; /* no such vararg */
}
const char *luaG_findlocal(lua_State *L, CallInfo *ci, int n, StkId *pos) {
  StkId base = ci->func + 1;
  const char *name = NULL;
  if (isLua(ci)) {
    if (n < 0) /* access to vararg values? */
      return findvararg(ci, n, pos);
    else
      name = luaF_getlocalname(ci_func(ci)->p, n, currentpc(ci));
  }
  if (name == NULL) { /* no 'standard' name? */
    StkId limit = (ci == L->ci) ? L->top : ci->next->func;
    if (limit - base >= n && n > 0) { /* is 'n' inside 'ci' stack? */
      /* generic name for any valid slot */
      name = isLua(ci) ? "(temporary)" : "(C temporary)";
    } else
      return NULL; /* no name */
  }
  if (pos)
    *pos = base + (n - 1);
  return name;
}

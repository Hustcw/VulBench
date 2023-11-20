unsigned __int64 parse_query_string()
{
  int v0;
  char *v1;
  __int64 v2;
  __int64 v3;
  __int64 v4;
  __int64 v5;
  __int64 v6;
  __int64 v7;
  const char *s;
  char *v10;
  char dest[8];
  __int64 v12;
  __int64 v13;
  __int64 v14;
  __int64 v15[9];
  unsigned __int64 v16;

  v16 = __readfsqword(0x28u);
  req_cvar = 0;
  for ( s = strtok(qs, "&"); s; s = strtok(0LL, "&") )
  {
    v10 = strchr(s, 61);
    *v10 = 0;
    strncpy(dest, s, 0x20uLL);
    base64decode(v10 + 1, (__int64)v15);
    v0 = req_cvar++;
    v1 = &reqvars[96 * v0];
    v2 = v12;
    *(_QWORD *)v1 = *(_QWORD *)dest;
    *((_QWORD *)v1 + 1) = v2;
    v3 = v14;
    *((_QWORD *)v1 + 2) = v13;
    *((_QWORD *)v1 + 3) = v3;
    v4 = v15[1];
    *((_QWORD *)v1 + 4) = v15[0];
    *((_QWORD *)v1 + 5) = v4;
    v5 = v15[3];
    *((_QWORD *)v1 + 6) = v15[2];
    *((_QWORD *)v1 + 7) = v5;
    v6 = v15[5];
    *((_QWORD *)v1 + 8) = v15[4];
    *((_QWORD *)v1 + 9) = v6;
    v7 = v15[7];
    *((_QWORD *)v1 + 10) = v15[6];
    *((_QWORD *)v1 + 11) = v7;
  }
  return __readfsqword(0x28u) ^ v16;
}

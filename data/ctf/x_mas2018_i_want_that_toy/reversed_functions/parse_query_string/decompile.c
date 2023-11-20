void parse_query_string()
{
  int v0;
  ReqVars *v1;
  __int64 v2;
  __int64 v3;
  __int64 v4;
  __int64 v5;
  __int64 v6;
  __int64 v7;
  const char *s;
  char *v9;
  char dest[32];
  char v11[64];
  unsigned __int64 v12;

  v12 = __readfsqword(0x28u);
  req_cvar = 0;
  for ( s = strtok(qs, "&"); s; s = strtok(0LL, "&") )
  {
    v9 = strchr(s, '=');
    *v9 = 0;
    strncpy(dest, s, 0x20uLL);
    base64decode(v9 + 1, v11);
    v0 = req_cvar++;
    v1 = &reqvars[v0];
    v2 = *(_QWORD *)&dest[8];
    *(_QWORD *)v1->query = *(_QWORD *)dest;
    *(_QWORD *)&v1->query[8] = v2;
    v3 = *(_QWORD *)&dest[24];
    *(_QWORD *)&v1->query[16] = *(_QWORD *)&dest[16];
    *(_QWORD *)&v1->query[24] = v3;
    v4 = *(_QWORD *)&v11[8];
    *(_QWORD *)v1->param = *(_QWORD *)v11;
    *(_QWORD *)&v1->param[8] = v4;
    v5 = *(_QWORD *)&v11[24];
    *(_QWORD *)&v1->param[16] = *(_QWORD *)&v11[16];
    *(_QWORD *)&v1->param[24] = v5;
    v6 = *(_QWORD *)&v11[40];
    *(_QWORD *)&v1->param[32] = *(_QWORD *)&v11[32];
    *(_QWORD *)&v1->param[40] = v6;
    v7 = *(_QWORD *)&v11[56];
    *(_QWORD *)&v1->param[48] = *(_QWORD *)&v11[48];
    *(_QWORD *)&v1->param[56] = v7;
  }
}
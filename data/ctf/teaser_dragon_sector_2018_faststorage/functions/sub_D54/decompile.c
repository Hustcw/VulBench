__int64 *__fastcall sub_D54(unsigned __int8 *a1)
{
  char v2;
  char v3;
  int v4;
  int v5;
  __int64 **i;

  v4 = sub_A8A(a1);
  v3 = sub_AC7(a1);
  v2 = sub_B38(a1);
  v5 = (int)abs32(v4) % 62;
  if ( !sub_C64(v5, v3, v2) )
    return 0LL;
  for ( i = (__int64 **)qword_202140[v5]; i && strcmp((const char *)i[1], (const char *)a1); i = (__int64 **)*i )
    ;
  return i[2];
}

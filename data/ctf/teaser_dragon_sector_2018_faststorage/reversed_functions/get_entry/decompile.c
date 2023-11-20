char *__fastcall get_entry(char *a1)
{
  char v2;
  char v3;
  int v4;
  int v5;
  Data *i;

  v4 = hash_str((unsigned __int8 *)a1);
  v3 = sub_AC7((unsigned __int8 *)a1);
  v2 = sub_B38(a1);
  v5 = (int)abs32(v4) % 62;
  if ( !sub_C64(v5, v3, v2) )
    return 0LL;
  for ( i = qword_202140[v5]; i && strcmp(i->field_8, a1); i = i->next )
    ;
  return i->field_10;
}
__int64 sub_20E0()
{
  int v0;
  _QWORD *v2;
  _BYTE *v3;
  char v4;
  bool v5;
  const char *v6;
  __int64 v7;
  _BYTE *v8;
  bool v9;
  const char *v10;
  __int64 v11;
  _BYTE *v12;

  if ( !qword_204040[0] )
    return 0LL;
  v0 = *(unsigned __int8 *)qword_204040[0];
  if ( v0 == 112 )
  {
    if ( *(_BYTE *)(qword_204040[0] + 1LL) == 119
      && *(_BYTE *)(qword_204040[0] + 2LL) == 100
      && !*(_BYTE *)(qword_204040[0] + 3LL) )
    {
      sub_18C0();
      return 1LL;
    }
    if ( !strcmp((const char *)qword_204040[0], "echo") )
      goto LABEL_13;
    goto LABEL_21;
  }
  if ( strcmp((const char *)qword_204040[0], "echo") )
  {
    if ( v0 == 108 )
    {
      if ( *(_BYTE *)(qword_204040[0] + 1LL) == 115 && !*(_BYTE *)(qword_204040[0] + 2LL) )
      {
        sub_19A0();
        return 1LL;
      }
    }
    else if ( v0 == 99 )
    {
      if ( *(_BYTE *)(qword_204040[0] + 1LL) == 100 && !*(_BYTE *)(qword_204040[0] + 2LL) )
      {
        sub_1B90();
        return 1LL;
      }
      v5 = strcmp((const char *)qword_204040[0], "mkdir") == 0;
      if ( !v5 )
        goto LABEL_24;
      goto LABEL_45;
    }
LABEL_21:
    if ( strcmp((const char *)qword_204040[0], "mkdir") )
    {
      v5 = v0 == 119;
      if ( v0 == 119 )
      {
        v5 = *(_BYTE *)(qword_204040[0] + 1LL) == 99;
        if ( *(_BYTE *)(qword_204040[0] + 1LL) == 99 )
        {
          v5 = *(_BYTE *)(qword_204040[0] + 2LL) == 0;
          if ( !*(_BYTE *)(qword_204040[0] + 2LL) )
          {
            sub_1D60();
            return 1LL;
          }
        }
      }
LABEL_24:
      v6 = "clear";
      v7 = 6LL;
      v8 = (_BYTE *)qword_204040[0];
      do
      {
        if ( !v7 )
          break;
        v5 = *v8++ == *v6++;
        --v7;
      }
      while ( v5 );
      if ( v5 )
      {
        sub_1DA0(v6, v8);
        return 1LL;
      }
      else if ( !strcmp((const char *)qword_204040[0], "help") )
      {
        sub_1DD0();
        return 1LL;
      }
      else
      {
        v9 = strcmp((const char *)qword_204040[0], "monitor") == 0;
        if ( v9 )
        {
          sub_1410();
          return 1LL;
        }
        else
        {
          v10 = "quit";
          v11 = 5LL;
          v12 = (_BYTE *)qword_204040[0];
          do
          {
            if ( !v11 )
              break;
            v9 = *v12++ == *v10++;
            --v11;
          }
          while ( v9 );
          if ( v9 )
            sub_20D0(v10, v12);
          puts("No has this command!");
          return 0LL;
        }
      }
    }
LABEL_45:
    sub_1D10();
    return 1LL;
  }
LABEL_13:
  if ( unk_205B40 <= 1 )
  {
LABEL_35:
    sub_1930();
    return 1LL;
  }
  else
  {
    v2 = &qword_204040[1];
    while ( 1 )
    {
      v3 = (_BYTE *)*v2;
      if ( *(_BYTE *)*v2 == 62 )
      {
        v4 = v3[1];
        if ( !v4 || v4 == 62 && !v3[2] )
          break;
      }
      if ( &qword_204040[(unsigned int)(unk_205B40 - 2) + 2] == ++v2 )
        goto LABEL_35;
    }
    sub_1EC0();
    return 1LL;
  }
}

void cmd_view()
{
  int v0;
  int v1;
  int v2;
  int v3;
  int i;
  char v5;
  char v6;
  int v7;
  int v8;
  int v9;
  bool v10;
  char v11;
  int v12;
  char v13;
  char v14;
  int v15;
  int v16;
  int v17;
  int v18;
  int v19;
  int v20;
  char s[25];
  char v22;
  char v23;
  char v24;
  char v25[130];

  v20 = pos;
  v0 = dword_8057F84;
  v1 = 0;
  v2 = pos;
  while ( v1 <= 50 )
  {
    v3 = (byte_8057F98[((v0 + v1 + v2 - 25) % v0) >> 1] >> (4 * (((v0 + v1 + v2 - 25) % v0) & 1))) & 0xF;
    v25[v1 + 51] = v3;
    if ( (unsigned int)((v0 + v1 + v2 - 25) % v0 - dword_8058150 + 2) <= 4 )
      LOBYTE(v3) = 12;
    v25[v1++] = v3;
  }
  __sprintf_chk(s, 1, 64, " / Pos: %3d HP: %3d", pos, hp);
  for ( i = 17; i >= 0; i = v18 - 1 )
  {
    v15 = 1;
    v16 = i - 2;
    v19 = i - 1;
    v17 = i;
    while ( v15 <= 49 )
    {
      v5 = v25[v15];
      if ( v16 == v5 && v15 == 25 )
      {
        v22 = 111;
      }
      else if ( v5 == v19 && v15 == 25 )
      {
        v22 = 84;
      }
      else
      {
        v6 = v25[v15 + 51];
        if ( v6 == v17 )
        {
          if ( v5 == v6 )
          {
            v7 = v25[v15 + 50];
            if ( v7 >= v17 )
            {
              if ( v17 >= v7 )
              {
                v12 = v25[v15 + 52];
                if ( v12 >= v17 )
                {
                  v10 = v17 < v12;
                  v13 = 45;
                  if ( !v10 )
                    v13 = 95;
                  s[v15] = v13;
                }
                else
                {
                  s[v15] = 126;
                }
              }
              else
              {
                v9 = v25[v15 + 52];
                if ( v9 >= v17 )
                {
                  v10 = v17 < v9;
                  v11 = 118;
                  if ( !v10 )
                    v11 = 96;
                  s[v15] = v11;
                }
                else
                {
                  s[v15] = 92;
                }
              }
            }
            else
            {
              v8 = v25[v15 + 52];
              if ( v8 >= v17 )
                s[v15] = 3 * (v17 < v8) + 44;
              else
                s[v15] = 94;
            }
          }
          else
          {
            s[v15] = 119;
          }
        }
        else if ( v17 <= v6 )
        {
          if ( ((v15 + v20) ^ (me >> v17)) == 20 * (((v15 + v20) ^ (me >> v17)) / 20) )
            s[v15] = (v20 + v17 + v15) % 5 == 0 ? 64 : 35;
          else
            s[v15] = 46;
        }
        else if ( v17 != 17 )
        {
          if ( v17 <= v5 )
          {
            v14 = 32;
            if ( v5 != v6 )
              v14 = 77;
            s[v15] = v14;
          }
          else
          {
            s[v15] = 32;
          }
        }
      }
      ++v15;
    }
    v18 = v17;
    if ( v17 != 17 )
    {
      s[0] = 124;
      v23 = 124;
    }
    v24 = 0;
    puts(s);
  }
  puts(" \\_______________________________________________/\n");
}
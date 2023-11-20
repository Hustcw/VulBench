unsigned __int8 *__cdecl base64_encode(const unsigned __int8 *src, size_t len, size_t *out_len)
{
  _BYTE *v4;
  unsigned __int8 *v5;
  unsigned __int8 *v6;
  _BYTE *v7;
  _BYTE *v8;
  unsigned __int8 *v9;
  unsigned __int8 *v10;
  const unsigned __int8 *end;
  unsigned __int8 *out;
  size_t olen;
  int line_len;
  const unsigned __int8 *in;
  unsigned __int8 *pos;
  unsigned __int8 *posa;
  unsigned __int8 *posb;

  olen = (4 * len / 3 + 4) / 0x48 + 4 * len / 3 + 4 + 1;
  if ( olen < len )
    return 0LL;
  out = (unsigned __int8 *)malloc(olen);
  if ( !out )
    return 0LL;
  end = &src[len];
  in = src;
  pos = out;
  line_len = 0;
  while ( end - in > 2 )
  {
    *pos = base64_table[*in >> 2];
    pos[1] = base64_table[(in[1] >> 4) | (16 * *in) & 0x30];
    pos[2] = base64_table[(in[2] >> 6) | (4 * in[1]) & 0x3C];
    v4 = pos + 3;
    pos += 4;
    *v4 = base64_table[in[2] & 0x3F];
    in += 3;
    line_len += 4;
    if ( line_len > 71 )
    {
      v5 = pos++;
      *v5 = 10;
      line_len = 0;
    }
  }
  if ( end != in )
  {
    v6 = pos;
    posa = pos + 1;
    *v6 = base64_table[*in >> 2];
    if ( end - in == 1 )
    {
      *posa = base64_table[(16 * *in) & 0x30];
      v7 = posa + 1;
      posb = posa + 2;
      *v7 = 61;
    }
    else
    {
      *posa = base64_table[(in[1] >> 4) | (16 * *in) & 0x30];
      v8 = posa + 1;
      posb = posa + 2;
      *v8 = base64_table[(4 * in[1]) & 0x3C];
    }
    v9 = posb;
    pos = posb + 1;
    *v9 = 61;
    line_len += 4;
  }
  if ( line_len )
  {
    v10 = pos++;
    *v10 = 10;
  }
  *pos = 0;
  if ( out_len )
    *out_len = pos - out;
  return out;
}

int __fastcall MDC2_Update(MDC2_CTX *c, const unsigned __int8 *in, size_t len)
{
  size_t v3;
  const unsigned __int8 *v4;
  __int64 num;
  __int64 v7;
  unsigned __int8 *v8;
  unsigned __int64 v9;

  v3 = len;
  v4 = in;
  num = c->num;
  if ( c->num )
  {
    v7 = 8 - num;
    v8 = &c->data[num];
    if ( 8 - num > len )
    {
      memcpy(v8, in, len);
      LODWORD(v3) = num + v3;
LABEL_9:
      c->num = v3;
      return 1;
    }
    memcpy(v8, in, 8 - num);
    v3 -= v7;
    v4 = &in[v7];
    c->num = 0;
    mdc2_body(c, c->data, 8uLL);
  }
  v9 = v3 & 0xFFFFFFFFFFFFFFF8LL;
  if ( (v3 & 0xFFFFFFFFFFFFFFF8LL) != 0 )
    mdc2_body(c, v4, v3 & 0xFFFFFFFFFFFFFFF8LL);
  v3 -= v9;
  if ( v3 )
  {
    memcpy(c->data, &v4[v9], v3);
    goto LABEL_9;
  }
  return 1;
}

int __fastcall MDC2_Update(MDC2_CTX *c, const unsigned __int8 *in, size_t len)
{
  size_t v3;
  const unsigned __int8 *v4;
  __int64 num;
  unsigned __int64 v6;

  v3 = len;
  v4 = in;
  num = c->num;
  if ( c->num )
  {
    if ( num + len <= 7 )
    {
      memcpy(&c->data[num], in, len);
      LODWORD(v3) = num + v3;
LABEL_9:
      c->num = v3;
      return 1;
    }
    memcpy(&c->data[num], in, 8 - num);
    v3 -= 8 - num;
    v4 = &in[8 - num];
    c->num = 0;
    mdc2_body(c, c->data, 8uLL);
  }
  v6 = v3 & 0xFFFFFFFFFFFFFFF8LL;
  if ( (v3 & 0xFFFFFFFFFFFFFFF8LL) != 0 )
    mdc2_body(c, v4, v3 & 0xFFFFFFFFFFFFFFF8LL);
  v3 -= v6;
  if ( v3 )
  {
    memcpy(c->data, &v4[v6], v3);
    goto LABEL_9;
  }
  return 1;
}

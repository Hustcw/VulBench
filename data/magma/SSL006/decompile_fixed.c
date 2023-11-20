int __fastcall EVP_EncodeUpdate(
        EVP_ENCODE_CTX *ctx,
        unsigned __int8 *out,
        int *outl,
        const unsigned __int8 *in,
        int inl)
{
  __int64 length;
  int v7;
  __int64 num;
  int v11;
  unsigned __int64 v12;
  int v13;
  __int64 v14;
  __int64 v15;

  *outl = 0;
  if ( inl <= 0 )
    return 0;
  length = ctx->length;
  if ( length >= 81 )
    OPENSSL_die("assertion failed: ctx->length <= (int)sizeof(ctx->enc_data)", "crypto/evp/encode.c", 171);
  v7 = inl;
  num = ctx->num;
  if ( (int)length - (int)num > inl )
  {
    memcpy(&ctx->enc_data[num], in, inl);
    ctx->num += v7;
    return 1;
  }
  if ( (_DWORD)num )
  {
    v15 = length - num;
    memcpy(&ctx->enc_data[num], in, length - num);
    v11 = evp_encodeblock_int(ctx, out, ctx->enc_data, ctx->length);
    ctx->num = 0;
    v12 = v11;
    out += v11;
    if ( (ctx->flags & 1) == 0 )
    {
      *out++ = 10;
      v12 = v11 + 1LL;
    }
    in += v15;
    v7 -= v15;
    *out = 0;
    LODWORD(length) = ctx->length;
    if ( v12 > 0x7FFFFFFF )
      goto LABEL_17;
  }
  else
  {
    v12 = 0LL;
  }
  for ( ; v7 >= (int)length; LODWORD(length) = ctx->length )
  {
    v13 = evp_encodeblock_int(ctx, out, in, length);
    v14 = ctx->length;
    out += v13;
    v12 += v13;
    if ( (ctx->flags & 1) == 0 )
    {
      *out++ = 10;
      ++v12;
    }
    in += v14;
    v7 -= v14;
    *out = 0;
    if ( v12 >= 0x80000000 )
      break;
  }
LABEL_17:
  if ( (v12 & 0xFFFFFFFF80000000LL) != 0 )
  {
    *outl = 0;
    return 0;
  }
  if ( v7 )
    memcpy(ctx->enc_data, in, v7);
  ctx->num = v7;
  *outl = v12;
  return 1;
}

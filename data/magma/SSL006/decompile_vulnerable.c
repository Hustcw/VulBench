int __fastcall EVP_EncodeUpdate(
        EVP_ENCODE_CTX *ctx,
        unsigned __int8 *out,
        int *outl,
        const unsigned __int8 *in,
        int inl)
{
  int length;
  int v7;
  unsigned __int8 *v8;
  __int64 num;
  int v11;
  unsigned __int64 v12;
  int v13;
  __int64 v14;
  size_t v15;

  *outl = 0;
  if ( inl <= 0 )
    return 0;
  length = ctx->length;
  if ( length >= 81 )
    OPENSSL_die("assertion failed: ctx->length <= (int)sizeof(ctx->enc_data)", "crypto/evp/encode.c", 171);
  v7 = inl;
  v8 = out;
  num = ctx->num;
  if ( (int)num + inl < length )
  {
    memcpy(&ctx->enc_data[num], in, inl);
    ctx->num += v7;
    return 1;
  }
  if ( (_DWORD)num )
  {
    v15 = length - (int)num;
    memcpy(&ctx->enc_data[num], in, v15);
    v11 = evp_encodeblock_int(ctx, out, ctx->enc_data, ctx->length);
    ctx->num = 0;
    v12 = v11;
    v8 = &out[v11];
    if ( (ctx->flags & 1) == 0 )
    {
      *v8++ = 10;
      v12 = v11 + 1LL;
    }
    in += v15;
    v7 -= v15;
    *v8 = 0;
    length = ctx->length;
    if ( v12 > 0x7FFFFFFF )
      goto LABEL_17;
  }
  else
  {
    v12 = 0LL;
  }
  for ( ; v7 >= length; length = ctx->length )
  {
    v13 = evp_encodeblock_int(ctx, v8, in, length);
    v14 = ctx->length;
    v8 += v13;
    v12 += v13;
    if ( (ctx->flags & 1) == 0 )
    {
      *v8++ = 10;
      ++v12;
    }
    in += v14;
    v7 -= v14;
    *v8 = 0;
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

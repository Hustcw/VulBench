int EVP_EncodeUpdate(EVP_ENCODE_CTX *ctx, unsigned char *out, int *outl,
                     const unsigned char *in, int inl) {
  int i, j;
  size_t total = 0;

  *outl = 0;
  if (inl <= 0)
    return 0;
  OPENSSL_assert(ctx->length <= (int)sizeof(ctx->enc_data));
  if ((ctx->num + inl) < ctx->length) {
    memcpy(&(ctx->enc_data[ctx->num]), in, inl);
    ctx->num += inl;
    return 1;
  }
  if (ctx->num != 0) {
    i = ctx->length - ctx->num;
    memcpy(&(ctx->enc_data[ctx->num]), in, i);
    in += i;
    inl -= i;
    j = evp_encodeblock_int(ctx, out, ctx->enc_data, ctx->length);
    ctx->num = 0;
    out += j;
    total = j;
    if ((ctx->flags & EVP_ENCODE_CTX_NO_NEWLINES) == 0) {
      *(out++) = '\n';
      total++;
    }
    *out = '\0';
  }
  while (inl >= ctx->length && total <= INT_MAX) {
    j = evp_encodeblock_int(ctx, out, in, ctx->length);
    in += ctx->length;
    inl -= ctx->length;
    out += j;
    total += j;
    if ((ctx->flags & EVP_ENCODE_CTX_NO_NEWLINES) == 0) {
      *(out++) = '\n';
      total++;
    }
    *out = '\0';
  }
  if (total > INT_MAX) {
    /* Too much output data! */
    *outl = 0;
    return 0;
  }
  if (inl != 0)
    memcpy(&(ctx->enc_data[0]), in, inl);
  ctx->num = inl;
  *outl = total;

  return 1;
}


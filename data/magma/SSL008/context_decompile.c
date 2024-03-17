
EVP_PKEY *__fastcall ssl_generate_pkey(SSL_12 *s, EVP_PKEY *pm)
{
  EVP_PKEY_CTX *v2;
  EVP_PKEY_CTX_0 *v3;
  EVP_PKEY *pkey;

  pkey = 0LL;
  if ( !pm )
    return 0LL;
  v2 = EVP_PKEY_CTX_new_from_pkey(s->ctx->libctx, pm, s->ctx->propq);
  v3 = (EVP_PKEY_CTX_0 *)v2;
  if ( v2 && EVP_PKEY_keygen_init((EVP_PKEY_CTX_0 *)v2) > 0 && EVP_PKEY_keygen(v3, &pkey) <= 0 )
  {
    EVP_PKEY_free(pkey);
    pkey = 0LL;
  }
  EVP_PKEY_CTX_free((EVP_PKEY_CTX *)v3);
  return pkey;
}

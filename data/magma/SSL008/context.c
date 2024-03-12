/* Generate a private key from parameters */
EVP_PKEY *ssl_generate_pkey(SSL *s, EVP_PKEY *pm)
{
    EVP_PKEY_CTX *pctx = NULL;
    EVP_PKEY *pkey = NULL;

    if (pm == NULL)
        return NULL;
    pctx = EVP_PKEY_CTX_new_from_pkey(s->ctx->libctx, pm, s->ctx->propq);
    if (pctx == NULL)
        goto err;
    if (EVP_PKEY_keygen_init(pctx) <= 0)
        goto err;
    if (EVP_PKEY_keygen(pctx, &pkey) <= 0) {
        EVP_PKEY_free(pkey);
        pkey = NULL;
    }

    err:
    EVP_PKEY_CTX_free(pctx);
    return pkey;
}

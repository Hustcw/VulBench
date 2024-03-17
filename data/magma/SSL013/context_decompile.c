int __fastcall ossl_rsa_pss_to_ctx(EVP_MD_CTX *ctx, EVP_PKEY_CTX *pkctx, const X509_ALGOR *sigalg, EVP_PKEY *pkey)
{
  RSA_PSS_PARAMS_0 *v6;
  int v7;
  int v8;
  int type;
  const EVP_MD_1 *checkmd;
  const EVP_MD_1 *mgf1md;
  int saltlen;
  const EVP_MD_1 *md;
  EVP_PKEY_CTX *pkctxa;

  pkctxa = pkctx;
  mgf1md = 0LL;
  md = 0LL;
  if ( OBJ_obj2nid(sigalg->algorithm) == 912 )
  {
    v6 = ossl_rsa_pss_decode(sigalg);
    if ( ossl_rsa_pss_get_param(v6, &md, &mgf1md, &saltlen) )
    {
      if ( pkey )
      {
        if ( !EVP_DigestVerifyInit(ctx, &pkctxa, (const EVP_MD_0 *)md, 0LL, pkey) )
          goto LABEL_9;
LABEL_14:
        v7 = -1;
        if ( EVP_PKEY_CTX_set_rsa_padding(pkctxa, 6) > 0 && EVP_PKEY_CTX_set_rsa_pss_saltlen(pkctxa, saltlen) > 0 )
          v7 = 2 * (EVP_PKEY_CTX_set_rsa_mgf1_md(pkctxa, (const EVP_MD_3 *)mgf1md) > 0) - 1;
        goto err;
      }
      if ( EVP_PKEY_CTX_get_signature_md(pkctx, (const EVP_MD **)&checkmd) <= 0 )
      {
LABEL_9:
        v7 = -1;
err:
        RSA_PSS_PARAMS_free(v6);
        return v7;
      }
      type = EVP_MD_get_type((const EVP_MD *)md);
      if ( type == EVP_MD_get_type((const EVP_MD *)checkmd) )
        goto LABEL_14;
      ERR_new();
      ERR_set_debug("crypto/rsa/rsa_ameth.c", 549, "ossl_rsa_pss_to_ctx");
      v8 = 158;
    }
    else
    {
      ERR_new();
      ERR_set_debug("crypto/rsa/rsa_ameth.c", 536, "ossl_rsa_pss_to_ctx");
      v8 = 149;
    }
    ERR_set_error(4, v8, 0LL);
    goto LABEL_9;
  }
  ERR_new();
  ERR_set_debug("crypto/rsa/rsa_ameth.c", 529, "ossl_rsa_pss_to_ctx");
  ERR_set_error(4, 155, 0LL);
  return -1;
}
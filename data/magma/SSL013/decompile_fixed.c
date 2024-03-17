int __fastcall rsa_item_verify(
        EVP_MD_CTX *ctx,
        const ASN1_ITEM *it,
        const void *asn,
        const X509_ALGOR *sigalg,
        const ASN1_BIT_STRING *sig,
        EVP_PKEY *pkey)
{
  if ( OBJ_obj2nid(sigalg->algorithm) == 912 )
    return 3 * (ossl_rsa_pss_to_ctx(ctx, 0LL, sigalg, pkey) > 0) - 1;
  ERR_new();
  ERR_set_debug("crypto/rsa/rsa_ameth.c", 617, "rsa_item_verify");
  ERR_set_error(4, 155, 0LL);
  return -1;
}

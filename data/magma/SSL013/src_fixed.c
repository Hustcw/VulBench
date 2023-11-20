static int rsa_item_verify(EVP_MD_CTX *ctx, const ASN1_ITEM *it,
                           const void *asn, const X509_ALGOR *sigalg,
                           const ASN1_BIT_STRING *sig, EVP_PKEY *pkey) {
  /* Sanity check: make sure it is PSS */
  if (OBJ_obj2nid(sigalg->algorithm) != EVP_PKEY_RSA_PSS) {
    ERR_raise(ERR_LIB_RSA, RSA_R_UNSUPPORTED_SIGNATURE_TYPE);
    return -1;
  }
  if (ossl_rsa_pss_to_ctx(ctx, NULL, sigalg, pkey) > 0) {
    /* Carry on */
    return 2;
  }
  return -1;
}

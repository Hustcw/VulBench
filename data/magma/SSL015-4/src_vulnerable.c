int PKCS7_dataVerify(X509_STORE *cert_store, X509_STORE_CTX *ctx, BIO *bio,
                     PKCS7 *p7, PKCS7_SIGNER_INFO *si) {
  PKCS7_ISSUER_AND_SERIAL *ias;
  int ret = 0, i;
  STACK_OF(X509) * cert;
  X509 *x509;

  if (PKCS7_type_is_signed(p7)) {
    cert = p7->d.sign->cert;
  } else if (PKCS7_type_is_signedAndEnveloped(p7)) {
    cert = p7->d.signed_and_enveloped->cert;
  } else {
    ERR_raise(ERR_LIB_PKCS7, PKCS7_R_WRONG_PKCS7_TYPE);
    goto err;
  }
  /* XXXXXXXXXXXXXXXXXXXXXXX */
  ias = si->issuer_and_serial;

  x509 = X509_find_by_issuer_and_serial(cert, ias->issuer, ias->serial);

  /* were we able to find the cert in passed to us */
  if (x509 == NULL) {
    ERR_raise(ERR_LIB_PKCS7, PKCS7_R_UNABLE_TO_FIND_CERTIFICATE);
    goto err;
  }

  /* Lets verify */
  if (!X509_STORE_CTX_init(ctx, cert_store, x509, cert)) {
    ERR_raise(ERR_LIB_PKCS7, ERR_R_X509_LIB);
    goto err;
  }
  X509_STORE_CTX_set_purpose(ctx, X509_PURPOSE_SMIME_SIGN);
  i = X509_verify_cert(ctx);
  if (i <= 0) {
    ERR_raise(ERR_LIB_PKCS7, ERR_R_X509_LIB);
    goto err;
  }

  return PKCS7_signatureVerify(bio, p7, si, x509);
err:
  return ret;
}


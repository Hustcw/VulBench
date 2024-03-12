int __fastcall PKCS7_dataVerify(
        X509_STORE *cert_store,
        X509_STORE_CTX *ctx,
        BIO *bio,
        PKCS7 *p7,
        PKCS7_SIGNER_INFO *si_0)
{
  stack_st_X509 *v8;
  X509_0 *v9;
  X509 *v10;
  int v12;
  int v13;
  PKCS7_SIGNER_INFO *si_0a;
  BIO *bioa;

  if ( p7 )
  {
    if ( p7->d.ptr )
    {
      if ( OBJ_obj2nid(p7->type) == 22 || OBJ_obj2nid(p7->type) == 24 )
      {
        bioa = bio;
        v8 = (stack_st_X509 *)*((_QWORD *)p7->d.ptr + 2);
        si_0a = si_0;
        v9 = (X509_0 *)X509_find_by_issuer_and_serial(
                         v8,
                         si_0->issuer_and_serial->issuer,
                         si_0->issuer_and_serial->serial);
        if ( v9 )
        {
          v10 = (X509 *)v9;
          if ( X509_STORE_CTX_init((X509_STORE_CTX_1 *)ctx, cert_store, v9, v8) )
          {
            X509_STORE_CTX_set_purpose((X509_STORE_CTX_1 *)ctx, 4);
            if ( X509_verify_cert((X509_STORE_CTX_1 *)ctx) > 0 )
              return PKCS7_signatureVerify(bioa, p7, si_0a, v10);
            ERR_new();
            v13 = 1030;
          }
          else
          {
            ERR_new();
            v13 = 1024;
          }
          ERR_set_debug("crypto/pkcs7/pk7_doit.c", v13, "PKCS7_dataVerify");
          v12 = 524299;
        }
        else
        {
          ERR_new();
          ERR_set_debug("crypto/pkcs7/pk7_doit.c", 1018, "PKCS7_dataVerify");
          v12 = 106;
        }
      }
      else
      {
        ERR_new();
        ERR_set_debug("crypto/pkcs7/pk7_doit.c", 1008, "PKCS7_dataVerify");
        v12 = 114;
      }
    }
    else
    {
      ERR_new();
      ERR_set_debug("crypto/pkcs7/pk7_doit.c", 994, "PKCS7_dataVerify");
      v12 = 122;
    }
  }
  else
  {
    ERR_new();
    ERR_set_debug("crypto/pkcs7/pk7_doit.c", 989, "PKCS7_dataVerify");
    v12 = 143;
  }
  ERR_set_error(33, v12, 0LL);
  return 0;
}

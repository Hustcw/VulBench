int __fastcall get_crl_sk(
        X509_STORE_CTX_1 *ctx,
        X509_CRL **pcrl,
        X509_CRL **pdcrl,
        X509_0 **pissuer,
        int *pscore,
        unsigned int *preasons,
        stack_st_X509_CRL *crls)
{
  int v10;
  const OPENSSL_STACK *v11;
  int v12;
  X509_CRL *v13;
  int crl_score;
  int v15;
  const ASN1_TIME *Update;
  const ASN1_TIME *v17;
  X509_CRL *v18;
  X509_0 *x;
  int *pscorea;
  X509_CRL **pdcrla;
  X509_0 **pissuera;
  X509_0 *crl_issuer_0;
  X509_STORE_CTX_1 *ctxa;
  unsigned int *preasonsa;
  X509_0 *best_crl_issuer;
  int day;
  int sec;
  X509_CRL *best_crl;
  unsigned int v32;
  int v33;
  unsigned int reasons;

  preasonsa = preasons;
  v10 = *pscore;
  ctxa = ctx;
  x = (X509_0 *)ctx->current_cert;
  crl_issuer_0 = 0LL;
  v11 = ossl_check_const_X509_CRL_sk_type(crls);
  if ( OPENSSL_sk_num(v11) <= 0 )
    return v10 > 447;
  pissuera = pissuer;
  pdcrla = pdcrl;
  pscorea = pscore;
  best_crl_issuer = 0LL;
  best_crl = 0LL;
  v12 = 0;
  reasons = 0;
  do
  {
    v13 = (X509_CRL *)OPENSSL_sk_value(v11, v12);
    v32 = *preasonsa;
    crl_score = get_crl_score(ctxa, &crl_issuer_0, &v32, v13, x);
    if ( crl_score >= v10 )
    {
      v15 = crl_score;
      if ( crl_score )
      {
        if ( !best_crl || crl_score != v10 )
        {
LABEL_3:
          best_crl_issuer = crl_issuer_0;
          reasons = v32;
          v10 = v15;
          best_crl = v13;
          goto LABEL_4;
        }
        v33 = v10;
        Update = X509_CRL_get0_lastUpdate(best_crl);
        v17 = X509_CRL_get0_lastUpdate(v13);
        if ( ASN1_TIME_diff(&day, &sec, Update, v17) )
        {
          v10 = v33;
          if ( day > 0 || sec > 0 )
            goto LABEL_3;
        }
        else
        {
          v10 = v33;
        }
      }
    }
LABEL_4:
    ++v12;
  }
  while ( v12 < OPENSSL_sk_num(v11) );
  v18 = best_crl;
  if ( best_crl )
  {
    X509_CRL_free(*pcrl);
    *pcrl = v18;
    *pissuera = best_crl_issuer;
    *pscorea = v10;
    *preasonsa = reasons;
    X509_CRL_up_ref(v18);
    X509_CRL_free(*pdcrla);
    *pdcrla = 0LL;
    get_delta_sk(ctxa, pdcrla, pscorea, v18, crls);
  }
  return v10 > 447;
}


const ASN1_TIME *__fastcall X509_CRL_get0_lastUpdate(const X509_CRL *crl)
{
  return crl->crl.lastUpdate;
}

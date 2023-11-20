static int get_crl_sk(X509_STORE_CTX *ctx, X509_CRL **pcrl, X509_CRL **pdcrl,
                      X509 **pissuer, int *pscore, unsigned int *preasons,
                      STACK_OF(X509_CRL) * crls) {
  int i, crl_score, best_score = *pscore;
  unsigned int reasons, best_reasons = 0;
  X509 *x = ctx->current_cert;
  X509_CRL *crl, *best_crl = NULL;
  X509 *crl_issuer = NULL, *best_crl_issuer = NULL;

  for (i = 0; i < sk_X509_CRL_num(crls); i++) {
    crl = sk_X509_CRL_value(crls, i);
    reasons = *preasons;
    crl_score = get_crl_score(ctx, &crl_issuer, &reasons, crl, x);
    if (crl_score < best_score)
      continue;
      /* If current CRL is equivalent use it if it is newer */
    if (crl_score == best_score) {
      int day, sec;

      if (ASN1_TIME_diff(&day, &sec, X509_CRL_get0_lastUpdate(best_crl),
                         X509_CRL_get0_lastUpdate(crl)) == 0)
        continue;
      /*
       * ASN1_TIME_diff never returns inconsistent signs for |day|
       * and |sec|.
       */
      if (day <= 0 && sec <= 0)
        continue;
    }
    best_crl = crl;
    best_crl_issuer = crl_issuer;
    best_score = crl_score;
    best_reasons = reasons;
  }

  if (best_crl != NULL) {
    X509_CRL_free(*pcrl);
    *pcrl = best_crl;
    *pissuer = best_crl_issuer;
    *pscore = best_score;
    *preasons = best_reasons;
    X509_CRL_up_ref(best_crl);
    X509_CRL_free(*pdcrl);
    *pdcrl = NULL;
    get_delta_sk(ctx, pdcrl, pscore, best_crl, crls);
  }

  if (best_score >= CRL_SCORE_VALID)
    return 1;

  return 0;
}


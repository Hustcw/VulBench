const ASN1_TIME *__fastcall X509_CRL_get0_lastUpdate(const X509_CRL *crl)
{
  return crl->crl.lastUpdate;
}
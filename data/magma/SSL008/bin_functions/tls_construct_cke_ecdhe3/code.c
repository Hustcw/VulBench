
int __fastcall tls_construct_cke_ecdhe(SSL_8 *s, WPACKET *pkt)
{
  EVP_PKEY *peer_tmp;
  EVP_PKEY *pkey;
  int v4;
  size_t v5;
  int v6;
  unsigned __int8 *encodedPoint;

  encodedPoint = 0LL;
  peer_tmp = s->s3.peer_tmp;
  if ( peer_tmp )
  {
    pkey = ssl_generate_pkey((SSL_12 *)s, s->s3.peer_tmp);
    v4 = 0;
    if ( ssl_derive((SSL_12 *)s, pkey, peer_tmp, 0) )
    {
      v5 = EVP_PKEY_get1_encoded_public_key(pkey, &encodedPoint);
      if ( !v5 )
      {
        ERR_new();
        ERR_set_debug("ssl/statem/statem_clnt.c", 3002, "tls_construct_cke_ecdhe");
        v4 = 0;
        v6 = 524304;
        goto LABEL_8;
      }
      v4 = 1;
      if ( !WPACKET_sub_memcpy__(pkt, encodedPoint, v5, 1uLL) )
      {
        ERR_new();
        ERR_set_debug("ssl/statem/statem_clnt.c", 3007, "tls_construct_cke_ecdhe");
        v4 = 0;
        v6 = 786691;
LABEL_8:
        ossl_statem_fatal((SSL_3 *)s, 80, v6, 0LL);
      }
    }
    CRYPTO_free(encodedPoint, "ssl/statem/statem_clnt.c", 3013);
    EVP_PKEY_free(pkey);
    return v4;
  }
  ERR_new();
  ERR_set_debug("ssl/statem/statem_clnt.c", 2978, "tls_construct_cke_ecdhe");
  v4 = 0;
  ossl_statem_fatal((SSL_3 *)s, 80, 786691, 0LL);
  return v4;
}

int __fastcall tls_construct_cke_ecdhe(SSL_8 *s, WPACKET *pkt)
{
  EVP_PKEY *peer_tmp;
  EVP_PKEY *pkey;
  EVP_PKEY *v4;
  int v5;
  size_t v6;
  int v7;
  unsigned __int8 *encodedPoint;

  encodedPoint = 0LL;
  peer_tmp = s->s3.peer_tmp;
  if ( peer_tmp )
  {
    pkey = ssl_generate_pkey((SSL_12 *)s, s->s3.peer_tmp);
    v4 = pkey;
    if ( pkey )
    {
      v5 = 0;
      if ( !ssl_derive((SSL_12 *)s, pkey, peer_tmp, 0) )
        goto err;
      v6 = EVP_PKEY_get1_encoded_public_key(v4, &encodedPoint);
      if ( !v6 )
      {
        ERR_new();
        ERR_set_debug("ssl/statem/statem_clnt.c", 3002, "tls_construct_cke_ecdhe");
        v5 = 0;
        v7 = 524304;
        goto LABEL_10;
      }
      v5 = 1;
      if ( WPACKET_sub_memcpy__(pkt, encodedPoint, v6, 1uLL) )
      {
err:
        CRYPTO_free(encodedPoint, "ssl/statem/statem_clnt.c", 3013);
        EVP_PKEY_free(v4);
        return v5;
      }
      ERR_new();
      ERR_set_debug("ssl/statem/statem_clnt.c", 3007, "tls_construct_cke_ecdhe");
      v5 = 0;
      v7 = 786691;
    }
    else
    {
      ERR_new();
      ERR_set_debug("ssl/statem/statem_clnt.c", 2985, "tls_construct_cke_ecdhe");
      v5 = 0;
      v7 = 786688;
    }
LABEL_10:
    ossl_statem_fatal((SSL_3 *)s, 80, v7, 0LL);
    goto err;
  }
  ERR_new();
  ERR_set_debug("ssl/statem/statem_clnt.c", 2978, "tls_construct_cke_ecdhe");
  v5 = 0;
  ossl_statem_fatal((SSL_3 *)s, 80, 786691, 0LL);
  return v5;
}
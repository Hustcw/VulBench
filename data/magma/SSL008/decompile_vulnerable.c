int __fastcall tls_construct_cke_dhe(SSL_8 *s, WPACKET *pkt)
{
  EVP_PKEY *peer_tmp;
  EVP_PKEY *pkey;
  int v4;
  size_t v5;
  size_t v6;
  int size;
  size_t v8;
  int v9;
  int v10;
  EVP_PKEY *v11;
  unsigned __int8 *keybytes;
  unsigned __int8 *encoded_pub;

  keybytes = 0LL;
  encoded_pub = 0LL;
  peer_tmp = s->s3.peer_tmp;
  if ( !peer_tmp )
  {
    ERR_new();
    ERR_set_debug("ssl/statem/statem_clnt.c", 2912, "tls_construct_cke_dhe");
    pkey = 0LL;
    ossl_statem_fatal((SSL_3 *)s, 80, 786691, 0LL);
    v4 = 0;
    goto err;
  }
  pkey = ssl_generate_pkey((SSL_12 *)s, s->s3.peer_tmp);
  v4 = 0;
  if ( !ssl_derive((SSL_12 *)s, pkey, peer_tmp, 0) )
  {
err:
    CRYPTO_free(encoded_pub, "ssl/statem/statem_clnt.c", 2964);
    v11 = pkey;
    goto LABEL_14;
  }
  v5 = EVP_PKEY_get1_encoded_public_key(pkey, &encoded_pub);
  if ( v5 )
  {
    v6 = v5;
    size = EVP_PKEY_get_size(pkey);
    v8 = size - v6;
    if ( size != v6 )
    {
      if ( !WPACKET_sub_allocate_bytes__(pkt, size - v6, &keybytes, 2uLL) )
      {
        ERR_new();
        v10 = 2951;
        goto LABEL_12;
      }
      memset(keybytes, 0, v8);
    }
    v9 = WPACKET_sub_memcpy__(pkt, encoded_pub, v6, 2uLL);
    v4 = 1;
    if ( !v9 )
    {
      ERR_new();
      v10 = 2958;
LABEL_12:
      ERR_set_debug("ssl/statem/statem_clnt.c", v10, "tls_construct_cke_dhe");
      v4 = 0;
      ossl_statem_fatal((SSL_3 *)s, 80, 786691, 0LL);
      goto err;
    }
    goto err;
  }
  ERR_new();
  ERR_set_debug("ssl/statem/statem_clnt.c", 2937, "tls_construct_cke_dhe");
  v4 = 0;
  ossl_statem_fatal((SSL_3 *)s, 80, 786691, 0LL);
  v11 = peer_tmp;
LABEL_14:
  EVP_PKEY_free(v11);
  return v4;
}


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


EVP_PKEY *__fastcall ssl_generate_pkey(SSL_12 *s, EVP_PKEY *pm)
{
  EVP_PKEY_CTX *v2;
  EVP_PKEY_CTX_0 *v3;
  EVP_PKEY *pkey;

  pkey = 0LL;
  if ( !pm )
    return 0LL;
  v2 = EVP_PKEY_CTX_new_from_pkey(s->ctx->libctx, pm, s->ctx->propq);
  v3 = (EVP_PKEY_CTX_0 *)v2;
  if ( v2 && EVP_PKEY_keygen_init((EVP_PKEY_CTX_0 *)v2) > 0 && EVP_PKEY_keygen(v3, &pkey) <= 0 )
  {
    EVP_PKEY_free(pkey);
    pkey = 0LL;
  }
  EVP_PKEY_CTX_free((EVP_PKEY_CTX *)v3);
  return pkey;
}

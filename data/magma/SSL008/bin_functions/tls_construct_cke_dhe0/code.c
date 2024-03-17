int __fastcall tls_construct_cke_dhe(SSL_8 *s, WPACKET *pkt)
{
  EVP_PKEY *peer_tmp;
  EVP_PKEY *pkey;
  EVP_PKEY *v4;
  int v5;
  size_t v6;
  size_t v7;
  int size;
  size_t v9;
  int v10;
  int v11;
  int v12;
  EVP_PKEY *v13;
  unsigned __int8 *keybytes;
  unsigned __int8 *encoded_pub;

  keybytes = 0LL;
  encoded_pub = 0LL;
  peer_tmp = s->s3.peer_tmp;
  if ( !peer_tmp )
  {
    ERR_new();
    v12 = 2912;
LABEL_12:
    ERR_set_debug("ssl/statem/statem_clnt.c", v12, "tls_construct_cke_dhe");
    v4 = 0LL;
    ossl_statem_fatal((SSL_3 *)s, 80, 786691, 0LL);
    v5 = 0;
    goto err;
  }
  pkey = ssl_generate_pkey((SSL_12 *)s, s->s3.peer_tmp);
  if ( !pkey )
  {
    ERR_new();
    v12 = 2919;
    goto LABEL_12;
  }
  v4 = pkey;
  v5 = 0;
  if ( ssl_derive((SSL_12 *)s, pkey, peer_tmp, 0) )
  {
    v6 = EVP_PKEY_get1_encoded_public_key(v4, &encoded_pub);
    if ( !v6 )
    {
      ERR_new();
      ERR_set_debug("ssl/statem/statem_clnt.c", 2937, "tls_construct_cke_dhe");
      v5 = 0;
      ossl_statem_fatal((SSL_3 *)s, 80, 786691, 0LL);
      v13 = peer_tmp;
      goto LABEL_14;
    }
    v7 = v6;
    size = EVP_PKEY_get_size(v4);
    v9 = size - v7;
    if ( size != v7 )
    {
      if ( !WPACKET_sub_allocate_bytes__(pkt, size - v7, &keybytes, 2uLL) )
      {
        ERR_new();
        v11 = 2951;
        goto LABEL_17;
      }
      memset(keybytes, 0, v9);
    }
    v10 = WPACKET_sub_memcpy__(pkt, encoded_pub, v7, 2uLL);
    v5 = 1;
    if ( !v10 )
    {
      ERR_new();
      v11 = 2958;
LABEL_17:
      ERR_set_debug("ssl/statem/statem_clnt.c", v11, "tls_construct_cke_dhe");
      v5 = 0;
      ossl_statem_fatal((SSL_3 *)s, 80, 786691, 0LL);
    }
  }
err:
  CRYPTO_free(encoded_pub, "ssl/statem/statem_clnt.c", 2964);
  v13 = v4;
LABEL_14:
  EVP_PKEY_free(v13);
  return v5;
}
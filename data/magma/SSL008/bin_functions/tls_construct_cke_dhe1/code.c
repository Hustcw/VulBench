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
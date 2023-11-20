SSL_TICKET_STATUS __fastcall tls_decrypt_ticket(
        SSL_1 *s,
        const unsigned __int8 *etick,
        size_t eticklen,
        const unsigned __int8 *sess_id,
        size_t sesslen,
        SSL_SESSION **psess)
{
  SSL_CTX *session_ctx;
  const SSL_METHOD_1 *method;
  bool v10;
  int version;
  unsigned int v12;
  SSL_HMAC *v13;
  SSL_HMAC *v14;
  __int64 (__fastcall *ticket_key_evp_cb)(SSL_1 *, unsigned __int8 *, unsigned __int8 *, EVP_CIPHER_CTX *, void *, _QWORD);
  unsigned __int8 *v16;
  unsigned __int8 *v17;
  void *v18;
  EVP_CIPHER_CTX *v19;
  SSL_SESSION *v20;
  SSL_CTX *v21;
  __int64 (__fastcall *decrypt_ticket_cb)(_QWORD, _QWORD, _QWORD, _QWORD, _QWORD, _QWORD);
  size_t v23;
  int v24;
  SSL_SESSION **v25;
  const SSL_METHOD_1 *v26;
  int v27;
  int v28;
  int v30;
  __int64 v31;
  size_t v32;
  size_t v33;
  unsigned __int8 *v34;
  int v35;
  EVP_CIPHER *v36;
  const SSL_METHOD_1 *v37;
  int iv_length;
  size_t v39;
  unsigned __int8 *v40;
  unsigned __int8 *v41;
  __int64 v42;
  unsigned __int8 *v43;
  size_t v44;
  unsigned __int8 tick_hmac[64];
  const unsigned __int8 *sess_ida;
  size_t sesslena;
  __int64 v48;
  const unsigned __int8 *p;
  int declen;
  unsigned __int8 *pp;
  unsigned __int8 *nctick;
  SSL_SESSION **v53;
  size_t keyname_len;
  EVP_CIPHER_CTX *ctx;
  int slen;
  SSL_HMAC *hctx;

  v53 = psess;
  nctick = (unsigned __int8 *)etick;
  if ( eticklen )
  {
    session_ctx = s->session_ctx;
    method = s->method;
    v10 = (method->ssl3_enc->enc_flags & 8) == 0;
    keyname_len = eticklen;
    if ( !v10 || (version = method->version, version < 772) || version == 0x10000 )
    {
      v13 = 0LL;
      v12 = 4;
      if ( eticklen < 0x20 || s->ext.session_secret_cb )
        goto LABEL_16;
    }
    else if ( eticklen < 0x20 )
    {
      v12 = 4;
      v13 = 0LL;
LABEL_16:
      v19 = 0LL;
      v20 = 0LL;
      goto end;
    }
    sess_ida = sess_id;
    v14 = ssl_hmac_new((const SSL_CTX_1 *)session_ctx);
    if ( !v14 )
    {
      v12 = 0;
      v13 = 0LL;
      goto LABEL_16;
    }
    v13 = v14;
    ctx = (EVP_CIPHER_CTX *)EVP_CIPHER_CTX_new();
    if ( !ctx )
    {
      v12 = 0;
      goto LABEL_16;
    }
    sesslena = sesslen;
    hctx = v13;
    ticket_key_evp_cb = (__int64 (__fastcall *)(SSL_1 *, unsigned __int8 *, unsigned __int8 *, EVP_CIPHER_CTX *, void *, _QWORD))session_ctx->ext.ticket_key_evp_cb;
    if ( ticket_key_evp_cb )
    {
      v16 = nctick;
      v17 = nctick + 16;
      v18 = ssl_hmac_get0_EVP_MAC_CTX(hctx);
    }
    else
    {
      ticket_key_evp_cb = (__int64 (__fastcall *)(SSL_1 *, unsigned __int8 *, unsigned __int8 *, EVP_CIPHER_CTX *, void *, _QWORD))session_ctx->ext.ticket_key_cb;
      v16 = nctick;
      if ( !ticket_key_evp_cb )
      {
        if ( _mm_movemask_epi8(
               _mm_cmpeq_epi8(
                 _mm_loadu_si128((const __m128i *)session_ctx->ext.tick_key_name),
                 _mm_loadu_si128((const __m128i *)nctick))) != 0xFFFF )
        {
          v20 = 0LL;
          v12 = 4;
          goto LABEL_67;
        }
        v36 = EVP_CIPHER_fetch(s->ctx->libctx, "AES-256-CBC", s->ctx->propq);
        if ( !v36
          || ssl_hmac_init(hctx, session_ctx->ext.secure, 0x20uLL, "SHA256") <= 0
          || EVP_DecryptInit_ex((EVP_CIPHER_CTX_0 *)ctx, v36, 0LL, session_ctx->ext.secure->tick_aes_key, nctick + 16) <= 0 )
        {
          EVP_CIPHER_free(v36);
          v12 = 1;
          v20 = 0LL;
          goto LABEL_67;
        }
        EVP_CIPHER_free(v36);
        v37 = s->method;
        v19 = ctx;
        v31 = 0LL;
        if ( (v37->ssl3_enc->enc_flags & 8) == 0 )
          v31 = (v37->version > 771) & (unsigned __int8)(v37->version != 0x10000);
LABEL_48:
        v32 = ssl_hmac_size(hctx);
        v12 = 1;
        if ( !v32 )
          goto LABEL_56;
        v33 = v32;
        if ( v32 + EVP_CIPHER_CTX_get_iv_length(v19) + 16 >= keyname_len )
        {
LABEL_53:
          v20 = 0LL;
          v12 = 4;
LABEL_57:
          v13 = hctx;
          goto end;
        }
        keyname_len -= v33;
        if ( ssl_hmac_update(hctx, nctick, keyname_len) <= 0 )
        {
          v20 = 0LL;
          v13 = hctx;
          v19 = ctx;
          goto end;
        }
        v48 = v31;
        v20 = 0LL;
        if ( ssl_hmac_final(hctx, tick_hmac, 0LL, 0x40uLL) > 0 )
        {
          v34 = nctick;
          v35 = bcmp(tick_hmac, &nctick[keyname_len], v33);
          v19 = ctx;
          if ( v35 )
            goto LABEL_53;
          p = &v34[EVP_CIPHER_CTX_get_iv_length(ctx) + 16];
          pp = (unsigned __int8 *)p;
          iv_length = EVP_CIPHER_CTX_get_iv_length(v19);
          v39 = keyname_len - (iv_length + 16);
          v40 = (unsigned __int8 *)CRYPTO_malloc(v39, "ssl/t1_lib.c", 1923);
          v41 = v40;
          keyname_len = v39;
          if ( v40 && EVP_DecryptUpdate((EVP_CIPHER_CTX_0 *)v19, v40, &slen, p, v39) > 0 )
          {
            if ( EVP_DecryptFinal((EVP_CIPHER_CTX_0 *)v19, &v41[slen], &declen) <= 0 )
            {
              CRYPTO_free(v41, "ssl/t1_lib.c", 1931);
            }
            else
            {
              v42 = declen + (__int64)slen;
              slen += declen;
              pp = v41;
              v43 = v41;
              v20 = d2i_SSL_SESSION(0LL, (const unsigned __int8 **)&pp, v42);
              slen += (_DWORD)v43 - (_DWORD)pp;
              CRYPTO_free(v43, "ssl/t1_lib.c", 1940);
              if ( v20 )
              {
                if ( !slen )
                {
                  v44 = sesslena;
                  if ( sesslena )
                  {
                    memcpy(v20->session_id, sess_ida, sesslena);
                    v20->session_id_length = v44;
                  }
                  v12 = (((unsigned int)v48 | 0x600000000uLL) - 1) >> 32;
                  goto LABEL_57;
                }
                SSL_SESSION_free(v20);
              }
              else
              {
                ERR_clear_error();
              }
            }
            goto LABEL_53;
          }
          CRYPTO_free(v41, "ssl/t1_lib.c", 1926);
LABEL_56:
          v20 = 0LL;
          goto LABEL_57;
        }
LABEL_67:
        v13 = hctx;
        v19 = ctx;
        goto end;
      }
      v17 = nctick + 16;
      v18 = ssl_hmac_get0_HMAC_CTX(hctx);
    }
    v19 = ctx;
    v30 = ticket_key_evp_cb(s, v16, v17, ctx, v18, 0LL);
    if ( v30 < 0 )
    {
      v12 = 1;
      goto LABEL_56;
    }
    if ( !v30 )
    {
      v12 = 4;
      goto LABEL_56;
    }
    v31 = v30 == 2;
    goto LABEL_48;
  }
  v12 = 3;
  v13 = 0LL;
  v19 = 0LL;
  v20 = 0LL;
  keyname_len = 0LL;
end:
  EVP_CIPHER_CTX_free((EVP_CIPHER_CTX_0 *)v19);
  ssl_hmac_free(v13);
  if ( v12 - 3 > 3 )
    goto LABEL_33;
  v21 = s->session_ctx;
  decrypt_ticket_cb = (__int64 (__fastcall *)(_QWORD, _QWORD, _QWORD, _QWORD, _QWORD, _QWORD))v21->decrypt_ticket_cb;
  if ( !decrypt_ticket_cb )
    goto LABEL_33;
  v23 = 16LL;
  if ( keyname_len < 0x10 )
    v23 = keyname_len;
  v24 = decrypt_ticket_cb(s, v20, nctick, v23, v12, v21->ticket_cb_data);
  if ( (unsigned int)(v24 - 3) >= 2 )
  {
    if ( v24 == 2 )
    {
      if ( v12 - 3 > 1 )
        v12 = 4;
      SSL_SESSION_free(v20);
      goto LABEL_31;
    }
    if ( v24 == 1 )
    {
      SSL_SESSION_free(v20);
      v12 = 2;
LABEL_31:
      v20 = 0LL;
      goto LABEL_33;
    }
    v12 = 1;
LABEL_33:
    v25 = v53;
    if ( s->ext.session_secret_cb )
      goto LABEL_34;
    goto LABEL_37;
  }
  v25 = v53;
  if ( v12 - 5 <= 1 )
  {
    v12 = 6 - (v24 == 3);
    if ( s->ext.session_secret_cb )
      goto LABEL_34;
  }
  else
  {
    v12 = 1;
    if ( s->ext.session_secret_cb )
    {
LABEL_34:
      v26 = s->method;
      if ( (v26->ssl3_enc->enc_flags & 8) != 0 )
        goto LABEL_40;
      v27 = v26->version;
      if ( v27 < 772 || v27 == 0x10000 )
        goto LABEL_40;
    }
  }
LABEL_37:
  if ( v12 <= 6 )
  {
    v28 = 88;
    if ( _bittest(&v28, v12) )
      s->ext.ticket_expected = 1;
  }
LABEL_40:
  *v25 = v20;
  return v12;
}

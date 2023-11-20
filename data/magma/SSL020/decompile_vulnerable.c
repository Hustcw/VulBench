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
  bool v9;
  int version;
  unsigned int v11;
  SSL_HMAC *v12;
  SSL_HMAC *v13;
  __int64 (__fastcall *ticket_key_evp_cb)(SSL_1 *, unsigned __int8 *, unsigned __int8 *, EVP_CIPHER_CTX *, void *, _QWORD);
  unsigned __int8 *v15;
  unsigned __int8 *v16;
  void *v17;
  EVP_CIPHER_CTX *v18;
  SSL_SESSION *v19;
  SSL_CTX *v20;
  __int64 (__fastcall *decrypt_ticket_cb)(_QWORD, _QWORD, _QWORD, _QWORD, _QWORD, _QWORD);
  size_t v22;
  int v23;
  SSL_SESSION **v24;
  const SSL_METHOD_1 *v25;
  int v26;
  int v27;
  int v29;
  __int64 v30;
  size_t v31;
  const unsigned __int8 *v32;
  size_t v33;
  unsigned __int8 *v34;
  int v35;
  size_t v36;
  unsigned __int8 *v37;
  unsigned __int8 *v38;
  __int64 v39;
  EVP_CIPHER *v40;
  const SSL_METHOD_1 *v41;
  size_t v42;
  unsigned __int8 tick_hmac[64];
  const unsigned __int8 *sess_ida;
  size_t sesslena;
  __int64 v46;
  int declen;
  unsigned __int8 *pp;
  const unsigned __int8 *p;
  unsigned __int8 *nctick;
  SSL_SESSION **v51;
  size_t keyname_len;
  EVP_CIPHER_CTX *ctx;
  int slen;
  SSL_HMAC *hctx;

  v51 = psess;
  nctick = (unsigned __int8 *)etick;
  if ( eticklen )
  {
    session_ctx = s->session_ctx;
    method = s->method;
    v9 = (method->ssl3_enc->enc_flags & 8) == 0;
    keyname_len = eticklen;
    if ( !v9 || (version = method->version, version < 772) || version == 0x10000 )
    {
      v12 = 0LL;
      v11 = 4;
      if ( eticklen < 0x20 || s->ext.session_secret_cb )
        goto LABEL_16;
    }
    else if ( eticklen < 0x20 )
    {
      v11 = 4;
      v12 = 0LL;
LABEL_16:
      v18 = 0LL;
      v19 = 0LL;
      goto end;
    }
    sess_ida = sess_id;
    v13 = ssl_hmac_new((const SSL_CTX_1 *)session_ctx);
    if ( !v13 )
    {
      v11 = 0;
      v12 = 0LL;
      goto LABEL_16;
    }
    v12 = v13;
    ctx = (EVP_CIPHER_CTX *)EVP_CIPHER_CTX_new();
    if ( !ctx )
    {
      v11 = 0;
      goto LABEL_16;
    }
    sesslena = sesslen;
    hctx = v12;
    ticket_key_evp_cb = (__int64 (__fastcall *)(SSL_1 *, unsigned __int8 *, unsigned __int8 *, EVP_CIPHER_CTX *, void *, _QWORD))session_ctx->ext.ticket_key_evp_cb;
    if ( ticket_key_evp_cb )
    {
      v15 = nctick;
      v16 = nctick + 16;
      v17 = ssl_hmac_get0_EVP_MAC_CTX(hctx);
    }
    else
    {
      ticket_key_evp_cb = (__int64 (__fastcall *)(SSL_1 *, unsigned __int8 *, unsigned __int8 *, EVP_CIPHER_CTX *, void *, _QWORD))session_ctx->ext.ticket_key_cb;
      v15 = nctick;
      if ( !ticket_key_evp_cb )
      {
        if ( _mm_movemask_epi8(
               _mm_cmpeq_epi8(
                 _mm_loadu_si128((const __m128i *)session_ctx->ext.tick_key_name),
                 _mm_loadu_si128((const __m128i *)nctick))) != 0xFFFF )
        {
          v19 = 0LL;
          v11 = 4;
          goto LABEL_73;
        }
        v40 = EVP_CIPHER_fetch(s->ctx->libctx, "AES-256-CBC", s->ctx->propq);
        if ( !v40
          || ssl_hmac_init(hctx, session_ctx->ext.secure, 0x20uLL, "SHA256") <= 0
          || EVP_DecryptInit_ex((EVP_CIPHER_CTX_0 *)ctx, v40, 0LL, session_ctx->ext.secure->tick_aes_key, nctick + 16) <= 0 )
        {
          EVP_CIPHER_free(v40);
          v11 = 1;
          v19 = 0LL;
          goto LABEL_73;
        }
        EVP_CIPHER_free(v40);
        v41 = s->method;
        v18 = ctx;
        v30 = 0LL;
        if ( (v41->ssl3_enc->enc_flags & 8) == 0 )
          v30 = (v41->version > 771) & (unsigned __int8)(v41->version != 0x10000);
LABEL_48:
        v31 = ssl_hmac_size(hctx);
        v11 = 1;
        if ( !v31 )
          goto LABEL_53;
        if ( keyname_len < 0x30 )
        {
LABEL_50:
          v19 = 0LL;
          v11 = 4;
LABEL_54:
          v12 = hctx;
          goto end;
        }
        v32 = (const unsigned __int8 *)v31;
        keyname_len -= v31;
        if ( ssl_hmac_update(hctx, nctick, keyname_len) <= 0 )
        {
          v19 = 0LL;
          v12 = hctx;
          v18 = ctx;
          goto end;
        }
        p = v32;
        v46 = v30;
        v19 = 0LL;
        if ( ssl_hmac_final(hctx, tick_hmac, 0LL, 0x40uLL) > 0 )
        {
          v33 = keyname_len;
          v34 = nctick;
          v35 = bcmp(tick_hmac, &nctick[keyname_len], (size_t)p);
          v18 = ctx;
          if ( v35 )
            goto LABEL_50;
          p = &v34[EVP_CIPHER_CTX_get_iv_length(ctx) + 16];
          pp = (unsigned __int8 *)p;
          v36 = v33 - (EVP_CIPHER_CTX_get_iv_length(v18) + 16);
          v37 = (unsigned __int8 *)CRYPTO_malloc(v36, "ssl/t1_lib.c", 1923);
          v38 = v37;
          keyname_len = v36;
          if ( v37 && EVP_DecryptUpdate((EVP_CIPHER_CTX_0 *)v18, v37, &slen, p, v36) > 0 )
          {
            if ( EVP_DecryptFinal((EVP_CIPHER_CTX_0 *)v18, &v38[slen], &declen) <= 0 )
            {
              CRYPTO_free(v38, "ssl/t1_lib.c", 1931);
            }
            else
            {
              v39 = declen + (__int64)slen;
              slen += declen;
              pp = v38;
              v19 = d2i_SSL_SESSION(0LL, (const unsigned __int8 **)&pp, v39);
              slen += (_DWORD)v38 - (_DWORD)pp;
              CRYPTO_free(v38, "ssl/t1_lib.c", 1940);
              if ( v19 )
              {
                if ( !slen )
                {
                  v42 = sesslena;
                  if ( sesslena )
                  {
                    memcpy(v19->session_id, sess_ida, sesslena);
                    v19->session_id_length = v42;
                  }
                  v11 = (((unsigned int)v46 | 0x600000000uLL) - 1) >> 32;
                  goto LABEL_54;
                }
                SSL_SESSION_free(v19);
              }
              else
              {
                ERR_clear_error();
              }
            }
            goto LABEL_50;
          }
          CRYPTO_free(v38, "ssl/t1_lib.c", 1926);
LABEL_53:
          v19 = 0LL;
          goto LABEL_54;
        }
LABEL_73:
        v12 = hctx;
        v18 = ctx;
        goto end;
      }
      v16 = nctick + 16;
      v17 = ssl_hmac_get0_HMAC_CTX(hctx);
    }
    v18 = ctx;
    v29 = ticket_key_evp_cb(s, v15, v16, ctx, v17, 0LL);
    if ( v29 < 0 )
    {
      v11 = 1;
      goto LABEL_53;
    }
    if ( !v29 )
    {
      v11 = 4;
      goto LABEL_53;
    }
    v30 = v29 == 2;
    goto LABEL_48;
  }
  v11 = 3;
  v12 = 0LL;
  v18 = 0LL;
  v19 = 0LL;
  keyname_len = 0LL;
end:
  EVP_CIPHER_CTX_free((EVP_CIPHER_CTX_0 *)v18);
  ssl_hmac_free(v12);
  if ( v11 - 3 > 3 )
    goto LABEL_33;
  v20 = s->session_ctx;
  decrypt_ticket_cb = (__int64 (__fastcall *)(_QWORD, _QWORD, _QWORD, _QWORD, _QWORD, _QWORD))v20->decrypt_ticket_cb;
  if ( !decrypt_ticket_cb )
    goto LABEL_33;
  v22 = 16LL;
  if ( keyname_len < 0x10 )
    v22 = keyname_len;
  v23 = decrypt_ticket_cb(s, v19, nctick, v22, v11, v20->ticket_cb_data);
  if ( (unsigned int)(v23 - 3) >= 2 )
  {
    if ( v23 == 2 )
    {
      if ( v11 - 3 > 1 )
        v11 = 4;
      SSL_SESSION_free(v19);
      goto LABEL_31;
    }
    if ( v23 == 1 )
    {
      SSL_SESSION_free(v19);
      v11 = 2;
LABEL_31:
      v19 = 0LL;
      goto LABEL_33;
    }
    v11 = 1;
LABEL_33:
    v24 = v51;
    if ( s->ext.session_secret_cb )
      goto LABEL_34;
    goto LABEL_37;
  }
  v24 = v51;
  if ( v11 - 5 <= 1 )
  {
    v11 = 6 - (v23 == 3);
    if ( s->ext.session_secret_cb )
      goto LABEL_34;
  }
  else
  {
    v11 = 1;
    if ( s->ext.session_secret_cb )
    {
LABEL_34:
      v25 = s->method;
      if ( (v25->ssl3_enc->enc_flags & 8) != 0 )
        goto LABEL_40;
      v26 = v25->version;
      if ( v26 < 772 || v26 == 0x10000 )
        goto LABEL_40;
    }
  }
LABEL_37:
  if ( v11 <= 6 )
  {
    v27 = 88;
    if ( _bittest(&v27, v11) )
      s->ext.ticket_expected = 1;
  }
LABEL_40:
  *v24 = v19;
  return v11;
}

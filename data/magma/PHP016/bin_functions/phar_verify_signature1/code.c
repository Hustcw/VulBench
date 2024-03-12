int __fastcall phar_verify_signature(
        php_stream *fp,
        size_t end_of_phar,
        uint32_t sig_type,
        char *sig,
        size_t sig_len,
        char *fname,
        char **signature,
        size_t *signature_len,
        char **error)
{
  size_t v12;
  size_t v13;
  ssize_t v14;
  size_t v15;
  const char *v16;
  size_t v17;
  size_t v18;
  ssize_t v19;
  size_t v20;
  size_t v21;
  ssize_t v22;
  size_t v23;
  size_t v24;
  ssize_t v25;
  size_t v26;
  int v27;
  php_stream *v28;
  zend_string *v29;
  zend_string *v30;
  int v31;
  char *v35;
  unsigned __int8 result[16];
  __m128i v37;
  PHP_SHA512_CTX ctx;
  __int64 data[135];

  v12 = end_of_phar;
  v35 = sig;
  php_stream_seek(fp, 0LL, 0);
  switch ( sig_type )
  {
    case 1u:
      PHP_MD5InitArgs((PHP_MD5_CTX *)&ctx, 0LL);
      v13 = 1024LL;
      if ( end_of_phar < 0x400 )
        v13 = end_of_phar;
      v14 = php_stream_read(fp, (char *)data, v13);
      if ( v14 )
      {
        v15 = v14;
        do
        {
          PHP_MD5Update((PHP_MD5_CTX *)&ctx, data, v15);
          v12 -= v15;
          if ( v12 < v13 )
            v13 = v12;
          v15 = php_stream_read(fp, (char *)data, v13);
        }
        while ( v15 );
      }
      PHP_MD5Final(result, (PHP_MD5_CTX *)&ctx);
      if ( _mm_movemask_epi8(_mm_cmpeq_epi8(_mm_loadu_si128((const __m128i *)sig), *(__m128i *)result)) != 0xFFFF )
        goto LABEL_37;
      v16 = (const char *)result;
      v17 = 16LL;
      goto LABEL_52;
    case 2u:
      PHP_SHA1InitArgs((PHP_SHA1_CTX *)&ctx, 0LL);
      v18 = 1024LL;
      if ( end_of_phar < 0x400 )
        v18 = end_of_phar;
      v19 = php_stream_read(fp, (char *)data, v18);
      if ( v19 )
      {
        v20 = v19;
        do
        {
          PHP_SHA1Update((PHP_SHA1_CTX *)&ctx, (const unsigned __int8 *)data, v20);
          v12 -= v20;
          if ( v12 < v18 )
            v18 = v12;
          v20 = php_stream_read(fp, (char *)data, v18);
        }
        while ( v20 );
      }
      PHP_SHA1Final(result, (PHP_SHA1_CTX *)&ctx);
      if ( _mm_movemask_epi8(
             _mm_and_si128(
               _mm_cmpeq_epi8(_mm_loadu_si128((const __m128i *)sig), *(__m128i *)result),
               _mm_cmpeq_epi8(_mm_cvtsi32_si128(*((_DWORD *)sig + 4)), _mm_cvtsi32_si128(v37.m128i_u32[0])))) != 0xFFFF )
        goto LABEL_37;
      v16 = (const char *)result;
      v17 = 20LL;
      goto LABEL_52;
    case 3u:
      PHP_SHA256InitArgs((PHP_SHA256_CTX *)&ctx, 0LL);
      v21 = 1024LL;
      if ( end_of_phar < 0x400 )
        v21 = end_of_phar;
      v22 = php_stream_read(fp, (char *)data, v21);
      if ( v22 )
      {
        v23 = v22;
        do
        {
          PHP_SHA256Update((PHP_SHA256_CTX *)&ctx, (const unsigned __int8 *)data, v23);
          v12 -= v23;
          if ( v12 < v21 )
            v21 = v12;
          v23 = php_stream_read(fp, (char *)data, v21);
        }
        while ( v23 );
      }
      PHP_SHA256Final(result, (PHP_SHA256_CTX *)&ctx);
      if ( _mm_movemask_epi8(
             _mm_and_si128(
               _mm_cmpeq_epi8(_mm_loadu_si128((const __m128i *)sig), *(__m128i *)result),
               _mm_cmpeq_epi8(_mm_loadu_si128((const __m128i *)sig + 1), v37))) != 0xFFFF )
        goto LABEL_37;
      v16 = (const char *)result;
      v17 = 32LL;
      goto LABEL_52;
    case 4u:
      PHP_SHA512InitArgs(&ctx, 0LL);
      v24 = 1024LL;
      if ( end_of_phar < 0x400 )
        v24 = end_of_phar;
      v25 = php_stream_read(fp, (char *)data, v24);
      if ( v25 )
      {
        v26 = v25;
        do
        {
          PHP_SHA512Update(&ctx, (const unsigned __int8 *)data, v26);
          v12 -= v26;
          if ( v12 < v24 )
            v24 = v12;
          v26 = php_stream_read(fp, (char *)data, v24);
        }
        while ( v26 );
      }
      PHP_SHA512Final(result, &ctx);
      if ( !bcmp(result, sig, 0x40uLL) )
      {
        v16 = (const char *)result;
        v17 = 64LL;
        goto LABEL_52;
      }
LABEL_37:
      if ( error )
        zend_spprintf(error, 0LL, "broken signature");
      return -1;
    case 0x10u:
      if ( !zend_hash_str_find(&module_registry, "openssl", 7uLL) )
      {
        if ( error )
          zend_spprintf(error, 0LL, "openssl not loaded");
        return -1;
      }
      zend_spprintf((char **)&ctx, 0LL, "%s.pubkey", fname);
      v28 = php_stream_open_wrapper_ex((const char *)ctx.state[0], "rb", 0, 0LL, 0LL);
      efree((void *)ctx.state[0]);
      if ( !v28 )
        goto LABEL_57;
      v29 = php_stream_copy_to_mem(v28, 0xFFFFFFFFFFFFFFFFLL, 0);
      if ( !v29 || (v30 = v29, !v29->len) )
      {
        php_stream_free(v28, 3);
LABEL_57:
        if ( error )
          zend_spprintf(error, 0LL, "openssl public key could not be read");
        return -1;
      }
      php_stream_free(v28, 3);
      data[0] = sig_len;
      v31 = phar_call_openssl_signverify(0, fp, end_of_phar, v30->val, v30->len, &v35, (size_t *)data);
      if ( (v30->gc.u.type_info & 0x40) == 0 && v30->gc.refcount-- == 1 )
        efree(v30);
      if ( v31 == -1 )
      {
        if ( error )
          zend_spprintf(error, 0LL, "openssl signature could not be verified");
        return -1;
      }
      v17 = data[0];
      v16 = v35;
LABEL_52:
      *signature_len = phar_hex_str(v16, v17, signature);
      return 0;
    default:
      v27 = -1;
      if ( error )
        zend_spprintf(error, 0LL, "broken or unsupported signature");
      return v27;
  }
}

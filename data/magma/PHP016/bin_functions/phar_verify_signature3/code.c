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
  int v24;
  php_stream *v25;
  zend_string *v26;
  zend_string *v27;
  int v28;
  size_t v30;
  ssize_t v31;
  size_t v32;
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
      if ( sig_len <= 0xF )
        goto LABEL_33;
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
        goto LABEL_54;
      v16 = (const char *)result;
      v17 = 16LL;
      goto LABEL_64;
    case 2u:
      if ( sig_len <= 0x13 )
        goto LABEL_33;
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
        goto LABEL_54;
      v16 = (const char *)result;
      v17 = 20LL;
      goto LABEL_64;
    case 3u:
      if ( sig_len <= 0x1F )
        goto LABEL_33;
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
        goto LABEL_54;
      v16 = (const char *)result;
      v17 = 32LL;
      goto LABEL_64;
    case 4u:
      if ( sig_len > 0x3F )
      {
        PHP_SHA512InitArgs(&ctx, 0LL);
        v30 = 1024LL;
        if ( end_of_phar < 0x400 )
          v30 = end_of_phar;
        v31 = php_stream_read(fp, (char *)data, v30);
        if ( v31 )
        {
          v32 = v31;
          do
          {
            PHP_SHA512Update(&ctx, (const unsigned __int8 *)data, v32);
            v12 -= v32;
            if ( v12 < v30 )
              v30 = v12;
            v32 = php_stream_read(fp, (char *)data, v30);
          }
          while ( v32 );
        }
        PHP_SHA512Final(result, &ctx);
        if ( !bcmp(result, sig, 0x40uLL) )
        {
          v16 = (const char *)result;
          v17 = 64LL;
          goto LABEL_64;
        }
LABEL_54:
        if ( error )
          zend_spprintf(error, 0LL, "broken signature");
      }
      else
      {
LABEL_33:
        if ( error )
          zend_spprintf(error, 0LL, "broken signature");
      }
      return -1;
    case 0x10u:
      if ( !zend_hash_str_find(&module_registry, "openssl", 7uLL) )
      {
        if ( error )
          zend_spprintf(error, 0LL, "openssl not loaded");
        return -1;
      }
      zend_spprintf((char **)&ctx, 0LL, "%s.pubkey", fname);
      v25 = php_stream_open_wrapper_ex((const char *)ctx.state[0], "rb", 0, 0LL, 0LL);
      efree((void *)ctx.state[0]);
      if ( !v25 )
        goto LABEL_59;
      v26 = php_stream_copy_to_mem(v25, 0xFFFFFFFFFFFFFFFFLL, 0);
      if ( !v26 || (v27 = v26, !v26->len) )
      {
        php_stream_free(v25, 3);
LABEL_59:
        if ( error )
          zend_spprintf(error, 0LL, "openssl public key could not be read");
        return -1;
      }
      php_stream_free(v25, 3);
      data[0] = sig_len;
      v28 = phar_call_openssl_signverify(0, fp, end_of_phar, v27->val, v27->len, &v35, (size_t *)data);
      if ( (v27->gc.u.type_info & 0x40) == 0 && v27->gc.refcount-- == 1 )
        efree(v27);
      if ( v28 == -1 )
      {
        if ( error )
          zend_spprintf(error, 0LL, "openssl signature could not be verified");
        return -1;
      }
      v17 = data[0];
      v16 = v35;
LABEL_64:
      *signature_len = phar_hex_str(v16, v17, signature);
      return 0;
    default:
      v24 = -1;
      if ( error )
        zend_spprintf(error, 0LL, "broken or unsupported signature");
      return v24;
  }
}

__int64 __fastcall phar_parse_pharfile(
        php_stream *fp,
        char *fname,
        size_t fname_len,
        char *alias,
        size_t alias_len,
        zend_long halt_offset,
        phar_archive_data **pphar,
        uint32_t compression,
        char **error)
{
  zend_off_t v9;
  int v10;
  int v11;
  zend_off_t v12;
  size_t v13;
  char *v15;
  char *v16;
  unsigned int v17;
  unsigned int v18;
  size_t v19;
  char *v20;
  size_t v21;
  size_t v22;
  size_t v23;
  size_t v24;
  char buf[4];
  void *ptr;
  char *v27;
  size_t v28;
  size_t size;
  size_t v30;
  char sig[120];

  v9 = halt_offset;
  ptr = 0LL;
  if ( pphar )
    *pphar = 0LL;
  if ( error )
    *error = 0LL;
  if ( php_stream_seek(fp, halt_offset, 0) == -1 )
    goto LABEL_29;
  if ( php_stream_read(fp, buf, 3uLL) != 3 )
    goto LABEL_16;
  if ( (buf[0] == 32 || buf[0] == 10) && buf[1] == 63 && buf[2] == 62 )
  {
    v10 = php_stream_getc(fp);
    if ( v10 != -1 )
    {
      v10 = (unsigned __int8)v10;
      if ( (unsigned __int8)v10 != 13 )
      {
        v12 = v9 + 3;
        goto LABEL_21;
      }
      v11 = php_stream_getc(fp);
      if ( v11 != -1 && (unsigned __int8)v11 == 10 )
      {
        v12 = v9 + 4;
        v10 = 10;
LABEL_21:
        v9 = v12 + (v10 == 10);
        goto LABEL_22;
      }
    }
LABEL_16:
    if ( fp )
      php_stream_free(fp, 3);
    if ( error )
      zend_spprintf(error, 0LL, "internal corruption of phar \"%s\" (truncated manifest at stub end)", fname);
    return 0xFFFFFFFFLL;
  }
LABEL_22:
  if ( php_stream_seek(fp, v9, 0) == -1 )
  {
LABEL_29:
    if ( fp )
      php_stream_free(fp, 3);
    if ( error )
      zend_spprintf(error, 0LL, "cannot seek to __HALT_COMPILER(); location in phar \"%s\"", fname);
    return 0xFFFFFFFFLL;
  }
  if ( php_stream_read(fp, buf, 4uLL) != 4 )
  {
    if ( fp )
      php_stream_free(fp, 3);
    if ( error )
      zend_spprintf(error, 0LL, "internal corruption of phar \"%s\" (truncated manifest at manifest length)", fname);
    return 0xFFFFFFFFLL;
  }
  v13 = *(unsigned int *)buf;
  if ( *(unsigned int *)buf >= 0x6400001uLL )
  {
    if ( fp )
      php_stream_free(fp, 3);
    if ( error )
      zend_spprintf(error, 0LL, "manifest cannot be larger than 100 MB in phar \"%s\"", fname);
    return 0xFFFFFFFFLL;
  }
  v15 = (char *)emalloc(*(unsigned int *)buf);
  v16 = v15;
  if ( (unsigned int)v13 < 0xA || php_stream_read(fp, v15, v13) != v13 )
  {
    efree(v16);
    if ( ptr )
    {
      if ( phar_globals.persist )
      {
        free(ptr);
        if ( !fp )
        {
LABEL_51:
          if ( error )
            zend_spprintf(error, 0LL, "internal corruption of phar \"%s\" (truncated manifest header)", fname);
          return 0xFFFFFFFFLL;
        }
LABEL_50:
        php_stream_free(fp, 3);
        goto LABEL_51;
      }
      efree(ptr);
    }
    if ( !fp )
      goto LABEL_51;
    goto LABEL_50;
  }
  if ( !*(_DWORD *)v16 )
  {
    efree(v16);
    if ( ptr )
    {
      if ( phar_globals.persist )
      {
        free(ptr);
        if ( !fp )
        {
LABEL_73:
          if ( error )
            zend_spprintf(
              error,
              0LL,
              "in phar \"%s\", manifest claims to have zero entries.  Phars must have at least 1 entry",
              fname);
          return 0xFFFFFFFFLL;
        }
LABEL_72:
        php_stream_free(fp, 3);
        goto LABEL_73;
      }
      efree(ptr);
    }
    if ( !fp )
      goto LABEL_73;
    goto LABEL_72;
  }
  v17 = (unsigned __int8)v16[4];
  if ( v17 <= 0xF )
  {
    v18 = (unsigned __int8)v16[5];
    efree(v16);
    php_stream_free(fp, 3);
    if ( error )
      zend_spprintf(
        error,
        0LL,
        "phar \"%s\" is API version %1.u.%1.u.%1.u, and cannot be processed",
        fname,
        v17 >> 4,
        v17 & 0xF,
        v18 >> 4);
    return 0xFFFFFFFFLL;
  }
  if ( ((*(_DWORD *)(v16 + 6) | compression) & 0x10000) == 0 )
  {
    if ( phar_globals.require_hash )
    {
      efree(v16);
      php_stream_free(fp, 3);
      if ( error )
        zend_spprintf(error, 0LL, "phar \"%s\" does not have a signature", fname);
      return 0xFFFFFFFFLL;
    }
    v28 = 0LL;
LABEL_76:
    efree(v16);
    if ( (unsigned int)v13 <= 0xD )
    {
      if ( ptr )
      {
        if ( phar_globals.persist )
        {
          free(ptr);
          if ( !fp )
          {
LABEL_88:
            if ( error )
              zend_spprintf(error, 0LL, "internal corruption of phar \"%s\" (buffer overrun)", fname);
            return 0xFFFFFFFFLL;
          }
LABEL_87:
          php_stream_free(fp, 3);
          goto LABEL_88;
        }
        efree(ptr);
      }
      if ( !fp )
        goto LABEL_88;
      goto LABEL_87;
    }
    if ( ptr )
    {
      if ( phar_globals.persist )
      {
        free(ptr);
        if ( !fp )
        {
LABEL_93:
          if ( error )
            zend_spprintf(
              error,
              0LL,
              "internal corruption of phar \"%s\" (too many manifest entries for size of manifest)",
              fname);
          return 0xFFFFFFFFLL;
        }
LABEL_92:
        php_stream_free(fp, 3);
        goto LABEL_93;
      }
      efree(ptr);
    }
    if ( !fp )
      goto LABEL_93;
    goto LABEL_92;
  }
  if ( php_stream_seek(fp, -8LL, 2) != -1
    && php_stream_tell(fp) >= 20
    && php_stream_read(fp, (char *)&size, 8uLL) == 8
    && HIDWORD(size) == 1112359495 )
  {
    switch ( (int)size )
    {
      case 1:
        php_stream_seek(fp, -24LL, 2);
        v19 = php_stream_tell(fp);
        if ( php_stream_read(fp, sig, 0x10uLL) != 16 )
          goto LABEL_108;
        if ( phar_verify_signature(fp, v19, 1u, sig, 0x10uLL, fname, (char **)&ptr, &v28, error) != -1 )
          goto LABEL_76;
        efree(v16);
        php_stream_free(fp, 3);
        if ( error )
        {
          v20 = *error;
          zend_spprintf(error, 0LL, "phar \"%s\" MD5 signature could not be verified: %s", fname, *error);
          goto LABEL_107;
        }
        break;
      case 2:
        php_stream_seek(fp, -28LL, 2);
        v21 = php_stream_tell(fp);
        if ( php_stream_read(fp, sig, 0x14uLL) != 20 )
          goto LABEL_108;
        if ( phar_verify_signature(fp, v21, 2u, sig, 0x14uLL, fname, (char **)&ptr, &v28, error) != -1 )
          goto LABEL_76;
        efree(v16);
        php_stream_free(fp, 3);
        if ( error )
        {
          v20 = *error;
          zend_spprintf(error, 0LL, "phar \"%s\" SHA1 signature could not be verified: %s", fname, *error);
          goto LABEL_107;
        }
        break;
      case 3:
        php_stream_seek(fp, -40LL, 2);
        v22 = php_stream_tell(fp);
        if ( php_stream_read(fp, sig, 0x20uLL) != 32 )
          goto LABEL_108;
        if ( phar_verify_signature(fp, v22, 3u, sig, 0x20uLL, fname, (char **)&ptr, &v28, error) != -1 )
          goto LABEL_76;
        efree(v16);
        php_stream_free(fp, 3);
        if ( error )
        {
          v20 = *error;
          zend_spprintf(error, 0LL, "phar \"%s\" SHA256 signature could not be verified: %s", fname, *error);
          goto LABEL_107;
        }
        break;
      case 4:
        php_stream_seek(fp, -72LL, 2);
        v23 = php_stream_tell(fp);
        if ( php_stream_read(fp, sig, 0x40uLL) != 64 )
          goto LABEL_108;
        if ( phar_verify_signature(fp, v23, 4u, sig, 0x40uLL, fname, (char **)&ptr, &v28, error) != -1 )
          goto LABEL_76;
        efree(v16);
        php_stream_free(fp, 3);
        if ( error )
        {
          v20 = *error;
          zend_spprintf(error, 0LL, "phar \"%s\" SHA512 signature could not be verified: %s", fname, *error);
          goto LABEL_107;
        }
        break;
      case 16:
        if ( php_stream_seek(fp, -12LL, 1) == -1 || php_stream_read(fp, (char *)&size, 4uLL) != 4 )
        {
          efree(v16);
          php_stream_free(fp, 3);
          if ( error )
            zend_spprintf(error, 0LL, "phar \"%s\" openssl signature length could not be read", fname);
        }
        else
        {
          v24 = (unsigned int)size;
          v27 = (char *)emalloc((unsigned int)size);
          if ( php_stream_seek(fp, -(__int64)(unsigned int)(v24 + 4), 1) != -1
            && (v30 = php_stream_tell(fp)) != 0
            && php_stream_read(fp, v27, v24) == v24 )
          {
            if ( phar_verify_signature(fp, v30, 0x10u, v27, v24, fname, (char **)&ptr, &v28, error) != -1 )
            {
              efree(v27);
              goto LABEL_76;
            }
            efree(v16);
            efree(v27);
            php_stream_free(fp, 3);
            if ( error )
            {
              v20 = *error;
              zend_spprintf(error, 0LL, "phar \"%s\" openssl signature could not be verified: %s", fname, *error);
LABEL_107:
              efree(v20);
            }
          }
          else
          {
            efree(v16);
            efree(v27);
            php_stream_free(fp, 3);
            if ( error )
              zend_spprintf(error, 0LL, "phar \"%s\" openssl signature could not be read", fname);
          }
        }
        break;
      default:
        efree(v16);
        php_stream_free(fp, 3);
        if ( error )
          zend_spprintf(error, 0LL, "phar \"%s\" has a broken or unsupported signature", fname);
        break;
    }
  }
  else
  {
LABEL_108:
    efree(v16);
    php_stream_free(fp, 3);
    if ( error )
      zend_spprintf(error, 0LL, "phar \"%s\" has a broken signature", fname);
  }
  return 0xFFFFFFFFLL;
}

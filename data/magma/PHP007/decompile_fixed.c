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
  int v13;
  int v14;
  zend_off_t v15;
  unsigned int v16;
  char *v18;
  char *v19;
  ssize_t v20;
  size_t v21;
  __int64 v22;
  unsigned int v23;
  __int64 v24;
  unsigned int v25;
  unsigned int v26;
  unsigned int v27;
  uint32_t v28;
  int v29;
  char *v30;
  char *v31;
  BOOL v32;
  char *v33;
  _WORD *v34;
  char persist;
  int v36;
  unsigned int *v37;
  unsigned int v38;
  size_t v39;
  int v40;
  char *v41;
  uint32_t *v42;
  phar_archive_data *v43;
  uint32_t v44;
  unsigned int v45;
  uint32_t v46;
  uint32_t v47;
  int v48;
  size_t v49;
  size_t filename_len;
  char *v51;
  int v52;
  char *v53;
  unsigned int v54;
  unsigned int v55;
  uint32_t v56;
  unsigned int *v57;
  unsigned __int64 v58;
  const char *v59;
  int v60;
  zend_string *inited;
  size_t v62;
  zval *v63;
  void *v64;
  union {uint32_t type_info;} v65;
  bool v66;
  phar_archive_data *v67;
  phar_archive_data *v68;
  phar_archive_data *v69;
  phar_archive_data *v70;
  phar_archive_data *v71;
  const char *v72;
  char *v73;
  char *v74;
  char *v75;
  char *v76;
  char *v77;
  char *v78;
  size_t v79;
  int v80;
  __int16 v81;
  phar_archive_data **v82;
  zend_string *v83;
  union {uint32_t type_info;} v84;
  const char *v85;
  size_t v86;
  zend_string *v87;
  union {uint32_t type_info;} v88;
  size_t v90;
  zend_off_t v91;
  size_t v92;
  uint32_t v93;
  int v94;
  int v95;
  uint32_t v96;
  char *v97;
  zend_off_t sig_len;
  char *sig_lena;
  zend_off_t sig_lenb;
  zend_off_t sig_lenc;
  zend_off_t sig_lend;
  size_t sig_lene;
  size_t sig_lenf;
  size_t sig_leng;
  size_t sig_lenh;
  void *ptr;
  unsigned int v108;
  size_t size;
  unsigned int v110;
  uint32_t nSize[2];
  int v112;
  char *v113;
  char *s2;
  char buf[4];
  size_t length;
  __int64 v117;
  BOOL v118;
  size_t v119;
  zval v120;
  uint32_t zip_metadata_len[2];
  BOOL v122;
  size_t n;
  uint32_t v124;
  phar_entry_info sig;
  size_t v126;
  void *src;
  HashTable *ht;
  char *v129;
  __int64 compressed_filesize;
  unsigned __int64 v131;

  v9 = halt_offset;
  length = fname_len;
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
    v13 = php_stream_getc(fp);
    if ( v13 != -1 )
    {
      v13 = (unsigned __int8)v13;
      if ( (unsigned __int8)v13 != 13 )
      {
        v15 = v9 + 3;
        goto LABEL_21;
      }
      v14 = php_stream_getc(fp);
      if ( v14 != -1 && (unsigned __int8)v14 == 10 )
      {
        v15 = v9 + 4;
        v13 = 10;
LABEL_21:
        v9 = v15 + (v13 == 10);
        goto LABEL_22;
      }
    }
LABEL_16:
    if ( fp )
      php_stream_free(fp, 3);
    v16 = -1;
    if ( error )
      zend_spprintf(error, 0LL, "internal corruption of phar \"%s\" (truncated manifest at stub end)", fname);
    return v16;
  }
LABEL_22:
  if ( php_stream_seek(fp, v9, 0) == -1 )
  {
LABEL_29:
    if ( fp )
      php_stream_free(fp, 3);
    v16 = -1;
    if ( error )
      zend_spprintf(error, 0LL, "cannot seek to __HALT_COMPILER(); location in phar \"%s\"", fname);
    return v16;
  }
  if ( php_stream_read(fp, buf, 4uLL) != 4 )
  {
    if ( fp )
      php_stream_free(fp, 3);
    v16 = -1;
    if ( error )
      zend_spprintf(error, 0LL, "internal corruption of phar \"%s\" (truncated manifest at manifest length)", fname);
    return v16;
  }
  if ( *(unsigned int *)buf >= 0x6400001uLL )
  {
    if ( fp )
      php_stream_free(fp, 3);
    v16 = -1;
    if ( error )
      zend_spprintf(error, 0LL, "manifest cannot be larger than 100 MB in phar \"%s\"", fname);
    return v16;
  }
  size = *(unsigned int *)buf;
  v18 = (char *)emalloc(*(unsigned int *)buf);
  v19 = v18;
  if ( (unsigned int)size < 0x12
    || (v97 = v18, v20 = php_stream_read(fp, v18, size), v21 = size, v19 = v97, v20 != size) )
  {
LABEL_72:
    efree(v19);
    goto LABEL_73;
  }
  v22 = *(unsigned int *)v97;
  if ( !(_DWORD)v22 )
  {
    efree(v97);
    if ( ptr )
    {
      if ( phar_globals.persist )
      {
        free(ptr);
        if ( !fp )
        {
LABEL_63:
          v16 = -1;
          if ( error )
            zend_spprintf(
              error,
              0LL,
              "in phar \"%s\", manifest claims to have zero entries.  Phars must have at least 1 entry",
              fname);
          return v16;
        }
LABEL_62:
        php_stream_free(fp, 3);
        goto LABEL_63;
      }
      efree(ptr);
    }
    if ( !fp )
      goto LABEL_63;
    goto LABEL_62;
  }
  v23 = (unsigned __int8)v97[4];
  v24 = (unsigned __int8)v97[5];
  v25 = (v23 << 8) | v97[5] & 0xF0;
  if ( v25 <= 0xFFF )
  {
    v26 = (unsigned __int8)v97[4];
    v27 = (unsigned __int8)v97[5];
    efree(v97);
    php_stream_free(fp, 3);
    v16 = -1;
    if ( error )
      zend_spprintf(
        error,
        0LL,
        "phar \"%s\" is API version %1.u.%1.u.%1.u, and cannot be processed",
        fname,
        v26 >> 4,
        v26 & 0xF,
        v27 >> 4);
    return v16;
  }
  v28 = compression | *(_DWORD *)(v97 + 6) & 0xFF0F0FFF;
  if ( compression & 0x10000 | *(_DWORD *)(v97 + 6) & 0x10000 )
  {
    v108 = ((unsigned __int8)v97[4] << 8) | v97[5] & 0xF0;
    *(_QWORD *)nSize = v22;
    v110 = v23;
    v117 = v24;
    if ( php_stream_seek(fp, -8LL, 2) == -1
      || php_stream_tell(fp) < 20
      || php_stream_read(fp, (char *)&v120, 8uLL) != 8
      || v120.value.ww.w2 != 1112359495 )
    {
LABEL_113:
      efree(v97);
      php_stream_free(fp, 3);
      if ( error )
        zend_spprintf(error, 0LL, "phar \"%s\" has a broken signature", fname);
      return (unsigned int)-1;
    }
    switch ( v120.value.ww.w1 )
    {
      case 1u:
        php_stream_seek(fp, -24LL, 2);
        sig_len = php_stream_tell(fp);
        if ( php_stream_read(fp, (char *)&sig, 0x10uLL) != 16 )
          goto LABEL_113;
        if ( phar_verify_signature(fp, sig_len, 1u, (char *)&sig, 0x10uLL, fname, (char **)&ptr, &v119, error) != -1 )
        {
          v19 = v97;
          v24 = v117;
          v23 = v110;
          v22 = *(_QWORD *)nSize;
          v25 = v108;
          v112 = 1;
          goto LABEL_112;
        }
        efree(v97);
        php_stream_free(fp, 3);
        if ( !error )
          return (unsigned int)-1;
        v77 = *error;
        zend_spprintf(error, 0LL, "phar \"%s\" MD5 signature could not be verified: %s", fname, *error);
        goto LABEL_233;
      case 2u:
        php_stream_seek(fp, -28LL, 2);
        sig_lenb = php_stream_tell(fp);
        if ( php_stream_read(fp, (char *)&sig, 0x14uLL) != 20 )
          goto LABEL_113;
        if ( phar_verify_signature(fp, sig_lenb, 2u, (char *)&sig, 0x14uLL, fname, (char **)&ptr, &v119, error) != -1 )
        {
          v19 = v97;
          v24 = v117;
          v23 = v110;
          v22 = *(_QWORD *)nSize;
          v25 = v108;
          v112 = 2;
          goto LABEL_112;
        }
        efree(v97);
        php_stream_free(fp, 3);
        if ( !error )
          return (unsigned int)-1;
        v77 = *error;
        zend_spprintf(error, 0LL, "phar \"%s\" SHA1 signature could not be verified: %s", fname, *error);
        goto LABEL_233;
      case 3u:
        php_stream_seek(fp, -40LL, 2);
        sig_lenc = php_stream_tell(fp);
        if ( php_stream_read(fp, (char *)&sig, 0x20uLL) != 32 )
          goto LABEL_113;
        if ( phar_verify_signature(fp, sig_lenc, 3u, (char *)&sig, 0x20uLL, fname, (char **)&ptr, &v119, error) != -1 )
        {
          v19 = v97;
          v24 = v117;
          v23 = v110;
          v22 = *(_QWORD *)nSize;
          v25 = v108;
          v112 = 3;
          goto LABEL_112;
        }
        efree(v97);
        php_stream_free(fp, 3);
        if ( !error )
          return (unsigned int)-1;
        v77 = *error;
        zend_spprintf(error, 0LL, "phar \"%s\" SHA256 signature could not be verified: %s", fname, *error);
        goto LABEL_233;
      case 4u:
        php_stream_seek(fp, -72LL, 2);
        sig_lend = php_stream_tell(fp);
        if ( php_stream_read(fp, (char *)&sig, 0x40uLL) != 64 )
          goto LABEL_113;
        if ( phar_verify_signature(fp, sig_lend, 4u, (char *)&sig, 0x40uLL, fname, (char **)&ptr, &v119, error) != -1 )
        {
          v19 = v97;
          v24 = v117;
          v23 = v110;
          v22 = *(_QWORD *)nSize;
          v25 = v108;
          v112 = 4;
          goto LABEL_112;
        }
        efree(v97);
        php_stream_free(fp, 3);
        if ( !error )
          return (unsigned int)-1;
        v77 = *error;
        zend_spprintf(error, 0LL, "phar \"%s\" SHA512 signature could not be verified: %s", fname, *error);
        goto LABEL_233;
      case 0x10u:
        if ( php_stream_seek(fp, -12LL, 1) == -1 || php_stream_read(fp, (char *)&v120, 4uLL) != 4 )
        {
          efree(v97);
          php_stream_free(fp, 3);
          if ( error )
            zend_spprintf(error, 0LL, "phar \"%s\" openssl signature length could not be read", fname);
          return (unsigned int)-1;
        }
        sig_lene = v120.value.ww.w1;
        v113 = (char *)emalloc(v120.value.ww.w1);
        if ( php_stream_seek(fp, -(__int64)(unsigned int)(sig_lene + 4), 1) == -1
          || (v91 = php_stream_tell(fp)) == 0
          || php_stream_read(fp, v113, sig_lene) != sig_lene )
        {
          efree(v97);
          efree(v113);
          php_stream_free(fp, 3);
          if ( error )
            zend_spprintf(error, 0LL, "phar \"%s\" openssl signature could not be read", fname);
          return (unsigned int)-1;
        }
        if ( phar_verify_signature(fp, v91, 0x10u, v113, sig_lene, fname, (char **)&ptr, &v119, error) != -1 )
        {
          efree(v113);
          v19 = v97;
          v24 = v117;
          v23 = v110;
          v22 = *(_QWORD *)nSize;
          v25 = v108;
          v112 = 16;
LABEL_112:
          v21 = size;
          goto LABEL_66;
        }
        efree(v97);
        efree(v113);
        php_stream_free(fp, 3);
        if ( !error )
          return (unsigned int)-1;
        v77 = *error;
        zend_spprintf(error, 0LL, "phar \"%s\" openssl signature could not be verified: %s", fname, *error);
LABEL_233:
        v31 = v77;
        break;
      default:
        efree(v97);
        php_stream_free(fp, 3);
        if ( error )
          zend_spprintf(error, 0LL, "phar \"%s\" has a broken or unsupported signature", fname);
        return (unsigned int)-1;
    }
LABEL_234:
    efree(v31);
    return (unsigned int)-1;
  }
  if ( phar_globals.require_hash )
  {
    efree(v97);
    php_stream_free(fp, 3);
    v16 = -1;
    if ( error )
      zend_spprintf(error, 0LL, "phar \"%s\" does not have a signature", fname);
    return v16;
  }
  v119 = 0LL;
  v112 = 0;
LABEL_66:
  v90 = *(unsigned int *)(v19 + 10);
  v113 = &v19[v21];
  sig_lena = &v19[v90 + 14];
  if ( sig_lena > &v19[v21] )
  {
    efree(v19);
    if ( ptr )
    {
      if ( phar_globals.persist )
      {
        free(ptr);
        if ( !fp )
        {
LABEL_95:
          v16 = -1;
          if ( error )
            zend_spprintf(error, 0LL, "internal corruption of phar \"%s\" (buffer overrun)", fname);
          return v16;
        }
LABEL_94:
        php_stream_free(fp, 3);
        goto LABEL_95;
      }
      efree(ptr);
    }
    if ( !fp )
      goto LABEL_95;
    goto LABEL_94;
  }
  v29 = v90;
  if ( (unsigned int)v21 < (int)v90 + 18 )
    goto LABEL_72;
  v30 = v19 + 14;
  v117 = v24;
  v110 = v23;
  v108 = v25;
  v93 = v28;
  if ( (_DWORD)v90 )
  {
    s2 = v19 + 14;
    v118 = 0;
    v122 = 1;
    if ( alias )
    {
      *(_QWORD *)nSize = v22;
      if ( alias_len )
      {
        if ( v90 != alias_len || strncmp(alias, s2, alias_len) )
        {
          php_stream_free(fp, 3);
          if ( ptr )
            efree(ptr);
          if ( error )
            zend_spprintf(
              error,
              0LL,
              "cannot load phar \"%s\" with implicit alias \"%.*s\" under different alias \"%s\"",
              fname,
              v90,
              s2,
              alias);
          v31 = v97;
          goto LABEL_234;
        }
        v118 = 0;
        v22 = *(_QWORD *)nSize;
        LODWORD(v21) = size;
        v29 = v90;
      }
      else
      {
        alias_len = v90;
        v22 = *(_QWORD *)nSize;
        LODWORD(v21) = size;
      }
    }
    else
    {
      alias_len = v90;
    }
  }
  else
  {
    v32 = alias_len != 0 && alias != 0LL;
    sig_lena = v30;
    v33 = 0LL;
    if ( v32 )
      v33 = alias;
    else
      alias_len = 0LL;
    v122 = v32;
    v118 = v32;
    s2 = v33;
  }
  if ( (unsigned int)v22 > ((int)v21 - v29 - 18) / 0x15u )
  {
    efree(v97);
    if ( ptr )
    {
      if ( phar_globals.persist )
      {
        free(ptr);
        if ( !fp )
        {
LABEL_199:
          v16 = -1;
          if ( error )
            zend_spprintf(
              error,
              0LL,
              "internal corruption of phar \"%s\" (too many manifest entries for size of manifest)",
              fname);
          return v16;
        }
LABEL_198:
        php_stream_free(fp, 3);
        goto LABEL_199;
      }
      efree(ptr);
    }
    if ( !fp )
      goto LABEL_199;
    goto LABEL_198;
  }
  *(_QWORD *)nSize = v22;
  if ( phar_globals.persist )
    v34 = _zend_calloc(1uLL, 0x148uLL);
  else
    v34 = ecalloc(1uLL, 0x148uLL);
  persist = phar_globals.persist;
  v36 = phar_globals.persist & 1;
  v92 = (size_t)v34;
  v34[162] = ((phar_globals.persist & 1) << 8) | v34[162] & 0xFEFF;
  v37 = (unsigned int *)(sig_lena + 4);
  if ( sig_lena + 4 > v113 )
    goto LABEL_332;
  v38 = *(_DWORD *)sig_lena;
  if ( (persist & 1) == 0 || v38 )
  {
    sig_lenf = (size_t)(sig_lena + 4);
    goto LABEL_142;
  }
  sig_lenf = (size_t)(sig_lena + 8);
  if ( sig_lenf > (unsigned __int64)v113 )
  {
LABEL_332:
    efree(v97);
    if ( v92 )
      phar_destroy_phar_data((phar_archive_data *)v92);
LABEL_73:
    if ( ptr )
    {
      if ( phar_globals.persist )
      {
        free(ptr);
        if ( !fp )
        {
LABEL_80:
          v16 = -1;
          if ( error )
            zend_spprintf(error, 0LL, "internal corruption of phar \"%s\" (truncated manifest header)", fname);
          return v16;
        }
LABEL_79:
        php_stream_free(fp, 3);
        goto LABEL_80;
      }
      efree(ptr);
    }
    if ( !fp )
      goto LABEL_80;
    goto LABEL_79;
  }
  v38 = *v37;
LABEL_142:
  *(_QWORD *)zip_metadata_len = v38;
  if ( (unsigned __int64)&v113[-sig_lenf] < v38 )
  {
    efree(v97);
    if ( v92 )
      phar_destroy_phar_data((phar_archive_data *)v92);
    if ( ptr )
    {
      if ( phar_globals.persist )
      {
        free(ptr);
        if ( !fp )
        {
LABEL_204:
          v16 = -1;
          if ( error )
            zend_spprintf(error, 0LL, "internal corruption of phar \"%s\" (trying to read past buffer end)", fname);
          return v16;
        }
LABEL_203:
        php_stream_free(fp, 3);
        goto LABEL_204;
      }
      efree(ptr);
    }
    if ( !fp )
      goto LABEL_204;
    goto LABEL_203;
  }
  v39 = v92;
  phar_parse_metadata_lazy((const char *)sig_lenf, (phar_metadata_tracker *)(v92 + 296), zip_metadata_len[0], v36);
  v40 = HIBYTE(*(unsigned __int16 *)(v92 + 324)) & 1;
  ht = (HashTable *)(v92 + 72);
  zend_hash_init((HashTable *)(v92 + 72), nSize[0], (dtor_func_t)destroy_phar_manifest_entry, v40);
  zend_hash_init((HashTable *)(v39 + 184), 5u, 0LL, *(_WORD *)(v39 + 324) & 0x100);
  zend_hash_init((HashTable *)(v39 + 128), 2 * nSize[0], 0LL, *(_WORD *)(v39 + 324) & 0x100);
  if ( (*(_BYTE *)(v92 + 325) & 1) != 0 )
    v41 = zend_strndup(fname, length);
  else
    v41 = estrndup(fname, length);
  v42 = (uint32_t *)(*(_QWORD *)zip_metadata_len + sig_lenf);
  v43 = (phar_archive_data *)v92;
  *(_QWORD *)v92 = v41;
  *(_DWORD *)(v92 + 8) = length;
  *(_OWORD *)&sig.tar_type = 0LL;
  memset(&sig, 0, 128);
  *(_OWORD *)&sig.phar = v92;
  *((_WORD *)&sig + 77) = *(_WORD *)(v92 + 324) & 0x100;
  v129 = v113 - 24;
  v44 = 0;
  v126 = v9 + size + 4;
  size = v126;
  v45 = v108;
  v46 = v93;
  while ( 1 )
  {
    zip_metadata_len[0] = v46;
    if ( v42 + 7 > (uint32_t *)v113 )
    {
      v67 = v43;
      efree(v97);
      v68 = v67;
      goto LABEL_237;
    }
    sig.filename_len = *v42;
    filename_len = sig.filename_len;
    if ( !sig.filename_len )
    {
      v69 = v43;
      efree(v97);
      phar_destroy_phar_data(v69);
      if ( ptr )
      {
        if ( phar_globals.persist )
        {
          free(ptr);
          if ( !fp )
          {
LABEL_259:
            v16 = -1;
            if ( error )
              zend_spprintf(error, 0LL, "zero-length filename encountered in phar \"%s\"", fname);
            return v16;
          }
LABEL_258:
          php_stream_free(fp, 3);
          goto LABEL_259;
        }
        efree(ptr);
      }
      if ( !fp )
        goto LABEL_259;
      goto LABEL_258;
    }
    v51 = (char *)(v42 + 1);
    if ( (*((_WORD *)&sig + 77) & 0x100) != 0 )
      sig.manifest_pos = v44;
    if ( v129 - v51 < (unsigned __int64)sig.filename_len )
      break;
    v124 = v44;
    if ( v45 >= 0x1110 && v51[sig.filename_len - 1] == 47 )
      v52 = *((unsigned __int16 *)&sig + 77) | 8;
    else
      v52 = *((_WORD *)&sig + 77) & 0xFFF7;
    v94 = v52;
    *((_WORD *)&sig + 77) = v52;
    sig_leng = (size_t)v51;
    phar_add_virtual_dirs(v43, v51, sig.filename_len);
    if ( (v94 & 0x100) != 0 )
      v53 = zend_strndup(v51, filename_len);
    else
      v53 = estrndup(v51, filename_len);
    sig.filename = v53;
    sig.uncompressed_filesize = *(_DWORD *)&v51[filename_len];
    v54 = *(_DWORD *)&v51[filename_len + 4];
    sig.timestamp = *(_DWORD *)(sig_leng + filename_len + 4);
    if ( size == v126 )
    {
      *(_DWORD *)(v92 + 244) = v54;
      *(_DWORD *)(v92 + 248) = v54;
      v55 = v94;
    }
    else if ( *(_DWORD *)(v92 + 244) <= v54 )
    {
      v55 = v94;
      if ( *(_DWORD *)(v92 + 248) < v54 )
        *(_DWORD *)(v92 + 248) = v54;
    }
    else
    {
      *(_DWORD *)(v92 + 244) = v54;
      v55 = v94;
    }
    sig.compressed_filesize = *(_DWORD *)(filename_len + sig_leng + 8);
    sig.crc32 = *(_DWORD *)(filename_len + sig_leng + 12);
    v56 = *(_DWORD *)(filename_len + sig_leng + 16);
    sig.flags = v56;
    v57 = (unsigned int *)(filename_len + sig_leng + 20);
    if ( (v55 & 8) != 0 )
    {
      sig.filename_len = filename_len - 1;
      sig.flags = v56 | 0x1FF;
    }
    v58 = *v57;
    v59 = (const char *)(v57 + 1);
    if ( v113 - v59 < v58 )
    {
      if ( (v55 & 0x100) != 0 )
        free(v53);
      else
        efree(v53);
      efree(v97);
      v68 = (phar_archive_data *)v92;
LABEL_237:
      phar_destroy_phar_data(v68);
      goto LABEL_238;
    }
    sig.metadata_tracker.val.u1.type_info = 0;
    sig.metadata_tracker.str = 0LL;
    sig_lenh = (size_t)v59;
    phar_parse_metadata_lazy(v59, &sig.metadata_tracker, v58, (v55 >> 8) & 1);
    sig.offset_abs = size;
    sig.offset = size;
    v60 = sig.flags & 0xF000;
    v95 = v60;
    v131 = v58;
    compressed_filesize = sig.compressed_filesize;
    if ( v60 == 0x2000 )
    {
      if ( phar_globals.has_bz2 )
        goto LABEL_184;
      phar_metadata_tracker_free(&sig.metadata_tracker, HIBYTE(*((unsigned __int16 *)&sig + 77)) & 1);
      if ( (*((_BYTE *)&sig + 155) & 1) != 0 )
        free(sig.filename);
      else
        efree(sig.filename);
      efree(v97);
      phar_destroy_phar_data((phar_archive_data *)v92);
      if ( ptr )
      {
        if ( phar_globals.persist )
        {
          free(ptr);
          if ( !fp )
          {
LABEL_308:
            v16 = -1;
            if ( error )
              zend_spprintf(error, 0LL, "bz2 extension is required for bzip2 compressed .phar file \"%s\"", fname);
            return v16;
          }
LABEL_307:
          php_stream_free(fp, 3);
          goto LABEL_308;
        }
        efree(ptr);
      }
      if ( !fp )
        goto LABEL_308;
      goto LABEL_307;
    }
    if ( (unsigned __int16)v60 == 4096 )
    {
      if ( !phar_globals.has_zlib )
      {
        phar_metadata_tracker_free(&sig.metadata_tracker, HIBYTE(*((unsigned __int16 *)&sig + 77)) & 1);
        if ( (*((_BYTE *)&sig + 155) & 1) != 0 )
          free(sig.filename);
        else
          efree(sig.filename);
        efree(v97);
        phar_destroy_phar_data((phar_archive_data *)v92);
        if ( ptr )
        {
          if ( phar_globals.persist )
          {
            free(ptr);
            if ( !fp )
            {
LABEL_303:
              v16 = -1;
              if ( error )
                zend_spprintf(error, 0LL, "zlib extension is required for gz compressed .phar file \"%s\"", fname);
              return v16;
            }
LABEL_302:
            php_stream_free(fp, 3);
            goto LABEL_303;
          }
          efree(ptr);
        }
        if ( !fp )
          goto LABEL_303;
        goto LABEL_302;
      }
      goto LABEL_184;
    }
    if ( sig.uncompressed_filesize != sig.compressed_filesize )
    {
      phar_metadata_tracker_free(&sig.metadata_tracker, HIBYTE(*((unsigned __int16 *)&sig + 77)) & 1);
      if ( (*((_BYTE *)&sig + 155) & 1) != 0 )
        free(sig.filename);
      else
        efree(sig.filename);
      efree(v97);
      phar_destroy_phar_data((phar_archive_data *)v92);
      if ( ptr )
      {
        if ( phar_globals.persist )
        {
          free(ptr);
          if ( !fp )
          {
LABEL_313:
            v16 = -1;
            if ( error )
              zend_spprintf(
                error,
                0LL,
                "internal corruption of phar \"%s\" (compressed and uncompressed size does not match for uncompressed entry)",
                fname);
            return v16;
          }
LABEL_312:
          php_stream_free(fp, 3);
          goto LABEL_313;
        }
        efree(ptr);
      }
      if ( !fp )
        goto LABEL_313;
      goto LABEL_312;
    }
LABEL_184:
    *((_WORD *)&sig + 77) = BYTE2(zip_metadata_len[0]) & 1 | *((_WORD *)&sig + 77) & 0xFFFE;
    phar_set_inode_1(&sig);
    if ( (*(_BYTE *)(v92 + 325) & 1) != 0 )
    {
      inited = zend_string_init_interned(sig.filename, sig.filename_len, 1);
    }
    else
    {
      src = sig.filename;
      n = sig.filename_len;
      inited = (zend_string *)emalloc((sig.filename_len + 32LL) & 0xFFFFFFFFFFFFFFF8LL);
      inited->gc = (zend_refcounted_h)0x1600000001LL;
      inited->h = 0LL;
      v62 = n;
      inited->len = n;
      memcpy(inited->val, src, v62);
      inited->val[n] = 0;
    }
    v120.value.lval = 0LL;
    v120.u1.type_info = 13;
    v63 = zend_hash_add(ht, inited, &v120);
    if ( v63 )
    {
      n = (size_t)v63;
      if ( *(char *)(v92 + 76) < 0 )
        v64 = _zend_malloc(0xA0uLL);
      else
        v64 = emalloc_160();
      *(_QWORD *)n = v64;
      memcpy(v64, &sig, 0xA0uLL);
    }
    v65.type_info = (uint32_t)inited->gc.u;
    v43 = (phar_archive_data *)v92;
    v47 = nSize[0];
    v45 = v108;
    v48 = v95;
    v49 = sig_lenh;
    if ( (v65.type_info & 0x40) == 0 )
    {
      v66 = inited->gc.refcount-- == 1;
      if ( v66 )
      {
        if ( SLOBYTE(v65.type_info) >= 0 )
          efree(inited);
        else
          free(inited);
        v43 = (phar_archive_data *)v92;
        v47 = nSize[0];
        v45 = v108;
        v48 = v95;
        v49 = sig_lenh;
      }
    }
    v42 = (uint32_t *)(v131 + v49);
    size += compressed_filesize;
    v46 = zip_metadata_len[0] | v48;
    v44 = v124 + 1;
    if ( v47 == v124 + 1 )
    {
      v71 = v43;
      v96 = v46;
      ap_php_snprintf(v43->version, 0xCuLL, "%u.%u.%u", v110 >> 4, v110 & 0xF, (unsigned int)v117 >> 4);
      v71->internal_file_start = v126;
      v71->halt_offset = v9;
      v71->flags = v96;
      v72 = v71->fname;
      v73 = strrchr(v72, 47);
      if ( v73 )
      {
        v74 = v73;
        size = (size_t)&v72[length];
        v75 = (char *)memchr(v73, 46, &v72[length] - v73);
        *(_QWORD *)(v92 + 16) = v75;
        if ( v75 == v74 )
        {
          v75 = (char *)memchr(v74 + 1, 46, size + ~(unsigned __int64)v74);
          *(_QWORD *)(v92 + 16) = v75;
        }
        if ( v75 )
          *(_DWORD *)(v92 + 24) = (_DWORD)v72 + *(_DWORD *)(v92 + 8) - (_DWORD)v75;
      }
      if ( s2 )
      {
        if ( (*(_WORD *)(v92 + 324) & 0x100) != 0 )
        {
          v76 = zend_strndup(s2, alias_len);
          goto LABEL_263;
        }
        v78 = s2;
        v79 = alias_len;
      }
      else
      {
        v78 = (char *)v72;
        if ( (*(_WORD *)(v92 + 324) & 0x100) != 0 )
        {
          v76 = zend_strndup(v72, length);
          goto LABEL_263;
        }
        v79 = length;
      }
      v76 = estrndup(v78, v79);
LABEL_263:
      v80 = length;
      if ( s2 )
        v80 = alias_len;
      *(_QWORD *)(v92 + 32) = v76;
      *(_DWORD *)(v92 + 40) = v80;
      *(_DWORD *)(v92 + 276) = v112;
      *(_QWORD *)(v92 + 256) = fp;
      *(_DWORD *)(v92 + 280) = v119;
      *(_QWORD *)(v92 + 288) = ptr;
      phar_request_initialize();
      v81 = *(_WORD *)(v92 + 324);
      if ( v122 )
      {
        *(_WORD *)(v92 + 324) = v81 & 0xFFFE | v118;
        if ( !phar_validate_alias_1(*(const char **)(v92 + 32), *(unsigned int *)(v92 + 40)) )
        {
          ptr = 0LL;
          efree(v97);
          phar_destroy_phar_data((phar_archive_data *)v92);
          if ( ptr )
          {
            if ( phar_globals.persist )
              free(ptr);
            else
              efree(ptr);
          }
          v16 = -1;
          if ( error )
            zend_spprintf(error, 0LL, "Cannot open archive \"%s\", invalid alias", fname);
          return v16;
        }
        v82 = (phar_archive_data **)zend_hash_str_find(&phar_globals.phar_alias_map, s2, alias_len);
        if ( v82 && phar_free_alias(*v82, s2, alias_len) )
        {
          ptr = 0LL;
          efree(v97);
          phar_destroy_phar_data((phar_archive_data *)v92);
          if ( ptr )
          {
            if ( phar_globals.persist )
              free(ptr);
            else
              efree(ptr);
          }
          v16 = -1;
          if ( error )
            zend_spprintf(error, 0LL, "Cannot open archive \"%s\", alias is already in use by existing archive", fname);
          return v16;
        }
        if ( (*(_BYTE *)(v92 + 325) & 1) != 0 )
        {
          v83 = zend_string_init_interned(s2, alias_len, 1);
        }
        else
        {
          v83 = (zend_string *)emalloc((alias_len + 32) & 0xFFFFFFFFFFFFFFF8LL);
          v83->gc = (zend_refcounted_h)0x1600000001LL;
          v83->h = 0LL;
          v83->len = alias_len;
          memcpy(v83->val, s2, alias_len);
          v83->val[alias_len] = 0;
        }
        v120.value.lval = v92;
        v120.u1.type_info = 13;
        zend_hash_add(&phar_globals.phar_alias_map, v83, &v120);
        v84.type_info = (uint32_t)v83->gc.u;
        if ( (v84.type_info & 0x40) == 0 )
        {
          v66 = v83->gc.refcount-- == 1;
          if ( v66 )
          {
            if ( SLOBYTE(v84.type_info) < 0 )
              free(v83);
            else
              efree(v83);
          }
        }
      }
      else
      {
        *(_WORD *)(v92 + 324) = v81 | 1;
      }
      if ( (*(_BYTE *)(v92 + 325) & 1) != 0 )
      {
        v87 = zend_string_init_interned(*(const char **)v92, length, 1);
      }
      else
      {
        v85 = *(const char **)v92;
        v86 = length;
        v87 = (zend_string *)emalloc((length + 32) & 0xFFFFFFFFFFFFFFF8LL);
        v87->gc = (zend_refcounted_h)0x1600000001LL;
        v87->h = 0LL;
        v87->len = v86;
        memcpy(v87->val, v85, v86);
        v87->val[v86] = 0;
      }
      v120.value.lval = v92;
      v120.u1.type_info = 13;
      zend_hash_add(&phar_globals.phar_fname_map, v87, &v120);
      v88.type_info = (uint32_t)v87->gc.u;
      if ( (v88.type_info & 0x40) == 0 )
      {
        v66 = v87->gc.refcount-- == 1;
        if ( v66 )
        {
          if ( SLOBYTE(v88.type_info) < 0 )
            free(v87);
          else
            efree(v87);
        }
      }
      efree(v97);
      v16 = 0;
      if ( pphar )
        *pphar = (phar_archive_data *)v92;
      return v16;
    }
  }
  v70 = v43;
  efree(v97);
  if ( v70 )
  {
    v68 = (phar_archive_data *)v92;
    goto LABEL_237;
  }
LABEL_238:
  if ( !ptr )
  {
LABEL_243:
    if ( fp )
      goto LABEL_244;
    goto LABEL_245;
  }
  if ( !phar_globals.persist )
  {
    efree(ptr);
    goto LABEL_243;
  }
  free(ptr);
  if ( !fp )
    goto LABEL_245;
LABEL_244:
  php_stream_free(fp, 3);
LABEL_245:
  v16 = -1;
  if ( error )
    zend_spprintf(error, 0LL, "internal corruption of phar \"%s\" (truncated manifest entry)", fname);
  return v16;
}

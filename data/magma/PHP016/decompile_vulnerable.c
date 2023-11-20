__int64 __fastcall phar_parse_zipfile(
        php_stream *fp,
        char *fname,
        size_t fname_len,
        char *alias,
        size_t alias_len,
        phar_archive_data **pphar,
        char **error)
{
  unsigned __int64 v10;
  size_t v11;
  unsigned int v12;
  const char *v13;
  char *eocd;
  char *v15;
  char **v16;
  char *v17;
  int v19;
  __int64 v20;
  int v21;
  char *v22;
  int v23;
  unsigned int v24;
  zend_off_t v25;
  const char *v26;
  phar_archive_data *v27;
  char *v28;
  char *v29;
  zend_value v30;
  char *v31;
  char *v32;
  char *v33;
  char *v34;
  __int64 v35;
  char *v36;
  char **v37;
  void *v38;
  unsigned __int16 v39;
  size_t v40;
  char *v41;
  __int64 filename_len;
  char *filename;
  uint32_t v44;
  __int64 v45;
  __int16 v46;
  int v47;
  zend_off_t v48;
  unsigned __int16 v49;
  zval *v50;
  zval *v51;
  php_stream *v52;
  php_stream *v53;
  zend_off_t v54;
  char *v55;
  ssize_t v56;
  size_t v57;
  int v58;
  zend_off_t v59;
  zend_off_t *v60;
  size_t uncompressed_filesize;
  zend_string *v62;
  zend_string *v63;
  size_t v64;
  bool v65;
  php_stream_filter *v66;
  php_stream_filter *v67;
  zend_string *v68;
  zend_string *v69;
  size_t v70;
  phar_archive_data *v71;
  char *lval;
  zval *v73;
  char *v74;
  unsigned int v75;
  const char *v76;
  size_t v77;
  size_t v78;
  phar_archive_data **v79;
  zend_value v80;
  char *v81;
  phar_archive_data **v82;
  const char *v83;
  char *v84;
  _QWORD *v85;
  void *v86;
  char *v87;
  const char *p_comments;
  void *v89;
  void *v90;
  void *v91;
  void *v92;
  char **v93;
  size_t v94;
  char *v95;
  const char *v96;
  char *v97;
  __int16 v98;
  size_t v99;
  void *v100;
  char *v101;
  char *v102;
  char *v103;
  char *v104;
  phar_archive_data *v105;
  char *v106;
  char *v107;
  char *v108;
  char *v109;
  char *v110;
  char *v111;
  char *v112;
  char *v113;
  char *v114;
  char *v115;
  char *v116;
  char *v117;
  char *v118;
  void *v119;
  void *v120;
  char *v121;
  char *v122;
  char *v123;
  char *v124;
  char *v125;
  char *v126;
  char *v127;
  char *v128;
  char *v129;
  char *v130;
  char *v131;
  char *v132;
  char *v133;
  char *v134;
  char *v135;
  char *v136;
  char *v137;
  char *v138;
  char *v139;
  phar_archive_data *phar;
  char *v141;
  HashTable *p_mounted_dirs;
  HashTable *p_virtual_dirs;
  HashTable *ht;
  HashTable *hta;
  size_t length;
  zend_off_t v148;
  zend_off_t v149;
  zend_off_t v150;
  zval v151;
  uint32_t v152;
  uint32_t v153;
  uint32_t v154;
  unsigned __int16 v155;
  uint16_t v156;
  unsigned __int8 v157;
  unsigned __int8 v158;
  unsigned __int16 v159;
  unsigned __int8 v160;
  unsigned __int8 v161;
  phar_entry_info src;
  __int64 v163;
  uint32_t nSize[2];
  zend_off_t v165;
  zend_off_t offset;
  phar_archive_data **v167;
  char pData[18];
  __int64 v169;
  unsigned __int8 v170;
  unsigned __int8 v171;
  unsigned __int16 v172;
  php_stream_filter_chain *chain;
  char *v174;
  char *message;
  zend_off_t *p_readpos;
  size_t count;
  char **signature;
  size_t len;
  char s[65608];

  len = alias_len;
  v174 = alias;
  memset(&src, 0, sizeof(src));
  v10 = php_stream_tell(fp);
  if ( v10 < 0x10017 )
  {
    v11 = v10;
    php_stream_seek(fp, 0LL, 0);
  }
  else
  {
    v11 = 65558LL;
    if ( php_stream_seek(fp, -65558LL, 2) == -1 )
    {
      php_stream_free(fp, 3);
      v12 = -1;
      if ( !error )
        return v12;
      v13 = "phar error: unable to search for end of central directory in zip-based phar \"%s\"";
      goto LABEL_14;
    }
  }
  if ( !php_stream_read(fp, s, v11) )
  {
    php_stream_free(fp, 3);
    v12 = -1;
    if ( !error )
      return v12;
    v13 = "phar error: unable to read in data to search for end of central directory in zip-based phar \"%s\"";
LABEL_14:
    v16 = error;
    v17 = fname;
LABEL_18:
    zend_spprintf(v16, 0x1000uLL, v13, v17);
    return v12;
  }
  length = fname_len;
  v167 = pphar;
  eocd = phar_find_eocd(s, v11);
  if ( !eocd )
  {
    php_stream_free(fp, 3);
    v12 = -1;
    if ( !error )
      return v12;
    v13 = "phar error: end of central directory not found in zip-based phar \"%s\"";
LABEL_17:
    v16 = error;
    v17 = fname;
    goto LABEL_18;
  }
  v15 = eocd;
  if ( (unsigned __int8)eocd[6] | (unsigned __int16)((unsigned __int8)eocd[7] << 8)
    || (unsigned __int8)eocd[4] | (unsigned __int16)((unsigned __int8)eocd[5] << 8) )
  {
    php_stream_free(fp, 3);
    v12 = -1;
    if ( !error )
      return v12;
    v13 = "phar error: split archives spanning multiple zips cannot be processed in zip-based phar \"%s\"";
    goto LABEL_17;
  }
  v19 = (unsigned __int8)eocd[10] | (unsigned __int16)(eocd[11] << 8);
  *(_QWORD *)nSize = (unsigned __int8)v15[8] | (unsigned int)(unsigned __int16)(v15[9] << 8);
  if ( nSize[0] != v19 )
  {
    if ( error )
      zend_spprintf(
        error,
        0x1000uLL,
        "phar error: corrupt zip archive, conflicting file count in end of central directory record in zip-based phar \"%s\"",
        fname);
    php_stream_free(fp, 3);
    return (unsigned int)-1;
  }
  ht = (HashTable *)(unsigned __int8)v15[16];
  v163 = (unsigned __int8)v15[17];
  v148 = (unsigned __int8)v15[18];
  offset = (unsigned __int8)v15[19];
  v20 = (unsigned __int8)v15[20];
  v21 = v15[21];
  if ( phar_globals.persist )
    v22 = (char *)_zend_calloc(1uLL, 0x148uLL);
  else
    v22 = (char *)ecalloc(1uLL, 0x148uLL);
  v141 = v22 + 324;
  v23 = phar_globals.persist & 1;
  v24 = (v23 << 8) | *((_DWORD *)v22 + 81) & 0xFFFFFEFF;
  *((_WORD *)v22 + 162) = ((_WORD)v23 << 8) | *((_WORD *)v22 + 162) & 0xFEFF;
  v25 = v20 | (unsigned int)(v21 << 8);
  phar = (phar_archive_data *)v22;
  if ( (_WORD)v25 )
  {
    v26 = v15 + 22;
    if ( &s[v11] - v26 != (unsigned __int16)v25 )
    {
      v71 = (phar_archive_data *)v22;
      if ( error )
        zend_spprintf(
          error,
          0x1000uLL,
          "phar error: corrupt zip archive, zip file comment truncated in zip-based phar \"%s\"",
          fname);
      php_stream_free(fp, 3);
      if ( (v141[1] & 1) == 0 )
        goto LABEL_117;
LABEL_242:
      v105 = v71;
LABEL_278:
      free(v105);
      return (unsigned int)-1;
    }
    phar_parse_metadata_lazy(v26, (phar_metadata_tracker *)(v22 + 296), (unsigned __int16)v25, v23);
    v27 = phar;
    LOWORD(v24) = *((_WORD *)phar + 162);
  }
  else
  {
    *((_DWORD *)v22 + 76) = 0;
    v26 = 0LL;
    v27 = (phar_archive_data *)v22;
  }
  if ( (v24 & 0x100) != 0 )
    v28 = zend_strndup(fname, length);
  else
    v28 = estrndup(fname, length);
  v29 = v28;
  v165 = v25;
  v30.lval = (zend_long)v27;
  v27->fname = v28;
  *((_BYTE *)v27 + 324) |= 0x20u;
  v27->fname_len = length;
  v31 = strrchr(v28, 47);
  if ( v31 )
  {
    v32 = v31;
    v33 = &v29[length];
    v34 = (char *)memchr(v31, 46, v33 - v31);
    v27->ext = v34;
    if ( v34 == v32 )
    {
      v34 = (char *)memchr(v32 + 1, 46, (size_t)&v33[~(unsigned __int64)v32]);
      v27->ext = v34;
    }
    if ( v34 )
      v27->ext_len = (_DWORD)v33 - (_DWORD)v34;
  }
  v35 = 0LL;
  offset = ((unsigned __int64)ht + 256 * v163) | (v148 << 16) | (offset << 24);
  php_stream_seek(fp, offset, 0);
  hta = &v27->manifest;
  zend_hash_init(&v27->manifest, nSize[0], (dtor_func_t)destroy_phar_manifest_entry, *((_WORD *)v27 + 162) & 0x100);
  p_mounted_dirs = &v27->mounted_dirs;
  zend_hash_init(&v27->mounted_dirs, 5u, 0LL, *((_WORD *)v27 + 162) & 0x100);
  p_virtual_dirs = &v27->virtual_dirs;
  zend_hash_init(&v27->virtual_dirs, 2 * nSize[0], 0LL, *((_WORD *)v27 + 162) & 0x100);
  src.phar = v27;
  src.fp_type = phar_fp_type::PHAR_FP;
  *((_WORD *)&src + 77) = (*((_WORD *)&src + 77) & 0xFE7F) + (*((_WORD *)v27 + 162) & 0x100) + 128;
  v36 = 0LL;
  v37 = error;
  if ( !nSize[0] )
  {
LABEL_118:
    v73 = zend_hash_str_find(hta, ".phar/stub.php", 0xEuLL);
    v74 = v141;
    v75 = *(_DWORD *)v141 & 0xFFFFFF7F;
    if ( !v73 )
      LOWORD(v75) = *(_WORD *)v141 | 0x80;
    *(_WORD *)v141 = v75;
    if ( phar_globals.require_hash && (v75 & 0x80u) == 0 && !*(_QWORD *)(v30.lval + 288) )
    {
      zend_hash_destroy(hta);
      *(_DWORD *)(v30.lval + 80) = 8;
      zend_hash_destroy(p_mounted_dirs);
      *(_DWORD *)(v30.lval + 192) = 8;
      zend_hash_destroy(p_virtual_dirs);
      *(_DWORD *)(v30.lval + 136) = 8;
      php_stream_free(fp, 3);
      phar_metadata_tracker_free((phar_metadata_tracker *)(v30.lval + 296), (*(_DWORD *)(v30.lval + 324) >> 8) & 1);
      v86 = *(void **)(v30.lval + 288);
      if ( v86 )
        efree(v86);
      if ( v37 )
      {
        v87 = *(char **)v30.lval;
        p_comments = "signature is missing";
        goto LABEL_161;
      }
      goto LABEL_267;
    }
    *(_QWORD *)(v30.lval + 256) = fp;
    v76 = *(const char **)v30.lval;
    v151.value = v30;
    v151.u1.type_info = 13;
    zend_hash_str_add(&phar_globals.phar_fname_map, v76, length, &v151);
    v77 = len;
    if ( v36 )
    {
      v78 = *(unsigned int *)(v30.lval + 40);
      if ( !phar_validate_alias_0(v36, v78) )
      {
        if ( error )
          zend_spprintf(error, 0x1000uLL, "phar error: invalid alias \"%s\" in zip-based phar \"%s\"", v36, fname);
        goto LABEL_139;
      }
      *v141 &= ~1u;
      v79 = (phar_archive_data **)zend_hash_str_find(&phar_globals.phar_alias_map, v36, v78);
      if ( v79 && phar_free_alias(*v79, v36, *(unsigned int *)(v30.lval + 40)) )
      {
        if ( error )
          zend_spprintf(
            error,
            0x1000uLL,
            "phar error: Unable to add zip-based phar \"%s\" with implicit alias, alias is already in use",
            fname);
LABEL_139:
        efree(v36);
        v83 = *(const char **)v30.lval;
LABEL_140:
        zend_hash_str_del(&phar_globals.phar_fname_map, v83, length);
        return (unsigned int)-1;
      }
      if ( (*((_BYTE *)&src + 155) & 1) != 0 )
      {
        v84 = zend_strndup(v36, *(unsigned int *)(v30.lval + 40));
        v98 = *((_WORD *)&src + 77);
        *(_QWORD *)(v30.lval + 32) = v84;
        v85 = v167;
        if ( (v98 & 0x100) != 0 )
        {
          efree(v36);
          v84 = *(char **)(v30.lval + 32);
        }
      }
      else
      {
        *(_QWORD *)(v30.lval + 32) = v36;
        v84 = v36;
        v85 = v167;
      }
      v99 = *(unsigned int *)(v30.lval + 40);
      v151.value = v30;
      v151.u1.type_info = 13;
      zend_hash_str_add(&phar_globals.phar_alias_map, v84, v99, &v151);
    }
    else
    {
      if ( len )
      {
        v80.lval = v30.lval;
        v81 = v174;
        v82 = (phar_archive_data **)zend_hash_str_find(&phar_globals.phar_alias_map, v174, len);
        if ( v82 && phar_free_alias(*v82, v81, v77) )
        {
          if ( error )
            zend_spprintf(
              error,
              0x1000uLL,
              "phar error: Unable to add zip-based phar \"%s\" with explicit alias, alias is already in use",
              fname);
          v83 = *(const char **)v80.lval;
          goto LABEL_140;
        }
        v30.lval = v80.lval;
        v94 = *(unsigned int *)(v80.lval + 40);
        v151.value = v80;
        v151.u1.type_info = 13;
        zend_hash_str_add(&phar_globals.phar_alias_map, 0LL, v94, &v151);
        if ( (v141[1] & 1) != 0 )
          v95 = zend_strndup(v174, v77);
        else
          v95 = estrndup(v174, v77);
        *(_QWORD *)(v80.lval + 32) = v95;
        *(_DWORD *)(v80.lval + 40) = v77;
      }
      else
      {
        v96 = *(const char **)v30.lval;
        if ( (*(_BYTE *)(v30.lval + 325) & 1) != 0 )
          v97 = zend_strndup(v96, length);
        else
          v97 = estrndup(v96, length);
        *(_QWORD *)(v30.lval + 32) = v97;
        *(_DWORD *)(v30.lval + 40) = length;
      }
      *v141 |= 1u;
      v85 = v167;
    }
    v12 = 0;
    if ( v85 )
      *v85 = v30.lval;
    return v12;
  }
  p_readpos = &fp->readpos;
  chain = &fp->readfilters;
  count = (unsigned __int16)v165;
  signature = (char **)(v30.lval + 288);
  *(_QWORD *)nSize = -nSize[0];
  v36 = 0LL;
  while ( 1 )
  {
    v165 = php_stream_tell(fp);
    src.metadata_tracker.val.u1.type_info = 0;
    src.metadata_tracker.str = 0LL;
    if ( php_stream_read(fp, (char *)&v151, 0x2EuLL) != 46 )
    {
      zend_hash_destroy(hta);
      *(_DWORD *)(v30.lval + 80) = 8;
      zend_hash_destroy(p_mounted_dirs);
      *(_DWORD *)(v30.lval + 192) = 8;
      zend_hash_destroy(p_virtual_dirs);
      *(_DWORD *)(v30.lval + 136) = 8;
      php_stream_free(fp, 3);
      phar_metadata_tracker_free((phar_metadata_tracker *)(v30.lval + 296), (*(_DWORD *)(v30.lval + 324) >> 8) & 1);
      v89 = *(void **)(v30.lval + 288);
      if ( v89 )
        efree(v89);
      v74 = v141;
      if ( v37 )
      {
        v87 = *(char **)v30.lval;
        p_comments = "unable to read central directory entry, truncated";
        goto LABEL_161;
      }
      goto LABEL_267;
    }
    if ( v151.value.ww.w1 != 33639248 )
    {
      zend_hash_destroy(hta);
      *(_DWORD *)(v30.lval + 80) = 8;
      zend_hash_destroy(p_mounted_dirs);
      *(_DWORD *)(v30.lval + 192) = 8;
      zend_hash_destroy(p_virtual_dirs);
      *(_DWORD *)(v30.lval + 136) = 8;
      php_stream_free(fp, 3);
      phar_metadata_tracker_free((phar_metadata_tracker *)(v30.lval + 296), (*(_DWORD *)(v30.lval + 324) >> 8) & 1);
      v90 = *(void **)(v30.lval + 288);
      if ( v90 )
        efree(v90);
      v74 = v141;
      if ( v37 )
      {
        v87 = *(char **)v30.lval;
        p_comments = (char *)&end.name + 1;
        goto LABEL_161;
      }
      goto LABEL_267;
    }
    if ( (*((_BYTE *)&src + 155) & 1) != 0 )
      src.manifest_pos = v35;
    src.compressed_filesize = v153;
    src.uncompressed_filesize = v154;
    src.crc32 = v152;
    src.timestamp = phar_zip_d2u_time((char *)&v151.u2, (char *)&v151.u2.cache_slot + 2);
    src.flags = 438;
    LOWORD(src.header_offset) = v159;
    BYTE2(src.header_offset) = v160;
    BYTE3(src.header_offset) = v161;
    src.offset_abs = src.header_offset + v155 + v156 + 30;
    src.offset = src.offset_abs;
    if ( (v151.u1.v.type & 1) != 0 )
    {
      zend_hash_destroy(hta);
      *(_DWORD *)(v30.lval + 80) = 8;
      zend_hash_destroy(p_mounted_dirs);
      *(_DWORD *)(v30.lval + 192) = 8;
      zend_hash_destroy(p_virtual_dirs);
      *(_DWORD *)(v30.lval + 136) = 8;
      php_stream_free(fp, 3);
      phar_metadata_tracker_free((phar_metadata_tracker *)(v30.lval + 296), (*(_DWORD *)(v30.lval + 324) >> 8) & 1);
      v91 = *(void **)(v30.lval + 288);
      if ( v91 )
        efree(v91);
      v74 = v141;
      if ( v37 )
      {
        v87 = *(char **)v30.lval;
        p_comments = (char *)&end.bit64.leapcnt + 7;
        goto LABEL_161;
      }
LABEL_267:
      v119 = *(void **)v30.lval;
      if ( (*(_BYTE *)(v30.lval + 325) & 1) != 0 )
        free(v119);
      else
        efree(v119);
      v120 = *(void **)(v30.lval + 32);
      if ( v120 )
      {
        if ( (v74[1] & 1) != 0 )
        {
          free(v120);
          if ( (v74[1] & 1) == 0 )
            goto LABEL_274;
          goto LABEL_277;
        }
        efree(v120);
      }
      if ( (v74[1] & 1) == 0 )
      {
LABEL_274:
        lval = (char *)v30.lval;
        goto LABEL_275;
      }
LABEL_277:
      v105 = (phar_archive_data *)v30.lval;
      goto LABEL_278;
    }
    v39 = (unsigned __int8)v155 | (unsigned __int16)(SHIBYTE(v155) << 8);
    if ( !v39 )
    {
      zend_hash_destroy(hta);
      *(_DWORD *)(v30.lval + 80) = 8;
      zend_hash_destroy(p_mounted_dirs);
      *(_DWORD *)(v30.lval + 192) = 8;
      zend_hash_destroy(p_virtual_dirs);
      *(_DWORD *)(v30.lval + 136) = 8;
      php_stream_free(fp, 3);
      phar_metadata_tracker_free((phar_metadata_tracker *)(v30.lval + 296), (*(_DWORD *)(v30.lval + 324) >> 8) & 1);
      v92 = *(void **)(v30.lval + 288);
      if ( v92 )
        efree(v92);
      v74 = v141;
      if ( !v37 )
        goto LABEL_267;
      v87 = *(char **)v30.lval;
      p_comments = (char *)&end.trans_idx + 2;
LABEL_161:
      v93 = v37;
      goto LABEL_266;
    }
    src.filename_len = v39;
    v40 = v39 + 1LL;
    if ( (*((_BYTE *)&src + 155) & 1) != 0 )
      v41 = (char *)_zend_malloc(v40);
    else
      v41 = (char *)emalloc((unsigned int)v40);
    src.filename = v41;
    filename_len = src.filename_len;
    if ( php_stream_read(fp, v41, src.filename_len) != filename_len )
    {
      if ( (*((_BYTE *)&src + 155) & 1) != 0 )
        free(src.filename);
      else
        efree(src.filename);
      v74 = v141;
      zend_hash_destroy(hta);
      *(_DWORD *)(v30.lval + 80) = 8;
      zend_hash_destroy(p_mounted_dirs);
      *(_DWORD *)(v30.lval + 192) = 8;
      zend_hash_destroy(p_virtual_dirs);
      *(_DWORD *)(v30.lval + 136) = 8;
      php_stream_free(fp, 3);
      phar_metadata_tracker_free((phar_metadata_tracker *)(v30.lval + 296), (*(_DWORD *)(v30.lval + 324) >> 8) & 1);
      v100 = *(void **)(v30.lval + 288);
      if ( v100 )
        efree(v100);
      v93 = error;
      if ( !error )
        goto LABEL_267;
      v87 = *(char **)v30.lval;
      p_comments = (const char *)&end.location.comments;
      goto LABEL_266;
    }
    v149 = (zend_off_t)v36;
    v163 = v35;
    src.filename[src.filename_len] = 0;
    filename = src.filename;
    v44 = src.filename_len;
    v45 = src.filename_len - 1;
    if ( src.filename[v45] == 47 )
    {
      v46 = *((_WORD *)&src + 77) | 8;
      *((_WORD *)&src + 77) |= 8u;
      if ( src.filename_len >= 2 )
      {
        --src.filename_len;
        v44 = v45;
      }
      src.flags |= 0x1FFu;
      if ( v44 != 19 )
      {
LABEL_61:
        v30.lval = (zend_long)phar;
        phar_add_virtual_dirs(phar, filename, v44);
        v47 = v163;
        v36 = (char *)v149;
        if ( v156 )
        {
          v48 = php_stream_tell(fp);
          if ( phar_zip_process_extra(fp, &src, v156) == -1 )
          {
            if ( (*((_BYTE *)&src + 155) & 1) != 0 )
              free(src.filename);
            else
              efree(src.filename);
            v74 = v141;
            zend_hash_destroy(hta);
            phar->manifest.u.flags = 8;
            zend_hash_destroy(p_mounted_dirs);
            phar->mounted_dirs.u.flags = 8;
            zend_hash_destroy(p_virtual_dirs);
            phar->virtual_dirs.u.flags = 8;
            php_stream_free(fp, 3);
            phar_metadata_tracker_free(&phar->metadata_tracker, (*((_DWORD *)phar + 81) >> 8) & 1);
            v101 = phar->signature;
            if ( v101 )
              efree(v101);
            v93 = error;
            if ( !error )
              goto LABEL_267;
            v87 = phar->fname;
            p_comments = "Unable to process extra field header for file in central directory";
            goto LABEL_266;
          }
          php_stream_seek(fp, v48 + v156, 0);
        }
        switch ( v151.u1.v.u.extra )
        {
          case 0u:
            goto LABEL_68;
          case 1u:
            if ( (*((_BYTE *)&src + 155) & 1) != 0 )
              free(src.filename);
            else
              efree(src.filename);
            zend_hash_destroy(hta);
            phar->manifest.u.flags = 8;
            zend_hash_destroy(p_mounted_dirs);
            phar->mounted_dirs.u.flags = 8;
            zend_hash_destroy(p_virtual_dirs);
            phar->virtual_dirs.u.flags = 8;
            php_stream_free(fp, 3);
            phar_metadata_tracker_free(&phar->metadata_tracker, (*((_DWORD *)phar + 81) >> 8) & 1);
            v125 = phar->signature;
            if ( v125 )
              efree(v125);
            if ( error )
              zend_spprintf(
                error,
                0x1000uLL,
                "phar error: %s in zip-based phar \"%s\"",
                "unsupported compression method (Shrunk) used in this zip",
                phar->fname);
            goto LABEL_397;
          case 2u:
          case 3u:
          case 4u:
          case 5u:
            if ( (*((_BYTE *)&src + 155) & 1) != 0 )
              free(src.filename);
            else
              efree(src.filename);
            v74 = v141;
            zend_hash_destroy(hta);
            phar->manifest.u.flags = 8;
            zend_hash_destroy(p_mounted_dirs);
            phar->mounted_dirs.u.flags = 8;
            zend_hash_destroy(p_virtual_dirs);
            phar->virtual_dirs.u.flags = 8;
            php_stream_free(fp, 3);
            phar_metadata_tracker_free(&phar->metadata_tracker, (*((_DWORD *)phar + 81) >> 8) & 1);
            v117 = phar->signature;
            if ( v117 )
              efree(v117);
            v93 = error;
            if ( !error )
              goto LABEL_267;
            v87 = phar->fname;
            p_comments = "unsupported compression method (Reduce) used in this zip";
            goto LABEL_266;
          case 6u:
            if ( (*((_BYTE *)&src + 155) & 1) != 0 )
              free(src.filename);
            else
              efree(src.filename);
            zend_hash_destroy(hta);
            phar->manifest.u.flags = 8;
            zend_hash_destroy(p_mounted_dirs);
            phar->mounted_dirs.u.flags = 8;
            zend_hash_destroy(p_virtual_dirs);
            phar->virtual_dirs.u.flags = 8;
            php_stream_free(fp, 3);
            phar_metadata_tracker_free(&phar->metadata_tracker, (*((_DWORD *)phar + 81) >> 8) & 1);
            v126 = phar->signature;
            if ( v126 )
              efree(v126);
            if ( error )
              zend_spprintf(
                error,
                0x1000uLL,
                "phar error: %s in zip-based phar \"%s\"",
                "unsupported compression method (Implode) used in this zip",
                phar->fname);
            goto LABEL_397;
          case 7u:
            if ( (*((_BYTE *)&src + 155) & 1) != 0 )
              free(src.filename);
            else
              efree(src.filename);
            zend_hash_destroy(hta);
            phar->manifest.u.flags = 8;
            zend_hash_destroy(p_mounted_dirs);
            phar->mounted_dirs.u.flags = 8;
            zend_hash_destroy(p_virtual_dirs);
            phar->virtual_dirs.u.flags = 8;
            php_stream_free(fp, 3);
            phar_metadata_tracker_free(&phar->metadata_tracker, (*((_DWORD *)phar + 81) >> 8) & 1);
            v127 = phar->signature;
            if ( v127 )
              efree(v127);
            if ( error )
              zend_spprintf(
                error,
                0x1000uLL,
                "phar error: %s in zip-based phar \"%s\"",
                "unsupported compression method (Tokenize) used in this zip",
                phar->fname);
            goto LABEL_397;
          case 8u:
            BYTE1(src.flags) |= 0x10u;
            if ( phar_globals.has_zlib )
              goto LABEL_68;
            if ( (*((_BYTE *)&src + 155) & 1) != 0 )
              free(src.filename);
            else
              efree(src.filename);
            v74 = v141;
            zend_hash_destroy(hta);
            phar->manifest.u.flags = 8;
            zend_hash_destroy(p_mounted_dirs);
            phar->mounted_dirs.u.flags = 8;
            zend_hash_destroy(p_virtual_dirs);
            phar->virtual_dirs.u.flags = 8;
            php_stream_free(fp, 3);
            phar_metadata_tracker_free(&phar->metadata_tracker, (*((_DWORD *)phar + 81) >> 8) & 1);
            v115 = phar->signature;
            if ( v115 )
              efree(v115);
            v93 = error;
            if ( !error )
              goto LABEL_267;
            v87 = phar->fname;
            p_comments = "zlib extension is required";
            goto LABEL_266;
          case 9u:
            if ( (*((_BYTE *)&src + 155) & 1) != 0 )
              free(src.filename);
            else
              efree(src.filename);
            zend_hash_destroy(hta);
            phar->manifest.u.flags = 8;
            zend_hash_destroy(p_mounted_dirs);
            phar->mounted_dirs.u.flags = 8;
            zend_hash_destroy(p_virtual_dirs);
            phar->virtual_dirs.u.flags = 8;
            php_stream_free(fp, 3);
            phar_metadata_tracker_free(&phar->metadata_tracker, (*((_DWORD *)phar + 81) >> 8) & 1);
            v128 = phar->signature;
            if ( v128 )
              efree(v128);
            if ( error )
              zend_spprintf(
                error,
                0x1000uLL,
                "phar error: %s in zip-based phar \"%s\"",
                "unsupported compression method (Deflate64) used in this zip",
                phar->fname);
            goto LABEL_397;
          case 0xAu:
            if ( (*((_BYTE *)&src + 155) & 1) != 0 )
              free(src.filename);
            else
              efree(src.filename);
            zend_hash_destroy(hta);
            phar->manifest.u.flags = 8;
            zend_hash_destroy(p_mounted_dirs);
            phar->mounted_dirs.u.flags = 8;
            zend_hash_destroy(p_virtual_dirs);
            phar->virtual_dirs.u.flags = 8;
            php_stream_free(fp, 3);
            phar_metadata_tracker_free(&phar->metadata_tracker, (*((_DWORD *)phar + 81) >> 8) & 1);
            v129 = phar->signature;
            if ( v129 )
              efree(v129);
            if ( error )
              zend_spprintf(
                error,
                0x1000uLL,
                "phar error: %s in zip-based phar \"%s\"",
                "unsupported compression method (PKWare Implode/old IBM TERSE) used in this zip",
                phar->fname);
            goto LABEL_397;
          case 0xCu:
            BYTE1(src.flags) |= 0x20u;
            if ( !phar_globals.has_bz2 )
            {
              if ( (*((_BYTE *)&src + 155) & 1) != 0 )
                free(src.filename);
              else
                efree(src.filename);
              v74 = v141;
              zend_hash_destroy(hta);
              phar->manifest.u.flags = 8;
              zend_hash_destroy(p_mounted_dirs);
              phar->mounted_dirs.u.flags = 8;
              zend_hash_destroy(p_virtual_dirs);
              phar->virtual_dirs.u.flags = 8;
              php_stream_free(fp, 3);
              phar_metadata_tracker_free(&phar->metadata_tracker, (*((_DWORD *)phar + 81) >> 8) & 1);
              v116 = phar->signature;
              if ( v116 )
                efree(v116);
              v93 = error;
              if ( !error )
                goto LABEL_267;
              v87 = phar->fname;
              p_comments = "bzip2 extension is required";
              goto LABEL_266;
            }
LABEL_68:
            v49 = v157 | (unsigned __int16)((char)v158 << 8);
            if ( !v49 )
            {
              src.metadata_tracker.val.u1.type_info = 0;
              if ( v149 )
                goto LABEL_76;
              goto LABEL_73;
            }
            if ( php_stream_read(fp, s, v49) == v49 )
            {
              phar_parse_metadata_lazy(
                s,
                &src.metadata_tracker,
                v157 | (unsigned __int16)(v158 << 8),
                HIBYTE(*((unsigned __int16 *)&src + 77)) & 1);
              v36 = (char *)v149;
              if ( v149 )
                goto LABEL_76;
LABEL_73:
              if ( src.filename_len != 15 || strncmp(src.filename, ".phar/alias.txt", 0xFuLL) )
              {
                v36 = 0LL;
                goto LABEL_76;
              }
              v59 = php_stream_tell(fp);
              php_stream_seek(fp, v159 | ((unsigned __int64)v160 << 16) | ((unsigned __int64)v161 << 24), 0);
              if ( php_stream_read(fp, pData, 0x1EuLL) != 30 )
              {
                if ( (*((_BYTE *)&src + 155) & 1) != 0 )
                  free(src.filename);
                else
                  efree(src.filename);
                zend_hash_destroy(hta);
                phar->manifest.u.flags = 8;
                zend_hash_destroy(p_mounted_dirs);
                phar->mounted_dirs.u.flags = 8;
                zend_hash_destroy(p_virtual_dirs);
                phar->virtual_dirs.u.flags = 8;
                php_stream_free(fp, 3);
                phar_metadata_tracker_free(&phar->metadata_tracker, (*((_DWORD *)phar + 81) >> 8) & 1);
                v136 = phar->signature;
                if ( v136 )
                  efree(v136);
                if ( error )
                  zend_spprintf(
                    error,
                    0x1000uLL,
                    "phar error: %s in zip-based phar \"%s\"",
                    "phar error: internal corruption of zip-based phar (cannot read local file header for alias)",
                    phar->fname);
                goto LABEL_397;
              }
              if ( src.filename_len == (v170 | (unsigned __int16)(v171 << 8))
                && src.crc32 == *(_DWORD *)&pData[14]
                && __PAIR64__(src.uncompressed_filesize, src.compressed_filesize) == v169 )
              {
                src.offset_abs = src.header_offset + src.filename_len + v172 + 30;
                src.offset = src.offset_abs;
                php_stream_seek(fp, src.offset_abs, 0);
                v60 = p_readpos;
                *(_OWORD *)p_readpos = 0LL;
                php_stream_seek(fp, src.offset, 0);
                *(_OWORD *)v60 = 0LL;
                uncompressed_filesize = src.uncompressed_filesize;
                phar->alias_len = src.uncompressed_filesize;
                v150 = v59;
                if ( (src.flags & 0x1000) != 0 )
                {
                  v66 = php_stream_filter_create("zlib.inflate", 0LL, *((_BYTE *)fp + 96) & 1);
                  if ( !v66 )
                  {
                    if ( (*((_BYTE *)&src + 155) & 1) != 0 )
                      free(src.filename);
                    else
                      efree(src.filename);
                    zend_hash_destroy(hta);
                    phar->manifest.u.flags = 8;
                    zend_hash_destroy(p_mounted_dirs);
                    phar->mounted_dirs.u.flags = 8;
                    zend_hash_destroy(p_virtual_dirs);
                    phar->virtual_dirs.u.flags = 8;
                    php_stream_free(fp, 3);
                    phar_metadata_tracker_free(&phar->metadata_tracker, (*((_DWORD *)phar + 81) >> 8) & 1);
                    v137 = phar->signature;
                    if ( v137 )
                      efree(v137);
                    if ( error )
                      zend_spprintf(
                        error,
                        0x1000uLL,
                        "phar error: %s in zip-based phar \"%s\"",
                        "unable to decompress alias, zlib filter creation failed",
                        phar->fname);
                    goto LABEL_397;
                  }
                }
                else
                {
                  if ( (src.flags & 0x2000) == 0 )
                  {
                    v62 = php_stream_copy_to_mem(fp, uncompressed_filesize, 0);
                    if ( !v62 )
                      goto LABEL_312;
                    v63 = v62;
                    v64 = v62->len;
                    src.uncompressed_filesize = v64;
                    v36 = estrndup(v62->val, v64);
                    if ( (v63->gc.u.type_info & 0x40) == 0 )
                    {
                      v65 = v63->gc.refcount-- == 1;
                      if ( v65 )
                        efree(v63);
                    }
                    if ( !v36 || !src.uncompressed_filesize )
                      goto LABEL_313;
                    goto LABEL_113;
                  }
                  v66 = php_stream_filter_create("bzip2.decompress", 0LL, *((_BYTE *)fp + 96) & 1);
                  if ( !v66 )
                  {
                    if ( (*((_BYTE *)&src + 155) & 1) != 0 )
                      free(src.filename);
                    else
                      efree(src.filename);
                    zend_hash_destroy(hta);
                    phar->manifest.u.flags = 8;
                    zend_hash_destroy(p_mounted_dirs);
                    phar->mounted_dirs.u.flags = 8;
                    zend_hash_destroy(p_virtual_dirs);
                    phar->virtual_dirs.u.flags = 8;
                    php_stream_free(fp, 3);
                    phar_metadata_tracker_free(&phar->metadata_tracker, (*((_DWORD *)phar + 81) >> 8) & 1);
                    v138 = phar->signature;
                    if ( v138 )
                      efree(v138);
                    if ( error )
                      zend_spprintf(
                        error,
                        0x1000uLL,
                        "phar error: %s in zip-based phar \"%s\"",
                        "unable to read in alias, bzip2 filter creation failed",
                        phar->fname);
                    goto LABEL_397;
                  }
                }
                v67 = v66;
                php_stream_filter_append(chain, v66);
                v68 = php_stream_copy_to_mem(fp, src.uncompressed_filesize, 0);
                if ( v68 )
                {
                  v69 = v68;
                  v70 = v68->len;
                  src.uncompressed_filesize = v70;
                  v36 = estrndup(v68->val, v70);
                  if ( (v69->gc.u.type_info & 0x40) == 0 )
                  {
                    v65 = v69->gc.refcount-- == 1;
                    if ( v65 )
                      efree(v69);
                  }
                  if ( !v36 || !src.uncompressed_filesize )
                    goto LABEL_313;
                  php_stream_filter_flush(v67, 1);
                  php_stream_filter_remove(v67, 1);
                  v30.lval = (zend_long)phar;
LABEL_113:
                  php_stream_seek(fp, v150, 0);
LABEL_76:
                  phar_set_inode_0(&src);
                  *(_QWORD *)pData = 0LL;
                  *(_DWORD *)&pData[8] = 13;
                  v50 = zend_hash_str_add(hta, src.filename, src.filename_len, (zval *)pData);
                  if ( v50 )
                  {
                    v51 = v50;
                    if ( *(char *)(v30.lval + 76) >= 0 )
                      v38 = emalloc_160();
                    else
                      v38 = _zend_malloc(0xA0uLL);
                    v51->value.lval = (zend_long)v38;
                    memcpy(v38, &src, 0xA0uLL);
                  }
                  goto LABEL_43;
                }
LABEL_312:
                src.uncompressed_filesize = 0;
LABEL_313:
                if ( (*((_BYTE *)&src + 155) & 1) != 0 )
                  free(src.filename);
                else
                  efree(src.filename);
                zend_hash_destroy(hta);
                phar->manifest.u.flags = 8;
                zend_hash_destroy(p_mounted_dirs);
                phar->mounted_dirs.u.flags = 8;
                zend_hash_destroy(p_virtual_dirs);
                phar->virtual_dirs.u.flags = 8;
                php_stream_free(fp, 3);
                phar_metadata_tracker_free(&phar->metadata_tracker, (*((_DWORD *)phar + 81) >> 8) & 1);
                v124 = phar->signature;
                if ( v124 )
                  efree(v124);
                if ( error )
                  zend_spprintf(
                    error,
                    0x1000uLL,
                    "phar error: %s in zip-based phar \"%s\"",
                    "unable to read in alias, truncated",
                    phar->fname);
LABEL_397:
                v122 = phar->fname;
                if ( (*((_BYTE *)phar + 325) & 1) == 0 )
                {
LABEL_398:
                  efree(v122);
                  goto LABEL_399;
                }
LABEL_282:
                free(v122);
LABEL_399:
                v139 = phar->alias;
                if ( v139 )
                {
                  if ( (v141[1] & 1) != 0 )
                    free(v139);
                  else
                    efree(v139);
                }
                if ( (v141[1] & 1) == 0 )
                {
                  lval = (char *)phar;
                  goto LABEL_275;
                }
                v105 = phar;
                goto LABEL_278;
              }
              if ( (*((_BYTE *)&src + 155) & 1) != 0 )
                free(src.filename);
              else
                efree(src.filename);
              v74 = v141;
              zend_hash_destroy(hta);
              phar->manifest.u.flags = 8;
              zend_hash_destroy(p_mounted_dirs);
              phar->mounted_dirs.u.flags = 8;
              zend_hash_destroy(p_virtual_dirs);
              phar->virtual_dirs.u.flags = 8;
              php_stream_free(fp, 3);
              phar_metadata_tracker_free(&phar->metadata_tracker, (*((_DWORD *)phar + 81) >> 8) & 1);
              v118 = phar->signature;
              if ( v118 )
                efree(v118);
              v93 = error;
              if ( !error )
                goto LABEL_267;
              v87 = phar->fname;
              p_comments = "phar error: internal corruption of zip-based phar (local header of alias does not match central directory)";
LABEL_266:
              zend_spprintf(v93, 0x1000uLL, "phar error: %s in zip-based phar \"%s\"", p_comments, v87);
              goto LABEL_267;
            }
            if ( (*((_BYTE *)&src + 155) & 1) != 0 )
              free(src.filename);
            else
              efree(src.filename);
            zend_hash_destroy(hta);
            phar->manifest.u.flags = 8;
            zend_hash_destroy(p_mounted_dirs);
            phar->mounted_dirs.u.flags = 8;
            zend_hash_destroy(p_virtual_dirs);
            phar->virtual_dirs.u.flags = 8;
            php_stream_free(fp, 3);
            phar_metadata_tracker_free(&phar->metadata_tracker, (*((_DWORD *)phar + 81) >> 8) & 1);
            v102 = phar->signature;
            if ( v102 )
              efree(v102);
            if ( error )
              zend_spprintf(
                error,
                0x1000uLL,
                "phar error: %s in zip-based phar \"%s\"",
                "unable to read in file comment, truncated",
                phar->fname);
            v103 = phar->fname;
            if ( (*((_BYTE *)phar + 325) & 1) != 0 )
              free(v103);
            else
              efree(v103);
            v104 = phar->alias;
            if ( !v104 )
              goto LABEL_244;
            if ( (v141[1] & 1) != 0 )
            {
              free(v104);
LABEL_244:
              if ( (v141[1] & 1) != 0 )
                goto LABEL_207;
            }
            else
            {
              efree(v104);
              if ( (v141[1] & 1) != 0 )
              {
LABEL_207:
                v105 = phar;
                goto LABEL_278;
              }
            }
            lval = (char *)phar;
            goto LABEL_275;
          case 0xEu:
            if ( (*((_BYTE *)&src + 155) & 1) != 0 )
              free(src.filename);
            else
              efree(src.filename);
            zend_hash_destroy(hta);
            phar->manifest.u.flags = 8;
            zend_hash_destroy(p_mounted_dirs);
            phar->mounted_dirs.u.flags = 8;
            zend_hash_destroy(p_virtual_dirs);
            phar->virtual_dirs.u.flags = 8;
            php_stream_free(fp, 3);
            phar_metadata_tracker_free(&phar->metadata_tracker, (*((_DWORD *)phar + 81) >> 8) & 1);
            v131 = phar->signature;
            if ( v131 )
              efree(v131);
            if ( error )
              zend_spprintf(
                error,
                0x1000uLL,
                "phar error: %s in zip-based phar \"%s\"",
                "unsupported compression method (LZMA) used in this zip",
                phar->fname);
            goto LABEL_397;
          case 0x12u:
            if ( (*((_BYTE *)&src + 155) & 1) != 0 )
              free(src.filename);
            else
              efree(src.filename);
            zend_hash_destroy(hta);
            phar->manifest.u.flags = 8;
            zend_hash_destroy(p_mounted_dirs);
            phar->mounted_dirs.u.flags = 8;
            zend_hash_destroy(p_virtual_dirs);
            phar->virtual_dirs.u.flags = 8;
            php_stream_free(fp, 3);
            phar_metadata_tracker_free(&phar->metadata_tracker, (*((_DWORD *)phar + 81) >> 8) & 1);
            v132 = phar->signature;
            if ( v132 )
              efree(v132);
            if ( error )
              zend_spprintf(
                error,
                0x1000uLL,
                "phar error: %s in zip-based phar \"%s\"",
                "unsupported compression method (IBM TERSE) used in this zip",
                phar->fname);
            goto LABEL_397;
          case 0x13u:
            if ( (*((_BYTE *)&src + 155) & 1) != 0 )
              free(src.filename);
            else
              efree(src.filename);
            zend_hash_destroy(hta);
            phar->manifest.u.flags = 8;
            zend_hash_destroy(p_mounted_dirs);
            phar->mounted_dirs.u.flags = 8;
            zend_hash_destroy(p_virtual_dirs);
            phar->virtual_dirs.u.flags = 8;
            php_stream_free(fp, 3);
            phar_metadata_tracker_free(&phar->metadata_tracker, (*((_DWORD *)phar + 81) >> 8) & 1);
            v133 = phar->signature;
            if ( v133 )
              efree(v133);
            if ( error )
              zend_spprintf(
                error,
                0x1000uLL,
                "phar error: %s in zip-based phar \"%s\"",
                "unsupported compression method (IBM LZ77) used in this zip",
                phar->fname);
            goto LABEL_397;
          case 0x61u:
            if ( (*((_BYTE *)&src + 155) & 1) != 0 )
              free(src.filename);
            else
              efree(src.filename);
            zend_hash_destroy(hta);
            phar->manifest.u.flags = 8;
            zend_hash_destroy(p_mounted_dirs);
            phar->mounted_dirs.u.flags = 8;
            zend_hash_destroy(p_virtual_dirs);
            phar->virtual_dirs.u.flags = 8;
            php_stream_free(fp, 3);
            phar_metadata_tracker_free(&phar->metadata_tracker, (*((_DWORD *)phar + 81) >> 8) & 1);
            v134 = phar->signature;
            if ( v134 )
              efree(v134);
            if ( error )
              zend_spprintf(
                error,
                0x1000uLL,
                "phar error: %s in zip-based phar \"%s\"",
                "unsupported compression method (WavPack) used in this zip",
                phar->fname);
            goto LABEL_397;
          case 0x62u:
            if ( (*((_BYTE *)&src + 155) & 1) != 0 )
              free(src.filename);
            else
              efree(src.filename);
            zend_hash_destroy(hta);
            phar->manifest.u.flags = 8;
            zend_hash_destroy(p_mounted_dirs);
            phar->mounted_dirs.u.flags = 8;
            zend_hash_destroy(p_virtual_dirs);
            phar->virtual_dirs.u.flags = 8;
            php_stream_free(fp, 3);
            phar_metadata_tracker_free(&phar->metadata_tracker, (*((_DWORD *)phar + 81) >> 8) & 1);
            v135 = phar->signature;
            if ( v135 )
              efree(v135);
            if ( error )
              zend_spprintf(
                error,
                0x1000uLL,
                "phar error: %s in zip-based phar \"%s\"",
                "unsupported compression method (PPMd) used in this zip",
                phar->fname);
            goto LABEL_397;
          default:
            if ( (*((_BYTE *)&src + 155) & 1) != 0 )
              free(src.filename);
            else
              efree(src.filename);
            zend_hash_destroy(hta);
            phar->manifest.u.flags = 8;
            zend_hash_destroy(p_mounted_dirs);
            phar->mounted_dirs.u.flags = 8;
            zend_hash_destroy(p_virtual_dirs);
            phar->virtual_dirs.u.flags = 8;
            php_stream_free(fp, 3);
            phar_metadata_tracker_free(&phar->metadata_tracker, (*((_DWORD *)phar + 81) >> 8) & 1);
            v130 = phar->signature;
            if ( v130 )
              efree(v130);
            if ( error )
              zend_spprintf(
                error,
                0x1000uLL,
                "phar error: %s in zip-based phar \"%s\"",
                "unsupported compression method (unknown) used in this zip",
                phar->fname);
            goto LABEL_397;
        }
      }
    }
    else
    {
      v46 = *((_WORD *)&src + 77) & 0xFFF7;
      *((_WORD *)&src + 77) &= ~8u;
      if ( src.filename_len != 19 )
        goto LABEL_61;
    }
    if ( strncmp(src.filename, ".phar/signature.bin", 0x13uLL) )
      goto LABEL_61;
    if ( (v46 & 0x100) != 0 )
    {
      free(filename);
      if ( src.uncompressed_filesize >= 0x10001 )
      {
LABEL_212:
        zend_hash_destroy(hta);
        v71 = phar;
        phar->manifest.u.flags = 8;
        zend_hash_destroy(p_mounted_dirs);
        phar->mounted_dirs.u.flags = 8;
        zend_hash_destroy(p_virtual_dirs);
        phar->virtual_dirs.u.flags = 8;
        php_stream_free(fp, 3);
        phar_metadata_tracker_free(&v71->metadata_tracker, (*((_DWORD *)v71 + 81) >> 8) & 1);
        v106 = phar->signature;
        if ( v106 )
          efree(v106);
        v107 = v141;
        if ( error )
          zend_spprintf(
            error,
            0x1000uLL,
            "phar error: %s in zip-based phar \"%s\"",
            "signatures larger than 64 KiB are not supported",
            phar->fname);
        goto LABEL_233;
      }
    }
    else
    {
      efree(filename);
      if ( src.uncompressed_filesize >= 0x10001 )
        goto LABEL_212;
    }
    php_stream_tell(fp);
    v52 = php_stream_fopen_tmpfile(0);
    if ( !v52 )
    {
      zend_hash_destroy(hta);
      v71 = phar;
      phar->manifest.u.flags = 8;
      zend_hash_destroy(p_mounted_dirs);
      phar->mounted_dirs.u.flags = 8;
      zend_hash_destroy(p_virtual_dirs);
      phar->virtual_dirs.u.flags = 8;
      php_stream_free(fp, 3);
      phar_metadata_tracker_free(&v71->metadata_tracker, (*((_DWORD *)v71 + 81) >> 8) & 1);
      v108 = phar->signature;
      if ( v108 )
        efree(v108);
      v107 = v141;
      if ( error )
        zend_spprintf(
          error,
          0x1000uLL,
          "phar error: %s in zip-based phar \"%s\"",
          "couldn't open temporary file",
          phar->fname);
LABEL_233:
      v113 = v71->fname;
      if ( (*((_BYTE *)v71 + 325) & 1) != 0 )
        free(v113);
      else
        efree(v113);
      v114 = v71->alias;
      if ( v114 )
      {
        if ( (v107[1] & 1) == 0 )
        {
          efree(v114);
          if ( (v107[1] & 1) != 0 )
            goto LABEL_242;
LABEL_117:
          lval = (char *)v71;
          goto LABEL_275;
        }
        free(v114);
      }
      if ( (v107[1] & 1) != 0 )
        goto LABEL_242;
      goto LABEL_117;
    }
    v53 = v52;
    php_stream_seek(fp, 0LL, 0);
    php_stream_copy_to_stream_ex(fp, v53, src.header_offset, 0LL);
    v54 = offset;
    php_stream_seek(fp, offset, 0);
    php_stream_copy_to_stream_ex(fp, v53, v165 - v54, 0LL);
    if ( v26 )
      php_stream_write(v53, v26, count);
    php_stream_seek(fp, src.header_offset + src.filename_len + v156 + 30, 0);
    v55 = (char *)emalloc(src.uncompressed_filesize);
    v56 = php_stream_read(fp, v55, src.uncompressed_filesize);
    if ( v56 != src.uncompressed_filesize )
    {
      php_stream_free(v53, 3);
      efree(v55);
      zend_hash_destroy(hta);
      v71 = phar;
      phar->manifest.u.flags = 8;
      zend_hash_destroy(p_mounted_dirs);
      phar->mounted_dirs.u.flags = 8;
      zend_hash_destroy(p_virtual_dirs);
      phar->virtual_dirs.u.flags = 8;
      php_stream_free(fp, 3);
      phar_metadata_tracker_free(&v71->metadata_tracker, (*((_DWORD *)v71 + 81) >> 8) & 1);
      v109 = phar->signature;
      if ( v109 )
        efree(v109);
      v107 = v141;
      if ( error )
        zend_spprintf(
          error,
          0x1000uLL,
          "phar error: %s in zip-based phar \"%s\"",
          "signature cannot be read",
          phar->fname);
      goto LABEL_233;
    }
    phar->sig_flags = *(_DWORD *)v55;
    v57 = php_stream_tell(v53);
    if ( phar_verify_signature(
           v53,
           v57,
           phar->sig_flags,
           v55 + 8,
           src.uncompressed_filesize - 8,
           fname,
           signature,
           (size_t *)pData,
           error) == -1 )
      break;
    v58 = nSize[0] + v163;
    phar->sig_len = *(_DWORD *)pData;
    php_stream_free(v53, 3);
    efree(v55);
    if ( v58 != -1 )
    {
      zend_hash_destroy(hta);
      v71 = phar;
      phar->manifest.u.flags = 8;
      zend_hash_destroy(p_mounted_dirs);
      phar->mounted_dirs.u.flags = 8;
      zend_hash_destroy(p_virtual_dirs);
      phar->virtual_dirs.u.flags = 8;
      php_stream_free(fp, 3);
      phar_metadata_tracker_free(&v71->metadata_tracker, (*((_DWORD *)v71 + 81) >> 8) & 1);
      v112 = phar->signature;
      if ( v112 )
        efree(v112);
      v107 = v141;
      if ( error )
        zend_spprintf(
          error,
          0x1000uLL,
          "phar error: %s in zip-based phar \"%s\"",
          "entries exist after signature, invalid phar",
          phar->fname);
      goto LABEL_233;
    }
    v30.lval = (zend_long)phar;
    v47 = v163;
    v36 = (char *)v149;
LABEL_43:
    v35 = (unsigned int)(v47 + 1);
    v37 = error;
    if ( !((_DWORD)v35 + nSize[0]) )
      goto LABEL_118;
  }
  efree(v55);
  if ( !error )
  {
    php_stream_free(v53, 3);
    zend_hash_destroy(hta);
    phar->manifest.u.flags = 8;
    zend_hash_destroy(p_mounted_dirs);
    phar->mounted_dirs.u.flags = 8;
    zend_hash_destroy(p_virtual_dirs);
    phar->virtual_dirs.u.flags = 8;
    php_stream_free(fp, 3);
    phar_metadata_tracker_free(&phar->metadata_tracker, (*((_DWORD *)phar + 81) >> 8) & 1);
    v121 = phar->signature;
    if ( v121 )
      efree(v121);
    v122 = phar->fname;
    if ( (*((_BYTE *)phar + 325) & 1) == 0 )
      goto LABEL_398;
    goto LABEL_282;
  }
  php_stream_free(v53, 3);
  zend_spprintf(&message, 0x1000uLL, "signature cannot be verified: %s", *error);
  efree(*error);
  zend_hash_destroy(hta);
  phar->manifest.u.flags = 8;
  zend_hash_destroy(p_mounted_dirs);
  phar->mounted_dirs.u.flags = 8;
  zend_hash_destroy(p_virtual_dirs);
  phar->virtual_dirs.u.flags = 8;
  php_stream_free(fp, 3);
  phar_metadata_tracker_free(&phar->metadata_tracker, (*((_DWORD *)phar + 81) >> 8) & 1);
  v110 = phar->signature;
  if ( v110 )
    efree(v110);
  zend_spprintf(error, 0x1000uLL, "phar error: %s in zip-based phar \"%s\"", message, phar->fname);
  v111 = phar->fname;
  if ( (*((_BYTE *)phar + 325) & 1) != 0 )
    free(v111);
  else
    efree(v111);
  v123 = phar->alias;
  if ( v123 )
  {
    if ( (v141[1] & 1) == 0 )
    {
      efree(v123);
      if ( (v141[1] & 1) != 0 )
        goto LABEL_309;
LABEL_322:
      efree(phar);
      lval = message;
      goto LABEL_275;
    }
    free(v123);
  }
  if ( (v141[1] & 1) == 0 )
    goto LABEL_322;
LABEL_309:
  free(phar);
  lval = message;
LABEL_275:
  efree(lval);
  return (unsigned int)-1;
}


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

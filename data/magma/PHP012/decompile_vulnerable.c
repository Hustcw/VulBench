php_stream *__fastcall php_stream_url_wrap_http_ex(
        php_stream_wrapper *wrapper,
        const char *path,
        char *mode,
        int options,
        zend_string **opened_path,
        php_stream_context *context,
        int redirect_max,
        zend_value_1 *flags)
{
  __int64 v9;
  php_url *v12;
  php_url *v13;
  zend_string *scheme;
  size_t len;
  zval *option;
  zend_string *lval;
  php_stream *v18;
  zend_string *v19;
  char v20;
  zval *v21;
  const char *v22;
  char *val;
  __int64 port;
  zval_1 *v25;
  double dval;
  char *v27;
  __time_t v28;
  double v29;
  unsigned __int64 v30;
  size_t v31;
  php_stream *v32;
  php_stream *v33;
  char *v34;
  zend_string *v35;
  bool v36;
  union {uint32_t type_info;} v37;
  php_stream *v38;
  zend_long long_func;
  zend_string *host;
  union {uint32_t type_info;struct {zend_uchar type;zend_uchar type_flags;union {uint16_t extra;} u;} v;} v41;
  zend_resource *ctx;
  php_stream_context *v43;
  zend_string *s;
  size_t v45;
  size_t v46;
  zend_string *v47;
  char *v48;
  size_t v49;
  size_t v50;
  size_t v51;
  zend_string *v52;
  size_t v53;
  php_url *v54;
  unsigned __int64 v55;
  char *v56;
  bool v57;
  char *v58;
  zend_string *v59;
  char *v60;
  size_t v61;
  zend_string *v62;
  size_t v63;
  zend_string *v64;
  char *v65;
  zval *v66;
  zend_uchar type;
  zend_value v68;
  _BYTE *v69;
  _BYTE *v70;
  __int64 v71;
  _BYTE *v72;
  unsigned __int64 v73;
  unsigned __int8 *v74;
  _BYTE *v75;
  __int64 v76;
  unsigned __int64 v77;
  unsigned __int8 *v78;
  size_t v79;
  size_t v80;
  php_stream_wrapper *v81;
  zend_string *v82;
  ssize_t v83;
  zend_string *v84;
  __int64 v85;
  __int64 v86;
  php_stream_filter *v87;
  size_t v88;
  int v89;
  char *v90;
  zval_1 *v91;
  int v92;
  zval *v93;
  char v94;
  zend_value v95;
  size_t v96;
  const void *v97;
  char *v98;
  size_t v99;
  __int64 v100;
  _BYTE *v101;
  size_t v102;
  char *v103;
  __int64 v104;
  zval *v105;
  zend_string *v106;
  const char *v107;
  size_t v108;
  char *v109;
  size_t v110;
  __int64 v111;
  size_t v112;
  char *v113;
  size_t v114;
  __int64 v115;
  _BYTE *v116;
  _BYTE *v117;
  php_url *v118;
  size_t v119;
  php_url *v120;
  char *v121;
  const char *v122;
  size_t v123;
  size_t v124;
  zval_1 *v125;
  double double_func;
  char *v127;
  __int64 v128;
  size_t v129;
  char *v130;
  const void *v131;
  size_t v132;
  size_t v133;
  size_t v134;
  char *v135;
  size_t v136;
  __int64 v137;
  size_t v138;
  zval *v139;
  zend_uchar v140;
  zend_string *v141;
  size_t v142;
  __int64 v143;
  __int64 v144;
  __int64 v145;
  __int64 v146;
  size_t v147;
  const void *v148;
  size_t v149;
  __int64 v150;
  __int64 v151;
  size_t v152;
  _DWORD *v153;
  size_t v154;
  const void *v155;
  size_t v156;
  char *v157;
  _DWORD *v158;
  char *v159;
  BOOL v160;
  int v161;
  int v162;
  int v163;
  int v164;
  unsigned int v165;
  size_t v166;
  char *v167;
  char *i;
  char v169;
  const char *v170;
  __int64 v171;
  unsigned __int64 v172;
  size_t v173;
  void *v174;
  php_url *v175;
  size_t v176;
  char *v177;
  zend_string *pass;
  base64_encode_func_t v179;
  _QWORD *v180;
  __int64 v181;
  size_t v182;
  const void *v183;
  size_t v184;
  size_t v185;
  size_t v186;
  char *v187;
  size_t v188;
  zend_string **v189;
  int v190;
  char *v191;
  size_t v192;
  char *v193;
  __int64 v194;
  size_t v195;
  char *v196;
  char *from_address;
  size_t v198;
  size_t v199;
  size_t v200;
  char *v201;
  size_t v202;
  char *v203;
  size_t v204;
  __int64 v205;
  size_t v206;
  char *v207;
  char *v208;
  size_t v209;
  size_t v210;
  size_t v211;
  _BYTE *v212;
  php_url *v213;
  unsigned __int16 v214;
  _QWORD *v215;
  __int64 v216;
  size_t v217;
  size_t v218;
  unsigned __int64 v219;
  char *v220;
  char *v221;
  char *v222;
  char *v223;
  __int64 v224;
  __int64 v225;
  size_t v226;
  zval *v227;
  char *user_agent;
  unsigned __int8 v229;
  size_t v230;
  size_t v231;
  char v232;
  int v233;
  size_t v234;
  char *v235;
  size_t v236;
  __int64 v237;
  zval *v238;
  zval *v239;
  char *v240;
  __int64 v241;
  size_t v242;
  unsigned __int64 v243;
  char *v244;
  char *v245;
  char *v246;
  char *v247;
  __int64 v248;
  void *v249;
  size_t v250;
  size_t v251;
  char *v252;
  size_t v253;
  __int64 v254;
  char *v255;
  size_t v256;
  php_stream_wrapper *v257;
  zval *v258;
  zval *v259;
  char *v260;
  __int64 v261;
  size_t v262;
  char v263;
  unsigned __int64 v264;
  char *v265;
  char *v266;
  char *v267;
  __int64 v268;
  char *v269;
  size_t v270;
  php_stream_wrapper *v271;
  _BYTE *v272;
  __int64 v273;
  size_t v274;
  char *v275;
  php_stream_wrapper *v276;
  __int64 v277;
  size_t v278;
  char *v279;
  zend_value v280;
  size_t v281;
  const void *v282;
  size_t v283;
  char *v284;
  __int64 v285;
  const char *v286;
  php_stream *v287;
  void *v288;
  _DWORD *v289;
  uint32_t w1;
  zend_string *v291;
  int v293;
  zval *v294;
  int is_true;
  size_t v296;
  char v297;
  size_t v298;
  zend_string *v299;
  bool v300;
  php_stream_wrapper *v301;
  php_stream_filter *v302;
  char *line;
  char v304;
  char *j;
  char *v306;
  char *v307;
  char v308;
  int v309;
  int v310;
  zval *v311;
  zval *v312;
  size_t v313;
  zend_string *v314;
  int v315;
  char v316;
  int v317;
  int v318;
  php_url *v319;
  php_stream_wrapper *v320;
  zend_string *v321;
  char *v322;
  char *v323;
  char *v324;
  size_t v325;
  __int64 v326;
  unsigned __int64 v327;
  size_t v328;
  zend_string *v329;
  size_t v330;
  size_t v331;
  zend_string *v332;
  size_t v333;
  char *v334;
  zend_string *v335;
  __int64 v336;
  php_stream_wrapper *v337;
  zend_string *user;
  __int64 v339;
  zend_string *v340;
  unsigned __int64 v341;
  char *v342;
  const unsigned __int16 *v343;
  zend_string *v344;
  __int64 v345;
  zend_string *v346;
  unsigned __int64 v347;
  char *v348;
  const unsigned __int16 *v349;
  zend_string *v350;
  __int64 v351;
  zend_string *v352;
  unsigned __int64 v353;
  char *v354;
  const unsigned __int16 *v355;
  __int64 v356;
  unsigned __int64 v357;
  size_t v358;
  zend_string *v359;
  size_t v360;
  size_t v361;
  zend_string *v362;
  size_t v363;
  void *ptr[2];
  int v365;
  zend_string **opened_patha;
  char *header_bag;
  php_url *theurl;
  char *src;
  int v370;
  __time_t v371;
  int v372;
  bool v373;
  char v374;
  size_t bytes_max;
  size_t v376;
  __int64 v377;
  php_stream_wrapper *v378;
  php_stream *v379;
  __int64 v380;
  uint32_t v381;
  zend_string *error_string;
  int v383;
  timeval timeout;
  zval optionvalue;
  char s1[9];
  char nptr[119];
  smart_str str;
  char buf[16];
  char v390[993];
  size_t returned_len[135];

  error_string = 0LL;
  *(_OWORD *)ptr = 0LL;
  s1[0] = 0;
  if ( (int)context <= 0 )
  {
    v18 = 0LL;
    php_stream_wrapper_log_error(wrapper, options, "Redirection limit reached, aborting");
    return v18;
  }
  v9 = (unsigned int)context;
  v365 = options;
  v12 = php_url_parse(path);
  if ( !v12 )
    return 0LL;
  v13 = v12;
  bytes_max = (size_t)path;
  scheme = v12->scheme;
  len = v12->scheme->len;
  theurl = v13;
  if ( len == 4 )
  {
    if ( !zend_binary_strcasecmp(scheme->val, 4uLL, "http", 4uLL) )
      goto LABEL_16;
    scheme = v13->scheme;
    len = v13->scheme->len;
  }
  if ( len != 5 || zend_binary_strcasecmp(scheme->val, 5uLL, "https", 5uLL) )
  {
    v377 = v9;
    if ( !opened_path
      || (option = php_stream_context_get_option((php_stream_context *)opened_path, wrapper->wops->label, "proxy")) == 0LL
      || option->u1.v.type != 6
      || (lval = (zend_string *)option->value.lval, !*(_QWORD *)(option->value.lval + 16)) )
    {
      php_url_free(theurl);
      return php_stream_open_wrapper_ex((const char *)bytes_max, mode, 8, 0LL, (php_stream_context *)opened_path);
    }
    v376 = 1LL;
    v370 = 0;
    if ( (lval->gc.u.type_info & 0x40) != 0 )
    {
      header_bag = (char *)1;
    }
    else
    {
      header_bag = (char *)1;
      ++lval->gc.refcount;
    }
    goto LABEL_39;
  }
LABEL_16:
  if ( strpbrk(mode, "awx+") )
  {
    v18 = 0LL;
    php_stream_wrapper_log_error(wrapper, v365, "HTTP wrapper does not support writeable connections");
    php_url_free(v13);
    return v18;
  }
  opened_patha = opened_path;
  v377 = v9;
  v19 = v13->scheme;
  if ( !v13->scheme )
  {
    v370 = 0;
    v20 = 0;
    goto LABEL_25;
  }
  v370 = 0;
  v20 = 0;
  if ( v19->len < 5 || (v370 = 0, v20 = 0, v19->val[4] != 115) )
  {
LABEL_25:
    if ( v13->port )
      goto LABEL_27;
    goto LABEL_26;
  }
  if ( v13->port )
  {
    v20 = 1;
    v370 = 1;
    if ( v13->port )
      goto LABEL_27;
LABEL_26:
    v13->port = 80;
    goto LABEL_27;
  }
  v13->port = 443;
  v20 = 1;
  v370 = 1;
LABEL_27:
  if ( opened_patha
    && (v21 = php_stream_context_get_option((php_stream_context *)opened_patha, wrapper->wops->label, "proxy")) != 0LL
    && v21->u1.v.type == 6
    && (lval = (zend_string *)v21->value.lval, *(_QWORD *)(v21->value.lval + 16)) )
  {
    v376 = 1LL;
    if ( (lval->gc.u.type_info & 0x40) == 0 )
      ++lval->gc.refcount;
  }
  else
  {
    v22 = "tcp";
    if ( v20 )
      v22 = "ssl";
    val = theurl->host->val;
    port = theurl->port;
    v376 = 0LL;
    lval = zend_strpprintf(0LL, "%s://%s:%d", v22, val, port);
    if ( !opened_patha )
    {
      v371 = 0LL;
      header_bag = 0LL;
      opened_path = 0LL;
LABEL_46:
      v27 = mode;
      timeout.tv_sec = file_globals.default_socket_timeout;
      v30 = 0LL;
      goto LABEL_47;
    }
  }
  header_bag = 0LL;
  opened_path = opened_patha;
LABEL_39:
  v25 = (zval_1 *)php_stream_context_get_option((php_stream_context *)opened_path, wrapper->wops->label, "timeout");
  if ( !v25 )
  {
    v371 = 1LL;
    goto LABEL_46;
  }
  if ( v25->u1.v.type == 5 )
    dval = v25->value.dval;
  else
    dval = zval_get_double_func(v25);
  v27 = mode;
  v28 = (unsigned int)(int)dval;
  v29 = (dval - (double)(int)v28) * 1000000.0;
  v30 = (unsigned int)(int)v29;
  timeout.tv_sec = v28;
  if ( v29 >= 9.223372036854776e18 )
    v30 = (unsigned int)(int)(v29 - 9.223372036854776e18) ^ 0x8000000000000000LL;
  LOBYTE(v28) = 1;
  v371 = v28;
LABEL_47:
  timeout.tv_usec = v30;
  v31 = lval->len;
  opened_patha = opened_path;
  v32 = php_stream_xport_create(
          lval->val,
          v31,
          v365,
          2,
          0LL,
          &timeout,
          (php_stream_context *)opened_path,
          &error_string,
          0LL);
  v33 = v32;
  if ( v32 )
    php_stream_set_option(v32, 4, 0, &timeout);
  v379 = v33;
  v34 = v27;
  if ( error_string )
  {
    php_stream_wrapper_log_error(wrapper, v365, "%s", error_string->val);
    v35 = error_string;
    if ( (error_string->gc.u.type_info & 0x40) == 0 )
    {
      v36 = error_string->gc.refcount-- == 1;
      if ( v36 )
        efree(v35);
    }
    error_string = 0LL;
  }
  v37.type_info = (uint32_t)lval->gc.u;
  if ( (v37.type_info & 0x40) == 0 )
  {
    v36 = lval->gc.refcount-- == 1;
    if ( v36 )
    {
      if ( SLOBYTE(v37.type_info) < 0 )
        free(lval);
      else
        efree(lval);
    }
  }
  src = v27;
  v378 = wrapper;
  if ( !v370 )
  {
    v38 = v379;
    goto LABEL_155;
  }
  v38 = v379;
  long_func = v377;
  if ( (_DWORD)v376 && v379 )
  {
    str = 0LL;
    if ( !(_BYTE)v371 || !php_stream_context_get_option((php_stream_context *)opened_patha, "ssl", "peer_name") )
    {
      host = theurl->host;
      optionvalue.value.lval = (zend_long)host;
      v41.type_info = 6;
      if ( (host->gc.u.type_info & 0x40) == 0 )
      {
        ++host->gc.refcount;
        v41.type_info = 262;
      }
      optionvalue.u1 = (union {uint32_t type_info;struct {zend_uchar type;zend_uchar type_flags;union {uint16_t extra;} u;} v;})v41.type_info;
      ctx = v38->ctx;
      if ( ctx )
        v43 = (php_stream_context *)ctx->ptr;
      else
        v43 = 0LL;
      php_stream_context_set_option(v43, "ssl", "peer_name", &optionvalue);
      zval_ptr_dtor((zval_1 *)&optionvalue);
    }
    s = str.s;
    if ( str.s )
    {
      v45 = str.s->len;
      v46 = v45 + 8;
      if ( v45 + 8 < str.a )
      {
LABEL_73:
        *(_QWORD *)&s->val[v45] = 0x205443454E4E4F43LL;
        v47 = str.s;
        str.s->len = v46;
        v48 = theurl->host->val;
        v49 = strlen(v48);
        v50 = v49;
        v51 = v49;
        if ( !v47 || (v51 = v46 + v49, v46 + v49 >= str.a) )
        {
          smart_str_erealloc(&str, v51);
          v47 = str.s;
          v46 = str.s->len;
        }
        memcpy(&v47->val[v46], v48, v50);
        v52 = str.s;
        str.s->len = v51;
        if ( v52 )
        {
          v53 = v51 + 1;
          v34 = src;
          v54 = theurl;
          if ( v53 < str.a )
          {
LABEL_77:
            *((_BYTE *)&v52->len + v53 + 7) = 58;
            str.s->len = v53;
            v55 = v54->port;
            v390[0] = 0;
            v56 = v390;
            do
            {
              *--v56 = (v55 % 0xA) | 0x30;
              v57 = v55 <= 9;
              v55 /= 0xAuLL;
            }
            while ( !v57 );
            v58 = (char *)(v390 - v56);
            v59 = str.s;
            v60 = (char *)(v390 - v56);
            if ( !str.s || (v61 = str.s->len, v60 = &v58[v61], (unsigned __int64)&v58[v61] >= str.a) )
            {
              smart_str_erealloc(&str, (size_t)v60);
              v59 = str.s;
              v61 = str.s->len;
            }
            memcpy(&v59->val[v61], v56, v390 - v56);
            v62 = str.s;
            str.s->len = (size_t)v60;
            if ( v62 )
            {
              v63 = (size_t)(v60 + 11);
              if ( (unsigned __int64)(v60 + 11) < str.a )
                goto LABEL_83;
            }
            else
            {
              v63 = 11LL;
            }
            smart_str_erealloc(&str, v63);
            v62 = str.s;
            v60 = (char *)str.s->len;
LABEL_83:
            *(_QWORD *)&v60[(_QWORD)v62 + 24] = 0x2E312F5054544820LL;
            *(_DWORD *)&v60[(_QWORD)v62 + 31] = 168636462;
            v64 = str.s;
            str.s->len = v63;
            if ( !(_BYTE)v371 )
              goto LABEL_136;
            v65 = v34;
            v66 = php_stream_context_get_option((php_stream_context *)opened_patha, "http", "header");
            if ( !v66 )
              goto LABEL_135;
            type = v66->u1.v.type;
            if ( type != 6 )
            {
              if ( type == 7 )
              {
                v68.lval = (zend_long)v66->value;
                if ( *(_DWORD *)(v68.lval + 24) )
                {
                  v69 = *(_BYTE **)(v68.lval + 16);
                  v70 = &v69[32 * *(unsigned int *)(v68.lval + 24)];
                  v71 = 9217LL;
                  if ( v69[8] == 6 )
                    goto LABEL_91;
                  do
                  {
LABEL_89:
                    v69 += 32;
                    if ( v69 == v70 )
                      goto LABEL_135;
                  }
                  while ( v69[8] != 6 );
LABEL_91:
                  v72 = (_BYTE *)(*(_QWORD *)v69 + 24LL);
                  while ( 1 )
                  {
                    while ( 1 )
                    {
                      LOBYTE(v73) = *v72;
                      if ( *v72 != 9 && (_BYTE)v73 != 32 )
                        break;
                      ++v72;
                    }
                    v74 = v72 + 1;
                    if ( (char)v73 <= 12 )
                      goto LABEL_99;
                    while ( 1 )
                    {
                      if ( (_BYTE)v73 == 13 )
                        goto LABEL_101;
                      if ( (_BYTE)v73 == 58 )
                        break;
                      while ( 1 )
                      {
                        LOBYTE(v73) = *v74++;
                        if ( (char)v73 > 12 )
                          break;
LABEL_99:
                        if ( !(_BYTE)v73 || (_BYTE)v73 == 10 )
                        {
LABEL_101:
                          --v74;
                          goto LABEL_108;
                        }
                      }
                    }
                    if ( v74 - v72 == 20 && !zend_binary_strcasecmp(v72, 0x14uLL, "Proxy-Authorization:", 0x14uLL) )
                    {
                      v326 = 9217LL;
                      v34 = v65;
                      while ( 1 )
                      {
                        v327 = *v74;
                        if ( v327 <= 0xD )
                        {
                          if ( _bittest64(&v326, v327) )
                            break;
                        }
                        ++v74;
                      }
                      v328 = v74 - v72;
                      v329 = str.s;
                      v330 = v328;
                      if ( !str.s || (v331 = str.s->len, v330 = v331 + v328, v331 + v328 >= str.a) )
                      {
                        smart_str_erealloc(&str, v330);
                        v329 = str.s;
                        v331 = str.s->len;
                      }
                      memcpy(&v329->val[v331], v72, v328);
                      v332 = str.s;
                      str.s->len = v330;
                      if ( v332 )
                      {
                        v333 = v330 + 2;
                        if ( v330 + 2 < str.a )
                          goto LABEL_560;
                      }
                      else
                      {
                        v333 = 2LL;
                      }
                      smart_str_erealloc(&str, v333);
                      v332 = str.s;
                      v330 = str.s->len;
LABEL_560:
                      *(_WORD *)&v332->val[v330] = 2573;
                      v64 = str.s;
                      str.s->len = v333;
                      if ( !v64 )
                      {
LABEL_561:
                        v80 = 2LL;
                        v81 = v378;
LABEL_562:
                        smart_str_erealloc(&str, v80);
                        v64 = str.s;
                        v79 = str.s->len;
LABEL_138:
                        *(_WORD *)&v64->val[v79] = 2573;
                        v82 = str.s;
                        str.s->len = v80;
                        v83 = php_stream_write(v379, v82->val, v80);
                        v84 = str.s;
                        if ( v83 == str.s->len )
                        {
                          v38 = v379;
                          if ( !str.s )
                            goto LABEL_146;
                        }
                        else
                        {
                          php_stream_wrapper_log_error(v81, v365, "Cannot connect to HTTPS server through proxy");
                          php_stream_free(v379, 3);
                          v84 = str.s;
                          v38 = 0LL;
                          if ( !str.s )
                            goto LABEL_146;
                        }
                        if ( (v84->gc.u.type_info & 0x40) == 0 )
                        {
                          v36 = v84->gc.refcount-- == 1;
                          if ( v36 )
                            efree(v84);
                        }
                        str.s = 0LL;
LABEL_146:
                        str.a = 0LL;
                        if ( v38 )
                        {
                          v85 = 9217LL;
                          while ( php_stream_get_line(v38, buf, 0x3FFuLL, 0LL)
                               && ((unsigned __int8)buf[0] > 0xDuLL || !_bittest64(&v85, (unsigned __int8)buf[0])) )
                            ;
                          if ( php_stream_xport_crypto_setup(v38, STREAM_CRYPTO_METHOD_SSLv23_CLIENT, 0LL) < 0
                            || php_stream_xport_crypto_enable(v38, 1) < 0 )
                          {
                            php_stream_wrapper_log_error(v378, v365, "Cannot connect to HTTPS server through proxy");
                            php_stream_free(v38, 3);
                            goto LABEL_154;
                          }
                        }
                        else
                        {
LABEL_154:
                          v38 = 0LL;
                        }
LABEL_155:
                        long_func = v377;
                        goto LABEL_156;
                      }
LABEL_137:
                      v79 = v64->len;
                      v80 = v79 + 2;
                      v81 = v378;
                      if ( v79 + 2 >= str.a )
                        goto LABEL_562;
                      goto LABEL_138;
                    }
                    while ( 1 )
                    {
                      v73 = *v74;
                      if ( v73 <= 0xD )
                      {
                        if ( _bittest64(&v71, v73) )
                          break;
                      }
                      ++v74;
                    }
LABEL_108:
                    v72 = v74;
                    if ( (_BYTE)v73 != 10 )
                      goto LABEL_110;
                    do
                    {
                      do
                        LOBYTE(v73) = *++v72;
                      while ( (_BYTE)v73 == 10 );
LABEL_110:
                      ;
                    }
                    while ( (_BYTE)v73 == 13 );
                    if ( !(_BYTE)v73 )
                      goto LABEL_89;
                  }
                }
              }
              goto LABEL_135;
            }
            if ( !*(_QWORD *)(v66->value.lval + 16) )
            {
LABEL_135:
              v64 = str.s;
              v34 = v65;
LABEL_136:
              if ( !v64 )
                goto LABEL_561;
              goto LABEL_137;
            }
            v75 = (_BYTE *)(v66->value.lval + 24);
            v76 = 9217LL;
            while ( 1 )
            {
              while ( 1 )
              {
                LOBYTE(v77) = *v75;
                if ( *v75 != 9 && (_BYTE)v77 != 32 )
                  break;
                ++v75;
              }
              v78 = v75 + 1;
              if ( (char)v77 <= 12 )
                goto LABEL_122;
              while ( 1 )
              {
                if ( (_BYTE)v77 == 13 )
                  goto LABEL_124;
                if ( (_BYTE)v77 == 58 )
                  break;
                while ( 1 )
                {
                  LOBYTE(v77) = *v78++;
                  if ( (char)v77 > 12 )
                    break;
LABEL_122:
                  if ( !(_BYTE)v77 || (_BYTE)v77 == 10 )
                  {
LABEL_124:
                    --v78;
                    goto LABEL_131;
                  }
                }
              }
              if ( v78 - v75 == 20 && !zend_binary_strcasecmp(v75, 0x14uLL, "Proxy-Authorization:", 0x14uLL) )
              {
                v356 = 9217LL;
                while ( 1 )
                {
                  v357 = *v78;
                  if ( v357 <= 0xD )
                  {
                    if ( _bittest64(&v356, v357) )
                      break;
                  }
                  ++v78;
                }
                v358 = v78 - v75;
                v359 = str.s;
                v360 = v358;
                if ( !str.s || (v361 = str.s->len, v360 = v361 + v358, v361 + v358 >= str.a) )
                {
                  smart_str_erealloc(&str, v360);
                  v359 = str.s;
                  v361 = str.s->len;
                }
                memcpy(&v359->val[v361], v75, v358);
                v362 = str.s;
                str.s->len = v360;
                if ( v362 )
                {
                  v363 = v360 + 2;
                  if ( v360 + 2 < str.a )
                    goto LABEL_627;
                }
                else
                {
                  v363 = 2LL;
                }
                smart_str_erealloc(&str, v363);
                v362 = str.s;
                v360 = str.s->len;
LABEL_627:
                *(_WORD *)&v362->val[v360] = 2573;
                v64 = str.s;
                str.s->len = v363;
                v34 = src;
                if ( !v64 )
                  goto LABEL_561;
                goto LABEL_137;
              }
              while ( 1 )
              {
                v77 = *v78;
                if ( v77 <= 0xD )
                {
                  if ( _bittest64(&v76, v77) )
                    break;
                }
                ++v78;
              }
LABEL_131:
              v75 = v78;
              if ( (_BYTE)v77 != 10 )
                goto LABEL_133;
              do
              {
                do
                  LOBYTE(v77) = *++v75;
                while ( (_BYTE)v77 == 10 );
LABEL_133:
                ;
              }
              while ( (_BYTE)v77 == 13 );
              if ( !(_BYTE)v77 )
                goto LABEL_135;
            }
          }
        }
        else
        {
          v53 = 1LL;
          v34 = src;
          v54 = theurl;
        }
        smart_str_erealloc(&str, v53);
        v52 = str.s;
        goto LABEL_77;
      }
    }
    else
    {
      v46 = 8LL;
    }
    smart_str_erealloc(&str, v46);
    s = str.s;
    v45 = str.s->len;
    goto LABEL_73;
  }
LABEL_156:
  if ( !v38 )
  {
    v87 = 0LL;
    v381 = 0;
    v88 = 0LL;
    v89 = 0;
    v90 = 0LL;
    v18 = 0LL;
    goto out;
  }
  if ( (v365 & 0x20) != 0 )
    v86 = php_stream_set_option(v38, 5, 1, 0LL);
  else
    v86 = 0LL;
  v380 = v86;
  v381 = v38->flags;
  v38->flags = v381 & 0xFFFFFFF3;
  php_stream_context_set(v38, (php_stream_context *)opened_patha);
  v379 = v38;
  if ( !(_BYTE)v371 )
  {
    v372 = 0;
LABEL_178:
    v94 = (char)header_bag;
    goto LABEL_179;
  }
  if ( *opened_patha )
    php_stream_notification_notify((php_stream_context *)opened_patha, 2, 0, 0LL, 0, 0LL, 0LL, 0LL);
  v372 = redirect_max;
  if ( (redirect_max & 1) != 0 )
  {
    v91 = (zval_1 *)php_stream_context_get_option((php_stream_context *)opened_patha, "http", "max_redirects");
    if ( v91 )
    {
      if ( v91->u1.v.type == 4 )
        long_func = v91->value.lval;
      else
        long_func = zval_get_long_func(v91, 0);
    }
  }
  v92 = v372;
  LOBYTE(v92) = v372 & 1;
  v372 = v92;
  v93 = php_stream_context_get_option((php_stream_context *)opened_patha, "http", "method");
  if ( !v93 )
    goto LABEL_178;
  v94 = (char)header_bag;
  if ( v93->u1.v.type == 6 )
  {
    v95.lval = (zend_long)v93->value;
    v96 = *(_QWORD *)(v93->value.lval + 16);
    if ( v96 )
    {
      if ( (redirect_max & 2) == 0 )
        goto LABEL_172;
      if ( v96 == 4 )
      {
        if ( *(_DWORD *)(v95.lval + 24) == 1145128264 )
          goto LABEL_172;
      }
      else if ( v96 == 3 && !(*(_WORD *)(v95.lval + 24) ^ 0x4547 | *(unsigned __int8 *)(v95.lval + 26) ^ 0x54) )
      {
LABEL_172:
        v97 = (const void *)(v95.lval + 24);
        v98 = (char *)ptr[0];
        v99 = v96;
        if ( !ptr[0] || (v100 = *((_QWORD *)ptr[0] + 2), v99 = v100 + v96, (void *)(v100 + v96) >= ptr[1]) )
        {
          smart_str_erealloc((smart_str *)ptr, v99);
          v98 = (char *)ptr[0];
          v100 = *((_QWORD *)ptr[0] + 2);
        }
        memcpy(&v98[v100 + 24], v97, v96);
        v101 = ptr[0];
        *((_QWORD *)ptr[0] + 2) = v99;
        if ( v101 )
        {
          v102 = v99 + 1;
          v94 = (char)header_bag;
          if ( (void *)v102 < ptr[1] )
          {
LABEL_176:
            v101[v102 + 23] = 32;
            goto LABEL_182;
          }
        }
        else
        {
          v102 = 1LL;
        }
        smart_str_erealloc((smart_str *)ptr, v102);
        v94 = (char)header_bag;
        v101 = ptr[0];
        goto LABEL_176;
      }
    }
  }
LABEL_179:
  v103 = (char *)ptr[0];
  if ( !ptr[0] )
  {
    v102 = 4LL;
    goto LABEL_616;
  }
  v104 = *((_QWORD *)ptr[0] + 2);
  v102 = v104 + 4;
  if ( (void *)(v104 + 4) >= ptr[1] )
  {
LABEL_616:
    smart_str_erealloc((smart_str *)ptr, v102);
    v94 = (char)header_bag;
    v103 = (char *)ptr[0];
    v104 = *((_QWORD *)ptr[0] + 2);
  }
  *(_DWORD *)&v103[v104 + 24] = 542393671;
LABEL_182:
  *((_QWORD *)ptr[0] + 2) = v102;
  v377 = long_func;
  v374 = v371 ^ 1;
  if ( !((unsigned __int8)v371 ^ 1 | (v94 != 0)) )
  {
    v105 = php_stream_context_get_option((php_stream_context *)opened_patha, "http", "request_fulluri");
    if ( !v105 )
      goto LABEL_186;
    v94 = zend_is_true((zval_1 *)v105) != 0;
  }
  if ( v94 )
  {
    v112 = strlen((const char *)bytes_max);
    v113 = (char *)ptr[0];
    v114 = v112;
    if ( !ptr[0] || (v115 = *((_QWORD *)ptr[0] + 2), v114 = v115 + v112, (void *)(v115 + v112) >= ptr[1]) )
    {
      smart_str_erealloc((smart_str *)ptr, v114);
      v113 = (char *)ptr[0];
      v115 = *((_QWORD *)ptr[0] + 2);
    }
    memcpy(&v113[v115 + 24], (const void *)bytes_max, v112);
    v116 = ptr[0];
    goto LABEL_203;
  }
LABEL_186:
  v106 = theurl->path;
  if ( !v106 || !v106->len )
  {
    v117 = ptr[0];
    if ( ptr[0] )
    {
      v110 = *((_QWORD *)ptr[0] + 2) + 1LL;
      if ( (void *)v110 < ptr[1] )
      {
LABEL_196:
        v117[v110 + 23] = 47;
        goto LABEL_197;
      }
    }
    else
    {
      v110 = 1LL;
    }
    smart_str_erealloc((smart_str *)ptr, v110);
    v117 = ptr[0];
    goto LABEL_196;
  }
  v107 = v106->val;
  v108 = strlen(v107);
  v109 = (char *)ptr[0];
  v110 = v108;
  if ( !ptr[0] || (v111 = *((_QWORD *)ptr[0] + 2), v110 = v111 + v108, (void *)(v111 + v108) >= ptr[1]) )
  {
    smart_str_erealloc((smart_str *)ptr, v110);
    v109 = (char *)ptr[0];
    v111 = *((_QWORD *)ptr[0] + 2);
  }
  memcpy(&v109[v111 + 24], v107, v108);
LABEL_197:
  v118 = theurl;
  v116 = ptr[0];
  *((_QWORD *)ptr[0] + 2) = v110;
  if ( !v118->query )
    goto LABEL_204;
  if ( v116 )
  {
    v119 = v110 + 1;
    v120 = theurl;
    if ( (void *)v119 < ptr[1] )
      goto LABEL_200;
  }
  else
  {
    v119 = 1LL;
    v120 = theurl;
  }
  smart_str_erealloc((smart_str *)ptr, v119);
  v116 = ptr[0];
LABEL_200:
  v116[v119 + 23] = 63;
  v121 = (char *)ptr[0];
  *((_QWORD *)ptr[0] + 2) = v119;
  v122 = v120->query->val;
  v123 = strlen(v122);
  v124 = v123;
  v114 = v123;
  if ( !v121 || (v114 = v119 + v123, (void *)(v119 + v123) >= ptr[1]) )
  {
    smart_str_erealloc((smart_str *)ptr, v114);
    v121 = (char *)ptr[0];
    v119 = *((_QWORD *)ptr[0] + 2);
  }
  memcpy(&v121[v119 + 24], v122, v124);
  v116 = ptr[0];
  v34 = src;
LABEL_203:
  *((_QWORD *)v116 + 2) = v114;
LABEL_204:
  if ( !(_BYTE)v371 )
    goto LABEL_216;
  v125 = (zval_1 *)php_stream_context_get_option((php_stream_context *)opened_patha, "http", "protocol_version");
  if ( !v125 )
  {
    v116 = ptr[0];
LABEL_216:
    if ( v116 )
    {
      v137 = *((_QWORD *)v116 + 2);
      v138 = v137 + 11;
      if ( (void *)(v137 + 11) < ptr[1] )
        goto LABEL_218;
    }
    else
    {
      v138 = 11LL;
    }
    smart_str_erealloc((smart_str *)ptr, v138);
    v116 = ptr[0];
    v137 = *((_QWORD *)ptr[0] + 2);
LABEL_218:
    *(_QWORD *)&v116[v137 + 24] = 0x2E312F5054544820LL;
    *(_DWORD *)&v116[v137 + 31] = 168636718;
    *((_QWORD *)ptr[0] + 2) = v138;
    if ( !(_BYTE)v371 )
      goto LABEL_285;
    goto LABEL_219;
  }
  if ( v125->u1.v.type == 5 )
    double_func = v125->value.dval;
  else
    double_func = zval_get_double_func(v125);
  zend_spprintf((char **)buf, 0LL, "%.1F", double_func);
  v127 = (char *)ptr[0];
  if ( !ptr[0] )
  {
    v129 = 6LL;
    goto LABEL_664;
  }
  v128 = *((_QWORD *)ptr[0] + 2);
  v129 = v128 + 6;
  if ( (void *)(v128 + 6) >= ptr[1] )
  {
LABEL_664:
    smart_str_erealloc((smart_str *)ptr, v129);
    v127 = (char *)ptr[0];
    v128 = *((_QWORD *)ptr[0] + 2);
  }
  *(_WORD *)&v127[v128 + 28] = 12112;
  *(_DWORD *)&v127[v128 + 24] = 1414809632;
  v130 = (char *)ptr[0];
  *((_QWORD *)ptr[0] + 2) = v129;
  v131 = *(const void **)buf;
  v132 = strlen(*(const char **)buf);
  v133 = v132;
  v134 = v132;
  if ( !v130 || (v134 = v129 + v132, (void *)(v129 + v132) >= ptr[1]) )
  {
    smart_str_erealloc((smart_str *)ptr, v134);
    v130 = (char *)ptr[0];
    v129 = *((_QWORD *)ptr[0] + 2);
  }
  memcpy(&v130[v129 + 24], v131, v133);
  v135 = (char *)ptr[0];
  *((_QWORD *)ptr[0] + 2) = v134;
  if ( !v135 )
  {
    v136 = 2LL;
    v34 = src;
    goto LABEL_666;
  }
  v136 = v134 + 2;
  v34 = src;
  if ( (void *)(v134 + 2) >= ptr[1] )
  {
LABEL_666:
    smart_str_erealloc((smart_str *)ptr, v136);
    v135 = (char *)ptr[0];
    v134 = *((_QWORD *)ptr[0] + 2);
  }
  *(_WORD *)&v135[v134 + 24] = 2573;
  *((_QWORD *)ptr[0] + 2) = v136;
  efree(*(void **)buf);
LABEL_219:
  v139 = php_stream_context_get_option((php_stream_context *)opened_patha, "http", "header");
  if ( !v139 )
    goto LABEL_285;
  v140 = v139->u1.v.type;
  if ( v140 == 6 )
  {
    if ( !*(_QWORD *)(v139->value.lval + 16) )
      goto LABEL_285;
    v153 = php_trim(v139->value.str, 0LL, 0LL, 3);
    if ( !v153 )
      goto LABEL_285;
    goto LABEL_236;
  }
  if ( v140 != 7 )
    goto LABEL_285;
  *(_OWORD *)buf = 0LL;
  v141 = (zend_string *)v139->value.lval;
  if ( !*(_DWORD *)v141->val )
    goto LABEL_285;
  v142 = v141->len;
  v143 = 32LL * *(unsigned int *)v141->val;
  v144 = 0LL;
  v145 = 0LL;
  if ( *(_BYTE *)(v142 + 8) == 6 )
    goto LABEL_226;
  while ( 1 )
  {
    v144 += 32LL;
    if ( v143 == v144 )
      break;
    if ( *(_BYTE *)(v142 + v144 + 8) == 6 )
    {
LABEL_226:
      v146 = *(_QWORD *)(v142 + v144);
      v147 = *(_QWORD *)(v146 + 16);
      v148 = (const void *)(v146 + 24);
      v149 = v147;
      if ( !v145 || (v150 = *(_QWORD *)(v145 + 16), v149 = v150 + v147, v150 + v147 >= *(_QWORD *)&buf[8]) )
      {
        smart_str_erealloc((smart_str *)buf, v149);
        v145 = *(_QWORD *)buf;
        v150 = *(_QWORD *)(*(_QWORD *)buf + 16LL);
      }
      memcpy((void *)(v145 + v150 + 24), v148, v147);
      v151 = *(_QWORD *)buf;
      *(_QWORD *)(*(_QWORD *)buf + 16LL) = v149;
      if ( v151 )
      {
        v152 = v149 + 2;
        if ( v149 + 2 < *(_QWORD *)&buf[8] )
          goto LABEL_230;
      }
      else
      {
        v152 = 2LL;
      }
      smart_str_erealloc((smart_str *)buf, v152);
      v151 = *(_QWORD *)buf;
      v149 = *(_QWORD *)(*(_QWORD *)buf + 16LL);
LABEL_230:
      *(_WORD *)(v151 + v149 + 24) = 2573;
      v145 = *(_QWORD *)buf;
      *(_QWORD *)(*(_QWORD *)buf + 16LL) = v152;
    }
  }
  if ( !v145 )
  {
    v34 = src;
    goto LABEL_285;
  }
  *(_BYTE *)(v145 + *(_QWORD *)(v145 + 16) + 24) = 0;
  v34 = src;
  if ( !*(_QWORD *)buf )
    goto LABEL_285;
  v153 = php_trim(*(zend_string **)buf, 0LL, 0LL, 3);
  v174 = *(void **)buf;
  if ( *(_QWORD *)buf )
  {
    if ( (*(_DWORD *)(*(_QWORD *)buf + 4LL) & 0x40) == 0 )
    {
      v36 = (**(_DWORD **)buf)-- == 1;
      if ( v36 )
        efree(v174);
    }
    *(_QWORD *)buf = 0LL;
  }
  *(_QWORD *)&buf[8] = 0LL;
  if ( !v153 )
  {
LABEL_285:
    v166 = 0LL;
    header_bag = 0LL;
    goto LABEL_286;
  }
LABEL_236:
  v154 = *((_QWORD *)v153 + 2);
  if ( !v154 )
  {
    v166 = 0LL;
    header_bag = 0LL;
    goto LABEL_566;
  }
  v155 = v153 + 6;
  header_bag = estrndup((const char *)v153 + 24, v154);
  if ( (v153[1] & 0x40) != 0 )
    goto LABEL_240;
  if ( *v153 >= 2u )
  {
    --*v153;
LABEL_240:
    v156 = *((_QWORD *)v153 + 2);
    v153 = emalloc((v156 + 32) & 0xFFFFFFFFFFFFFFF8LL);
    *(_QWORD *)v153 = 0x1600000001LL;
    *((_QWORD *)v153 + 1) = 0LL;
    *((_QWORD *)v153 + 2) = v156;
    memcpy(v153 + 6, v155, v156);
    *((_BYTE *)v153 + v156 + 24) = 0;
  }
  v157 = (char *)(v153 + 6);
  v158 = v153;
  php_strtolower((char *)v153 + 24, *((_QWORD *)v153 + 2));
  if ( (redirect_max & 1) == 0 )
  {
    v159 = header_bag;
    strip_header(header_bag, v157, "content-length:");
    strip_header(v159, v157, "content-type:");
  }
  v160 = check_has_header(v157, "user-agent:");
  v161 = v160 + 2;
  if ( !check_has_header(v157, "host:") )
    v161 = v160;
  v162 = v161 + 8;
  if ( !check_has_header(v157, "from:") )
    v162 = v161;
  v163 = v162 + 4;
  if ( !check_has_header(v157, "authorization:") )
    v163 = v162;
  v164 = v163 | 0x10;
  if ( !check_has_header(v157, "content-length:") )
    v164 = v163;
  v165 = v164 | 0x20;
  if ( !check_has_header(v157, "content-type:") )
    v165 = v164;
  v166 = v165 | 0x40;
  if ( !check_has_header(v157, "connection:") )
    v166 = v165;
  if ( v370 )
  {
    if ( (_DWORD)v376 )
    {
      v167 = strstr(v157, "proxy-authorization:");
      if ( v167 )
      {
        if ( v167 == v157 || *(v167 - 1) == 10 )
        {
          for ( i = v167; i > v157; --i )
          {
            v169 = *(i - 1);
            if ( v169 != 32 && v169 != 9 )
              break;
          }
          v170 = v167 + 20;
          v171 = 9217LL;
          while ( 1 )
          {
            v172 = *(unsigned __int8 *)v170;
            if ( v172 <= 0xD )
            {
              if ( _bittest64(&v171, v172) )
                break;
            }
            ++v170;
          }
          while ( (_BYTE)v172 == 10 || (_BYTE)v172 == 13 )
            LOBYTE(v172) = *++v170;
          v173 = v166;
          if ( (_BYTE)v172 )
          {
            v323 = &header_bag[i - v157];
            v324 = &header_bag[v170 - v157];
            v325 = strlen(v170);
            memmove(v323, v324, v325 + 1);
          }
          else
          {
            if ( i != v157 )
            {
              for ( ; i > v157; --i )
              {
                v297 = *(i - 1);
                if ( v297 != 13 && v297 != 10 )
                  break;
              }
              header_bag[i - v157] = 0;
              goto LABEL_565;
            }
            efree(header_bag);
            header_bag = 0LL;
          }
          v166 = v173;
        }
      }
    }
  }
LABEL_565:
  v153 = v158;
  v34 = src;
  if ( v158 )
  {
LABEL_566:
    if ( (v153[1] & 0x40) == 0 )
    {
      v36 = (*v153)-- == 1;
      if ( v36 )
        efree(v153);
    }
  }
  if ( (v166 & 4) == 0 )
  {
LABEL_286:
    v175 = theurl;
    if ( !theurl->user )
      goto LABEL_303;
    v376 = v166;
    v176 = strlen((const char *)bytes_max);
    v177 = (char *)emalloc(v176 + 1);
    php_url_decode(v175->user->val, v175->user->len);
    strcpy(v177, v175->user->val);
    *(_WORD *)&v177[strlen(v177)] = 58;
    pass = v175->pass;
    if ( pass )
    {
      php_url_decode(pass->val, pass->len);
      strcat(v177, v175->pass->val);
    }
    strlen(v177);
    v179 = j_resolve_base64_encode();
    v180 = ptr[0];
    if ( ptr[0] )
    {
      v181 = *((_QWORD *)ptr[0] + 2);
      v182 = v181 + 21;
      if ( (void *)(v181 + 21) < ptr[1] )
      {
LABEL_291:
        qmemcpy((char *)v180 + v181 + 24, "Authorization: Basic ", 21);
        v180[2] = v182;
        bytes_max = (size_t)v179;
        v183 = (char *)v179 + 24;
        v184 = strlen((const char *)v179 + 24);
        v185 = v184;
        v186 = v184;
        if ( !v180 || (v186 = v182 + v184, (void *)(v182 + v184) >= ptr[1]) )
        {
          smart_str_erealloc((smart_str *)ptr, v186);
          v180 = ptr[0];
          v182 = *((_QWORD *)ptr[0] + 2);
        }
        memcpy((char *)v180 + v182 + 24, v183, v185);
        v187 = (char *)ptr[0];
        *((_QWORD *)ptr[0] + 2) = v186;
        if ( v187 )
        {
          v188 = v186 + 2;
          v34 = src;
          v189 = opened_patha;
          if ( (void *)(v186 + 2) < ptr[1] )
            goto LABEL_295;
        }
        else
        {
          v188 = 2LL;
          v34 = src;
          v189 = opened_patha;
        }
        smart_str_erealloc((smart_str *)ptr, v188);
        v187 = (char *)ptr[0];
        v186 = *((_QWORD *)ptr[0] + 2);
LABEL_295:
        *(_WORD *)&v187[v186 + 24] = 2573;
        *((_QWORD *)ptr[0] + 2) = v188;
        if ( (_BYTE)v371 && *v189 )
          php_stream_notification_notify((php_stream_context *)v189, 3, 0, 0LL, 0, 0LL, 0LL, 0LL);
        v190 = *(_DWORD *)(bytes_max + 4);
        if ( (v190 & 0x40) == 0 )
        {
          if ( (v190 & 0x80u) != 0 )
            free((void *)bytes_max);
          else
            efree((void *)bytes_max);
        }
        efree(v177);
        v166 = v376;
        goto LABEL_303;
      }
    }
    else
    {
      v182 = 21LL;
    }
    smart_str_erealloc((smart_str *)ptr, v182);
    v180 = ptr[0];
    v181 = *((_QWORD *)ptr[0] + 2);
    goto LABEL_291;
  }
LABEL_303:
  v191 = v34;
  if ( (v166 & 8) != 0 || !file_globals.from_address )
    goto LABEL_312;
  v192 = v166;
  v193 = (char *)ptr[0];
  if ( !ptr[0] )
  {
    v195 = 6LL;
    goto LABEL_647;
  }
  v194 = *((_QWORD *)ptr[0] + 2);
  v195 = v194 + 6;
  if ( (void *)(v194 + 6) >= ptr[1] )
  {
LABEL_647:
    smart_str_erealloc((smart_str *)ptr, v195);
    v193 = (char *)ptr[0];
    v194 = *((_QWORD *)ptr[0] + 2);
  }
  *(_WORD *)&v193[v194 + 28] = 8250;
  *(_DWORD *)&v193[v194 + 24] = 1836020294;
  v196 = (char *)ptr[0];
  *((_QWORD *)ptr[0] + 2) = v195;
  from_address = file_globals.from_address;
  v198 = strlen(from_address);
  v199 = v198;
  v200 = v198;
  if ( !v196 || (v200 = v195 + v198, (void *)(v195 + v198) >= ptr[1]) )
  {
    smart_str_erealloc((smart_str *)ptr, v200);
    v196 = (char *)ptr[0];
    v195 = *((_QWORD *)ptr[0] + 2);
  }
  memcpy(&v196[v195 + 24], from_address, v199);
  v201 = (char *)ptr[0];
  *((_QWORD *)ptr[0] + 2) = v200;
  if ( v201 )
  {
    v202 = v200 + 2;
    v191 = src;
    v166 = v192;
    if ( (void *)(v200 + 2) < ptr[1] )
      goto LABEL_311;
  }
  else
  {
    v202 = 2LL;
    v191 = src;
    v166 = v192;
  }
  smart_str_erealloc((smart_str *)ptr, v202);
  v201 = (char *)ptr[0];
  v200 = *((_QWORD *)ptr[0] + 2);
LABEL_311:
  *(_WORD *)&v201[v200 + 24] = 2573;
  *((_QWORD *)ptr[0] + 2) = v202;
LABEL_312:
  if ( (v166 & 2) != 0 )
  {
    if ( (v166 & 0x40) != 0 )
      goto LABEL_338;
LABEL_322:
    v215 = ptr[0];
    if ( ptr[0] )
    {
      v216 = *((_QWORD *)ptr[0] + 2);
      v217 = v216 + 19;
      if ( (void *)(v216 + 19) < ptr[1] )
        goto LABEL_324;
    }
    else
    {
      v217 = 19LL;
    }
    smart_str_erealloc((smart_str *)ptr, v217);
    v215 = ptr[0];
    v216 = *((_QWORD *)ptr[0] + 2);
LABEL_324:
    *(_OWORD *)((char *)v215 + v216 + 24) = xmmword_8B0C9A;
    *(_DWORD *)((char *)v215 + v216 + 39) = 168650099;
    v215[2] = v217;
    if ( (_BYTE)v371 )
      goto LABEL_339;
    goto LABEL_342;
  }
  v203 = (char *)ptr[0];
  v204 = v166;
  if ( !ptr[0] )
  {
    v206 = 6LL;
    goto LABEL_651;
  }
  v205 = *((_QWORD *)ptr[0] + 2);
  v206 = v205 + 6;
  if ( (void *)(v205 + 6) >= ptr[1] )
  {
LABEL_651:
    smart_str_erealloc((smart_str *)ptr, v206);
    v203 = (char *)ptr[0];
    v205 = *((_QWORD *)ptr[0] + 2);
  }
  *(_WORD *)&v203[v205 + 28] = 8250;
  *(_DWORD *)&v203[v205 + 24] = 1953722184;
  v207 = (char *)ptr[0];
  *((_QWORD *)ptr[0] + 2) = v206;
  v208 = theurl->host->val;
  v209 = strlen(v208);
  v210 = v209;
  v211 = v209;
  if ( !v207 || (v211 = v206 + v209, (void *)(v206 + v209) >= ptr[1]) )
  {
    smart_str_erealloc((smart_str *)ptr, v211);
    v207 = (char *)ptr[0];
    v206 = *((_QWORD *)ptr[0] + 2);
  }
  memcpy(&v207[v206 + 24], v208, v210);
  v212 = ptr[0];
  *((_QWORD *)ptr[0] + 2) = v211;
  v213 = theurl;
  v214 = theurl->port;
  if ( !v370 )
  {
    v191 = src;
    v166 = v204;
    if ( !v214 || v214 == 80 )
      goto LABEL_335;
LABEL_328:
    v376 = v166;
    if ( v212 )
    {
      v218 = v211 + 1;
      if ( (void *)v218 < ptr[1] )
        goto LABEL_330;
    }
    else
    {
      v218 = 1LL;
    }
    smart_str_erealloc((smart_str *)ptr, v218);
    v212 = ptr[0];
LABEL_330:
    v212[v218 + 23] = 58;
    *((_QWORD *)ptr[0] + 2) = v218;
    v219 = v213->port;
    v390[0] = 0;
    v220 = v390;
    do
    {
      *--v220 = (v219 % 0xA) | 0x30;
      v57 = v219 <= 9;
      v219 /= 0xAuLL;
    }
    while ( !v57 );
    v221 = (char *)(v390 - v220);
    v222 = (char *)ptr[0];
    v223 = (char *)(v390 - v220);
    if ( !ptr[0] || (v224 = *((_QWORD *)ptr[0] + 2), v223 = &v221[v224], &v221[v224] >= ptr[1]) )
    {
      smart_str_erealloc((smart_str *)ptr, (size_t)v223);
      v222 = (char *)ptr[0];
      v224 = *((_QWORD *)ptr[0] + 2);
    }
    memcpy(&v222[v224 + 24], v220, v390 - v220);
    v212 = ptr[0];
    *((_QWORD *)ptr[0] + 2) = v223;
    LOBYTE(v166) = v376;
    goto LABEL_335;
  }
  v191 = src;
  v166 = v204;
  if ( v214 && v214 != 443 )
    goto LABEL_328;
LABEL_335:
  if ( v212 )
  {
    v225 = *((_QWORD *)v212 + 2);
    v226 = v225 + 2;
    if ( (void *)(v225 + 2) < ptr[1] )
      goto LABEL_337;
  }
  else
  {
    v226 = 2LL;
  }
  smart_str_erealloc((smart_str *)ptr, v226);
  v212 = ptr[0];
  v225 = *((_QWORD *)ptr[0] + 2);
LABEL_337:
  *(_WORD *)&v212[v225 + 24] = 2573;
  *((_QWORD *)ptr[0] + 2) = v226;
  if ( (v166 & 0x40) == 0 )
    goto LABEL_322;
LABEL_338:
  if ( !(_BYTE)v371 )
  {
LABEL_342:
    user_agent = file_globals.user_agent;
    goto LABEL_343;
  }
LABEL_339:
  v227 = php_stream_context_get_option((php_stream_context *)opened_patha, "http", "user_agent");
  if ( !v227 || v227->u1.v.type != 6 )
    goto LABEL_342;
  user_agent = (char *)(v227->value.lval + 24);
LABEL_343:
  v34 = v191;
  v229 = v372;
  if ( (v166 & 1) == 0 )
  {
    if ( user_agent )
    {
      v230 = strlen(user_agent);
      v231 = v230 + 17;
      if ( v230 + 17 >= 0x12 )
      {
        v232 = v166;
        v166 = (size_t)emalloc(v230 + 18);
        v233 = ap_php_slprintf((char *)v166, v231, "User-Agent: %s\r\n", user_agent);
        if ( v233 )
        {
          v234 = v233;
          *(_BYTE *)(v166 + v233) = 0;
          v235 = (char *)ptr[0];
          v236 = v234;
          if ( !ptr[0] || (v237 = *((_QWORD *)ptr[0] + 2), v236 = v237 + v234, (void *)(v237 + v234) >= ptr[1]) )
          {
            smart_str_erealloc((smart_str *)ptr, v236);
            v235 = (char *)ptr[0];
            v237 = *((_QWORD *)ptr[0] + 2);
          }
          memcpy(&v235[v237 + 24], (const void *)v166, v234);
          *((_QWORD *)ptr[0] + 2) = v236;
        }
        else
        {
          php_error_docref(0LL, 2, "Cannot construct User-agent header");
        }
        efree((void *)v166);
        LOBYTE(v166) = v232;
        v34 = src;
      }
    }
  }
  if ( !header_bag )
    goto LABEL_371;
  if ( ((unsigned __int8)(v166 & 0x10) >> 4) | v229 ^ 1 )
    goto LABEL_366;
  v238 = php_stream_context_get_option((php_stream_context *)opened_patha, "http", "content");
  if ( !v238 )
    goto LABEL_366;
  v239 = v238;
  if ( v238->u1.v.type != 6 || !*(_QWORD *)(v238->value.lval + 16) )
    goto LABEL_366;
  v240 = (char *)ptr[0];
  if ( !ptr[0] )
  {
    v242 = 16LL;
    goto LABEL_680;
  }
  v241 = *((_QWORD *)ptr[0] + 2);
  v242 = v241 + 16;
  if ( (void *)(v241 + 16) >= ptr[1] )
  {
LABEL_680:
    smart_str_erealloc((smart_str *)ptr, v242);
    v240 = (char *)ptr[0];
    v241 = *((_QWORD *)ptr[0] + 2);
  }
  *(_OWORD *)&v240[v241 + 24] = xmmword_8B0CE2;
  *((_QWORD *)ptr[0] + 2) = v242;
  v243 = *(_QWORD *)(v239->value.lval + 16);
  v390[0] = 0;
  v244 = v390;
  do
  {
    *--v244 = (v243 % 0xA) | 0x30;
    v57 = v243 <= 9;
    v243 /= 0xAuLL;
  }
  while ( !v57 );
  v245 = (char *)(v390 - v244);
  v246 = (char *)ptr[0];
  v247 = (char *)(v390 - v244);
  if ( !ptr[0] || (v248 = *((_QWORD *)ptr[0] + 2), v247 = &v245[v248], &v245[v248] >= ptr[1]) )
  {
    smart_str_erealloc((smart_str *)ptr, (size_t)v247);
    v246 = (char *)ptr[0];
    v248 = *((_QWORD *)ptr[0] + 2);
  }
  memcpy(&v246[v248 + 24], v244, v390 - v244);
  v249 = ptr[0];
  *((_QWORD *)ptr[0] + 2) = v247;
  if ( v249 )
  {
    v250 = (size_t)(v247 + 2);
    if ( v247 + 2 < ptr[1] )
      goto LABEL_365;
  }
  else
  {
    v250 = 2LL;
  }
  smart_str_erealloc((smart_str *)ptr, v250);
  v249 = ptr[0];
  v247 = (char *)*((_QWORD *)ptr[0] + 2);
LABEL_365:
  *(_WORD *)&v247[(_QWORD)v249 + 24] = 2573;
  *((_QWORD *)ptr[0] + 2) = v250;
  LOBYTE(v166) = v166 | 0x10;
  v229 = v372;
LABEL_366:
  v251 = strlen(header_bag);
  v252 = (char *)ptr[0];
  v253 = v251;
  if ( !ptr[0] || (v254 = *((_QWORD *)ptr[0] + 2), v253 = v254 + v251, (void *)(v254 + v251) >= ptr[1]) )
  {
    smart_str_erealloc((smart_str *)ptr, v253);
    v252 = (char *)ptr[0];
    v254 = *((_QWORD *)ptr[0] + 2);
  }
  memcpy(&v252[v254 + 24], header_bag, v251);
  v255 = (char *)ptr[0];
  *((_QWORD *)ptr[0] + 2) = v253;
  if ( v255 )
  {
    v256 = v253 + 2;
    if ( (void *)(v253 + 2) < ptr[1] )
      goto LABEL_370;
  }
  else
  {
    v256 = 2LL;
  }
  smart_str_erealloc((smart_str *)ptr, v256);
  v255 = (char *)ptr[0];
  v253 = *((_QWORD *)ptr[0] + 2);
LABEL_370:
  *(_WORD *)&v255[v253 + 24] = 2573;
  *((_QWORD *)ptr[0] + 2) = v256;
  efree(header_bag);
LABEL_371:
  v257 = v378;
  if ( !v229
    || (v258 = php_stream_context_get_option((php_stream_context *)opened_patha, "http", "content")) == 0LL
    || (v259 = v258, v258->u1.v.type != 6)
    || !*(_QWORD *)(v258->value.lval + 16) )
  {
    v284 = (char *)ptr[0];
    if ( ptr[0] )
    {
      v285 = *((_QWORD *)ptr[0] + 2);
      v283 = v285 + 2;
      if ( (void *)(v285 + 2) < ptr[1] )
      {
LABEL_396:
        *(_WORD *)&v284[v285 + 24] = 2573;
        goto LABEL_397;
      }
    }
    else
    {
      v283 = 2LL;
    }
    smart_str_erealloc((smart_str *)ptr, v283);
    v284 = (char *)ptr[0];
    v285 = *((_QWORD *)ptr[0] + 2);
    goto LABEL_396;
  }
  if ( (v166 & 0x10) != 0 )
    goto LABEL_385;
  v260 = (char *)ptr[0];
  if ( !ptr[0] )
  {
    v262 = 16LL;
    goto LABEL_684;
  }
  v261 = *((_QWORD *)ptr[0] + 2);
  v262 = v261 + 16;
  if ( (void *)(v261 + 16) >= ptr[1] )
  {
LABEL_684:
    smart_str_erealloc((smart_str *)ptr, v262);
    v260 = (char *)ptr[0];
    v261 = *((_QWORD *)ptr[0] + 2);
  }
  v263 = v166;
  *(_OWORD *)&v260[v261 + 24] = xmmword_8B0CE2;
  *((_QWORD *)ptr[0] + 2) = v262;
  v264 = *(_QWORD *)(v259->value.lval + 16);
  v390[0] = 0;
  v265 = v390;
  do
  {
    *--v265 = (v264 % 0xA) | 0x30;
    v57 = v264 <= 9;
    v264 /= 0xAuLL;
  }
  while ( !v57 );
  v266 = (char *)(v390 - v265);
  v267 = (char *)ptr[0];
  v166 = v390 - v265;
  if ( !ptr[0] || (v268 = *((_QWORD *)ptr[0] + 2), v166 = (size_t)&v266[v268], &v266[v268] >= ptr[1]) )
  {
    smart_str_erealloc((smart_str *)ptr, v166);
    v267 = (char *)ptr[0];
    v268 = *((_QWORD *)ptr[0] + 2);
  }
  memcpy(&v267[v268 + 24], v265, v390 - v265);
  v269 = (char *)ptr[0];
  *((_QWORD *)ptr[0] + 2) = v166;
  if ( v269 )
  {
    v270 = v166 + 2;
    if ( (void *)(v166 + 2) < ptr[1] )
      goto LABEL_384;
  }
  else
  {
    v270 = 2LL;
  }
  smart_str_erealloc((smart_str *)ptr, v270);
  v269 = (char *)ptr[0];
  v166 = *((_QWORD *)ptr[0] + 2);
LABEL_384:
  *(_WORD *)&v269[v166 + 24] = 2573;
  *((_QWORD *)ptr[0] + 2) = v270;
  v257 = v378;
  LOBYTE(v166) = v263;
LABEL_385:
  if ( (v166 & 0x20) == 0 )
  {
    v271 = v257;
    v272 = ptr[0];
    if ( ptr[0] )
    {
      v273 = *((_QWORD *)ptr[0] + 2);
      v274 = v273 + 49;
      if ( (void *)(v273 + 49) < ptr[1] )
        goto LABEL_388;
    }
    else
    {
      v274 = 49LL;
    }
    smart_str_erealloc((smart_str *)ptr, v274);
    v272 = ptr[0];
    v273 = *((_QWORD *)ptr[0] + 2);
LABEL_388:
    *(_OWORD *)&v272[v273 + 56] = xmmword_8B0D13;
    *(_OWORD *)&v272[v273 + 40] = xmmword_8B0D03;
    *(_OWORD *)&v272[v273 + 24] = xmmword_8B0CF3;
    v272[v273 + 72] = 10;
    *((_QWORD *)v272 + 2) = v274;
    php_error_docref(0LL, 8, "Content-type not specified assuming application/x-www-form-urlencoded");
    v257 = v271;
  }
  v275 = (char *)ptr[0];
  v276 = v257;
  if ( !ptr[0] )
  {
    v278 = 2LL;
    goto LABEL_676;
  }
  v277 = *((_QWORD *)ptr[0] + 2);
  v278 = v277 + 2;
  if ( (void *)(v277 + 2) >= ptr[1] )
  {
LABEL_676:
    smart_str_erealloc((smart_str *)ptr, v278);
    v275 = (char *)ptr[0];
    v277 = *((_QWORD *)ptr[0] + 2);
  }
  *(_WORD *)&v275[v277 + 24] = 2573;
  v279 = (char *)ptr[0];
  *((_QWORD *)ptr[0] + 2) = v278;
  v280.lval = (zend_long)v259->value;
  v281 = *(_QWORD *)(v259->value.lval + 16);
  v282 = (const void *)(v280.lval + 24);
  v283 = v281;
  if ( !v279 || (v283 = v281 + v278, (void *)(v281 + v278) >= ptr[1]) )
  {
    smart_str_erealloc((smart_str *)ptr, v283);
    v279 = (char *)ptr[0];
    v278 = *((_QWORD *)ptr[0] + 2);
  }
  memcpy(&v279[v278 + 24], v282, v281);
  v257 = v276;
LABEL_397:
  v286 = (const char *)ptr[0];
  *((_QWORD *)ptr[0] + 2) = v283;
  v287 = v379;
  php_stream_write(v379, v286 + 24, v283);
  buf[0] = 0;
  if ( !LOBYTE(flags[1].dval) )
  {
    flags->lval = (zend_long)zend_new_array_0();
    flags[1].ww.w1 = 775;
  }
  v381 &= 0xCu;
  if ( php_stream_eof(v287) || !php_stream_get_line(v287, s1, 0x7FuLL, returned_len) )
  {
    php_stream_free(v287, 3);
    v87 = 0LL;
    php_stream_wrapper_log_error(v257, v365, "HTTP request failed!");
    v88 = 0LL;
    v90 = 0LL;
LABEL_401:
    v18 = 0LL;
    goto LABEL_402;
  }
  v293 = 0;
  if ( returned_len[0] >= 0xA )
    v293 = atoi(nptr);
  if ( (_BYTE)v371
    && (v294 = php_stream_context_get_option((php_stream_context *)opened_patha, "http", "ignore_errors")) != 0LL )
  {
    is_true = zend_is_true((zval_1 *)v294);
    LOBYTE(is_true) = is_true != 0;
  }
  else
  {
    is_true = 0;
  }
  v372 = is_true;
  LODWORD(v376) = ((unsigned int)v365 >> 9) & 1;
  LODWORD(header_bag) = v376 | (unsigned __int8)is_true;
  if ( v293 == 101 || (unsigned int)(v293 - 100) > 0x63 )
  {
LABEL_438:
    if ( (unsigned int)(v293 - 200) >= 0xC8 )
    {
      if ( v293 != 403 )
      {
        v296 = returned_len[0];
        goto LABEL_461;
      }
      v293 = 403;
      if ( (_BYTE)v371 && *opened_patha )
      {
        v293 = 403;
        php_stream_notification_notify((php_stream_context *)opened_patha, 10, 2, s1, 403, 0LL, 0LL, 0LL);
      }
    }
    else
    {
      LODWORD(header_bag) = 1;
    }
  }
  else
  {
    if ( !php_stream_eof(v287) )
    {
      while ( php_stream_get_line(v287, s1, 0x7FuLL, returned_len) )
      {
        v296 = returned_len[0];
        if ( returned_len[0] >= 6 && !strncasecmp(s1, "HTTP/1", 6uLL) )
          goto LABEL_436;
        v287 = v379;
        if ( php_stream_eof(v379) )
          break;
      }
    }
    v296 = returned_len[0];
LABEL_436:
    v293 = 0;
    if ( v296 >= 0xA )
    {
      v293 = atoi(nptr);
      goto LABEL_438;
    }
LABEL_461:
    if ( !v296 )
      s1[0] = 0;
    if ( (_BYTE)v371 && *opened_patha )
      php_stream_notification_notify((php_stream_context *)opened_patha, 9, 2, s1, v293, 0LL, 0LL, 0LL);
  }
  v298 = returned_len[0];
  if ( *((_BYTE *)&optionvalue.u2.opline_num + returned_len[0] + 3) == 10 )
  {
    v298 = returned_len[0] - 1;
    if ( *((_BYTE *)&optionvalue.u2.cache_slot + returned_len[0] + 2) == 13 )
      v298 = returned_len[0] - 2;
    returned_len[0] = v298;
  }
  v299 = (zend_string *)emalloc((v298 + 32) & 0xFFFFFFFFFFFFFFF8LL);
  v299->gc = (zend_refcounted_h)0x1600000001LL;
  v299->h = 0LL;
  v299->len = v298;
  memcpy(v299->val, s1, v298);
  v299->val[v298] = 0;
  str.s = v299;
  LODWORD(str.a) = 262;
  zend_hash_next_index_insert(flags->arr, (zval *)&str);
  v18 = v379;
  if ( php_stream_eof(v379) )
  {
    v300 = 1;
    v87 = 0LL;
    bytes_max = 0LL;
    v90 = 0LL;
    v301 = v378;
    goto LABEL_521;
  }
  v383 = v365 & 0x200;
  v373 = (v293 & 0xFFFFFFFC) == 300 || (unsigned int)(v293 - 307) < 2;
  v300 = 1;
  v90 = 0LL;
  bytes_max = 0LL;
  v302 = 0LL;
  v301 = v378;
  while ( 2 )
  {
    if ( v90 )
      efree(v90);
    line = php_stream_get_line(v18, 0LL, 0LL, returned_len);
    v90 = line;
    if ( line )
    {
      v304 = *line;
      if ( *v90 != 10 && v304 != 13 )
      {
        for ( j = &v90[returned_len[0] - 1]; j >= v90; --j )
        {
          if ( *j != 13 && *j != 10 )
            break;
        }
        while ( j >= v90 && (*j == 32 || *j == 9) )
          --j;
        v306 = j + 1;
        j[1] = 0;
        returned_len[0] = j + 1 - v90;
        v307 = (char *)memchr(v90, 58, returned_len[0]);
        if ( v307 )
        {
          if ( v307 < j )
          {
            do
            {
              v308 = v307[1];
              if ( v308 != 32 && v308 != 9 )
                break;
              ++v307;
            }
            while ( j != v307 );
          }
          v306 = v307 + 1;
        }
        if ( !strncasecmp(v90, "Location:", 9uLL) )
        {
          if ( (_BYTE)v371
            && (v312 = php_stream_context_get_option((php_stream_context *)opened_patha, "http", "follow_location")) != 0LL )
          {
            v300 = zend_is_true((zval_1 *)v312) != 0;
          }
          else if ( !v373 )
          {
            v300 = 0;
          }
          php_strlcpy(buf, v306, 0x400uLL);
        }
        else
        {
          v309 = strncasecmp(v90, "Content-Type:", 0xDuLL);
          v18 = v379;
          if ( v309 )
          {
            if ( strncasecmp(v90, "Content-Length:", 0xFuLL) )
            {
              if ( strncasecmp(v90, "Transfer-Encoding:", 0x12uLL) )
                goto LABEL_517;
              v310 = strncasecmp(v306, "Chunked", 7uLL);
              if ( v383 | v310 )
                goto LABEL_517;
              if ( (_BYTE)v371 )
              {
                v311 = php_stream_context_get_option((php_stream_context *)opened_patha, "http", "auto_decode");
                if ( v311 )
                {
                  if ( !zend_is_true((zval_1 *)v311) )
                    goto LABEL_517;
                }
              }
              v87 = php_stream_filter_create("dechunk", 0LL, *((_BYTE *)v18 + 96) & 1);
              v302 = 0LL;
              if ( !v87 )
                goto LABEL_517;
LABEL_518:
              v315 = php_stream_eof(v18);
              v302 = v87;
              v301 = v378;
              if ( v315 )
                goto LABEL_521;
              continue;
            }
            bytes_max = atoi(v306);
            if ( (_BYTE)v371 && *opened_patha )
              php_stream_notification_notify((php_stream_context *)opened_patha, 5, 0, v90, 0, 0LL, bytes_max, 0LL);
          }
          else if ( (_BYTE)v371 && *opened_patha )
          {
            php_stream_notification_notify((php_stream_context *)opened_patha, 4, 0, v306, 0, 0LL, 0LL, 0LL);
          }
        }
LABEL_517:
        v313 = returned_len[0];
        v314 = (zend_string *)emalloc((returned_len[0] + 32) & 0xFFFFFFFFFFFFFFF8LL);
        v314->gc = (zend_refcounted_h)0x1600000001LL;
        v314->h = 0LL;
        v314->len = v313;
        memcpy(v314->val, v90, v313);
        v314->val[v313] = 0;
        str.s = v314;
        v18 = v379;
        LODWORD(str.a) = 262;
        zend_hash_next_index_insert(flags->arr, (zval *)&str);
        v87 = v302;
        goto LABEL_518;
      }
    }
    break;
  }
  v87 = v302;
LABEL_521:
  if ( !(_DWORD)header_bag )
  {
    v36 = !v300;
    v34 = src;
    v88 = bytes_max;
    if ( v36 )
      goto LABEL_402;
    goto LABEL_526;
  }
  v34 = src;
  if ( !v300 )
    goto LABEL_611;
  v88 = bytes_max;
  if ( !buf[0] )
    goto LABEL_402;
LABEL_526:
  if ( (int)v377 <= 1 && ((_BYTE)v372 != 0) | (unsigned __int8)v376 )
  {
LABEL_402:
    v89 = v380;
    goto out;
  }
  v374 |= buf[0] == 0;
  if ( !v374 && *opened_patha )
    php_stream_notification_notify((php_stream_context *)opened_patha, 6, 0, buf, 0, 0LL, 0LL, 0LL);
  php_stream_free(v18, 3);
  if ( v87 )
    php_stream_filter_free(v87);
  v316 = buf[0];
  if ( !buf[0] )
  {
    v87 = 0LL;
    php_stream_wrapper_log_error(v301, v365, "HTTP request failed! %s", s1);
    goto LABEL_401;
  }
  LOBYTE(str.s) = 0;
  if ( strlen(buf) >= 8
    && (!strncasecmp(buf, "http://", 7uLL)
     || !strncasecmp(buf, "https://", 8uLL)
     || !strncasecmp(buf, "ftp://", 6uLL)
     || !strncasecmp(buf, "ftps://", 7uLL)) )
  {
    php_strlcpy((char *)&str, buf, 0x400uLL);
    v317 = v365;
    v319 = theurl;
    v318 = v377;
    goto LABEL_589;
  }
  v317 = v365;
  v318 = v377;
  if ( v316 == 47 )
  {
    php_strlcpy((char *)returned_len, buf, 0x400uLL);
  }
  else
  {
    v320 = v301;
    if ( buf[1] && (v321 = theurl->path) != 0LL )
    {
      v322 = strrchr(v321->val, 47);
      if ( !v322 )
      {
        if ( v321->len )
        {
          v321->val[0] = 47;
          v322 = v321->val;
        }
        else
        {
          if ( (v321->gc.u.type_info & 0x40) == 0 )
          {
            v36 = v321->gc.refcount-- == 1;
            if ( v36 )
              efree(v321);
          }
          v334 = (char *)emalloc_32();
          *(_QWORD *)v334 = 0x1600000001LL;
          *(_OWORD *)(v334 + 8) = xmmword_7C96C0;
          *((_WORD *)v334 + 12) = 47;
          theurl->path = (zend_string *)v334;
          v322 = v334 + 24;
          v317 = v365;
        }
      }
      v322[1] = 0;
      v335 = theurl->path;
      if ( v335 && v335->val[0] == 47 && !v335->val[1] )
        ap_php_snprintf((char *)returned_len, 0x3FFuLL, "%s%s", v335->val, buf);
      else
        ap_php_snprintf((char *)returned_len, 0x3FFuLL, "%s/%s", v335->val, buf);
      v34 = src;
      v301 = v320;
      v318 = v377;
    }
    else
    {
      ap_php_snprintf((char *)returned_len, 0x3FFuLL, "/%s", buf);
      v301 = v320;
    }
  }
  v336 = theurl->port;
  if ( v370 )
  {
    if ( (_DWORD)v336 == 443 )
      goto LABEL_586;
LABEL_588:
    v319 = theurl;
    ap_php_snprintf(
      (char *)&str,
      0x3FFuLL,
      "%s://%s:%d%s",
      theurl->scheme->val,
      theurl->host->val,
      v336,
      (const char *)returned_len);
  }
  else
  {
    if ( (_WORD)v336 != 80 )
      goto LABEL_588;
LABEL_586:
    v319 = theurl;
    ap_php_snprintf(
      (char *)&str,
      0x3FFuLL,
      "%s://%s%s",
      theurl->scheme->val,
      theurl->host->val,
      (const char *)returned_len);
  }
LABEL_589:
  php_url_free(v319);
  theurl = php_url_parse((const char *)&str);
  if ( !theurl )
  {
    v18 = 0LL;
    php_stream_wrapper_log_error(v301, v317, "Invalid redirect URL! %s", &str);
    goto LABEL_610;
  }
  v337 = v301;
  if ( !strncasecmp((const char *)&str, "http://", 7uLL) && !strncasecmp((const char *)&str, "https://", 8uLL) )
  {
LABEL_607:
    v18 = php_stream_url_wrap_http_ex(
            v337,
            (const char *)&str,
            v34,
            v365,
            opened_patha,
            (php_stream_context *)(unsigned int)(v318 - 1),
            2,
            flags);
    goto LABEL_610;
  }
  user = theurl->user;
  if ( !user || (v339 = php_url_decode(user->val, user->len), v340 = theurl->user, v340->len = v339, v339 <= 0) )
  {
LABEL_597:
    v344 = theurl->pass;
    if ( v344 )
    {
      v345 = php_url_decode(v344->val, v344->len);
      v346 = theurl->pass;
      v346->len = v345;
      if ( v345 > 0 )
      {
        v347 = (unsigned __int64)&v346->val[v345];
        v348 = v346->val;
        v349 = *__ctype_b_loc();
        while ( (v349[(unsigned __int8)*v348] & 2) == 0 )
        {
          if ( (unsigned __int64)++v348 >= v347 )
            goto LABEL_602;
        }
        goto LABEL_609;
      }
    }
LABEL_602:
    v350 = theurl->path;
    if ( v350 )
    {
      v351 = php_url_decode(v350->val, v350->len);
      v352 = theurl->path;
      v352->len = v351;
      if ( v351 > 0 )
      {
        v353 = (unsigned __int64)&v352->val[v351];
        v354 = v352->val;
        v355 = *__ctype_b_loc();
        while ( (v355[(unsigned __int8)*v354] & 2) == 0 )
        {
          if ( (unsigned __int64)++v354 >= v353 )
            goto LABEL_607;
        }
        goto LABEL_609;
      }
    }
    goto LABEL_607;
  }
  v341 = (unsigned __int64)&v340->val[v339];
  v342 = v340->val;
  v343 = *__ctype_b_loc();
  while ( (v343[(unsigned __int8)*v342] & 2) == 0 )
  {
    if ( (unsigned __int64)++v342 >= v341 )
      goto LABEL_597;
  }
LABEL_609:
  v18 = 0LL;
  php_stream_wrapper_log_error(v337, v365, "Invalid redirect URL! %s", &str);
LABEL_610:
  v87 = 0LL;
LABEL_611:
  v89 = v380;
  v88 = bytes_max;
out:
  v288 = ptr[0];
  if ( ptr[0] )
  {
    if ( (*((_DWORD *)ptr[0] + 1) & 0x40) == 0 )
    {
      v36 = (*(_DWORD *)ptr[0])-- == 1;
      if ( v36 )
        efree(v288);
    }
    ptr[0] = 0LL;
  }
  ptr[1] = 0LL;
  if ( v90 )
    efree(v90);
  if ( theurl )
    php_url_free(theurl);
  if ( !v18 )
    return 0LL;
  if ( (redirect_max & 1) != 0 )
  {
    v289 = (_DWORD *)flags->lval;
    w1 = flags[1].ww.w1;
    v18->wrapperdata.value = (zend_value_1)flags->lval;
    v18->wrapperdata.u1.type_info = w1;
    if ( (w1 & 0xFF00) != 0 )
      ++*v289;
  }
  if ( (_BYTE)v371 )
  {
    v291 = *opened_patha;
    if ( *opened_patha )
    {
      v291[1].h = 0LL;
      v291[1].len = v88;
      LOBYTE(v291[1].gc.refcount) |= 1u;
      php_stream_notification_notify((php_stream_context *)opened_patha, 7, 0, 0LL, 0, 0LL, v88, 0LL);
    }
  }
  if ( (v365 & 0x20) != 0 )
    php_stream_set_option(v18, 5, v89, 0LL);
  v18->flags |= v381;
  v18->position = 0LL;
  php_strlcpy(v18->mode, v34, 0x10uLL);
  if ( v87 )
    php_stream_filter_append(&v18->readfilters, v87);
  return v18;
}

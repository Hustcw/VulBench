php_stream *__fastcall php_stream_url_wrap_http_ex(
        php_stream_wrapper *wrapper,
        char *path,
        char *mode,
        int options,
        zend_string **opened_path,
        php_stream_context *context,
        int redirect_max,
        zend_value_1 *flags)
{
  zend_long long_func;
  php_url *v12;
  php_url *v13;
  zend_string *scheme;
  size_t len;
  zval *option;
  zend_string *lval;
  int v18;
  php_stream *v19;
  zend_string *v20;
  bool v21;
  char v22;
  zval *v23;
  const char *v24;
  char *val;
  __int64 port;
  zval_1 *v27;
  double dval;
  __time_t v29;
  double v30;
  unsigned __int64 v31;
  php_stream *v32;
  php_stream *v33;
  char *v34;
  zend_string *v35;
  union {uint32_t type_info;} v36;
  php_stream *v37;
  zend_string *host;
  union {uint32_t type_info;struct {zend_uchar type;zend_uchar type_flags;union {uint16_t extra;} u;} v;} v39;
  zend_resource *ctx;
  php_stream_context *v41;
  char *v42;
  php_stream_filter *v43;
  size_t v44;
  int v45;
  char *v46;
  zend_string *s;
  size_t v48;
  size_t v49;
  zend_string *v50;
  char *v51;
  size_t v52;
  size_t v53;
  size_t v54;
  zend_string *v55;
  size_t v56;
  php_url *v57;
  unsigned __int64 v58;
  char *v59;
  bool v60;
  char *v61;
  zend_string *v62;
  char *v63;
  size_t v64;
  zend_string *v65;
  size_t v66;
  zend_string *v67;
  zval *v68;
  zend_uchar type;
  zend_value v70;
  _BYTE *v71;
  _BYTE *v72;
  __int64 v73;
  const char *v74;
  unsigned __int64 v75;
  const char *v76;
  _BYTE *v77;
  __int64 v78;
  unsigned __int64 v79;
  unsigned __int8 *v80;
  size_t v81;
  size_t v82;
  php_stream_wrapper *v83;
  zend_string *v84;
  ssize_t v85;
  zend_string *v86;
  __int64 v87;
  __int64 v88;
  int v89;
  zval_1 *v90;
  zval *v91;
  zend_value v92;
  size_t v93;
  const void *v94;
  zend_string *v95;
  size_t v96;
  size_t v97;
  zend_string *v98;
  size_t v99;
  zend_string *v100;
  size_t v101;
  char v102;
  char *v103;
  zval *v104;
  zend_string *v105;
  const char *v106;
  size_t v107;
  zend_string *v108;
  size_t v109;
  size_t v110;
  php_url *v111;
  zend_string **v112;
  size_t v113;
  zend_string *v114;
  size_t v115;
  size_t v116;
  zend_string *v117;
  zend_string *v118;
  size_t v119;
  php_url *v120;
  zend_string *v121;
  const char *v122;
  size_t v123;
  size_t v124;
  zval_1 *v125;
  double double_func;
  zend_string *v127;
  size_t v128;
  size_t v129;
  zend_string *v130;
  const void *v131;
  size_t v132;
  size_t v133;
  size_t v134;
  zend_string *v135;
  size_t v136;
  size_t v137;
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
  char *v153;
  size_t v154;
  char *v155;
  php_url *v156;
  size_t v157;
  char *v158;
  zend_string *pass;
  char *v160;
  zend_string *v161;
  size_t v162;
  size_t v163;
  const void *v164;
  size_t v165;
  size_t v166;
  size_t v167;
  zend_string *v168;
  size_t v169;
  zend_string **v170;
  int v171;
  size_t v172;
  zend_string *v173;
  size_t v174;
  size_t v175;
  zend_string *v176;
  char *from_address;
  size_t v178;
  size_t v179;
  size_t v180;
  zend_string *v181;
  size_t v182;
  zend_string *v183;
  size_t v184;
  size_t v185;
  size_t v186;
  zend_string *v187;
  char *v188;
  size_t v189;
  size_t v190;
  size_t v191;
  zend_string *v192;
  php_url *v193;
  unsigned __int16 v194;
  zend_string *v195;
  size_t v196;
  size_t v197;
  size_t v198;
  unsigned __int64 v199;
  char *v200;
  char *v201;
  zend_string *v202;
  char *v203;
  size_t v204;
  size_t v205;
  size_t v206;
  zval *v207;
  char *user_agent;
  php_stream *v209;
  zend_string **v210;
  size_t v211;
  size_t v212;
  int v213;
  size_t v214;
  zend_string *v215;
  size_t v216;
  size_t v217;
  zval *v218;
  zval *v219;
  zend_string *v220;
  size_t v221;
  size_t v222;
  unsigned __int64 v223;
  char *v224;
  char *v225;
  zend_string *v226;
  char *v227;
  size_t v228;
  zend_string *v229;
  size_t v230;
  size_t v231;
  zend_string *v232;
  size_t v233;
  size_t v234;
  zend_string *v235;
  size_t v236;
  php_stream_wrapper *v237;
  zval *v238;
  zval *v239;
  zend_string *v240;
  size_t v241;
  size_t v242;
  char v243;
  unsigned __int64 v244;
  char *v245;
  char *v246;
  zend_string *v247;
  size_t v248;
  zend_string *v249;
  size_t v250;
  php_stream_wrapper *v251;
  zend_string *v252;
  size_t v253;
  size_t v254;
  zend_string *v255;
  php_stream_wrapper *v256;
  size_t v257;
  size_t v258;
  zend_string *v259;
  size_t v260;
  const void *v261;
  size_t v262;
  zend_string *v263;
  size_t v264;
  zend_string *v265;
  int v266;
  zval *v267;
  int is_true;
  php_stream_wrapper *v269;
  size_t v270;
  void *v271;
  size_t v272;
  const void *v273;
  size_t v274;
  char *v275;
  char *v276;
  size_t v277;
  php_stream_wrapper *v278;
  size_t v279;
  zend_string *v280;
  int v281;
  php_stream_wrapper *v282;
  int v283;
  unsigned int v284;
  php_stream_filter *v285;
  char *line;
  char v287;
  char *j;
  char *v289;
  char *v290;
  char v291;
  int v292;
  zval *v293;
  zval *v294;
  int v295;
  int v296;
  size_t v297;
  zend_string *v298;
  int v299;
  char v300;
  size_t v301;
  const char *v302;
  BOOL v303;
  int v304;
  int v305;
  int v306;
  int v307;
  unsigned int v308;
  char *v309;
  char *i;
  char v311;
  const char *v312;
  __int64 v313;
  unsigned __int64 v314;
  size_t v315;
  char v316;
  zend_string *v317;
  _DWORD *v318;
  uint32_t w1;
  zend_string *v320;
  php_url *v322;
  php_stream_wrapper *v323;
  zend_string *v324;
  char *v325;
  char *v326;
  size_t v327;
  __int64 v328;
  unsigned __int64 v329;
  size_t v330;
  zend_string *v331;
  size_t v332;
  size_t v333;
  zend_string *v334;
  size_t v335;
  char *v336;
  zend_string *v337;
  __int64 v338;
  php_stream_wrapper *v339;
  zend_string *user;
  __int64 v341;
  zend_string *v342;
  unsigned __int64 v343;
  char *v344;
  const unsigned __int16 *v345;
  zend_string *v346;
  __int64 v347;
  zend_string *v348;
  unsigned __int64 v349;
  char *v350;
  const unsigned __int16 *v351;
  zend_string *v352;
  __int64 v353;
  zend_string *v354;
  unsigned __int64 v355;
  char *v356;
  const unsigned __int16 *v357;
  php_stream_context *v358;
  __int64 v359;
  unsigned __int64 v360;
  size_t v361;
  zend_string *v362;
  size_t v363;
  size_t v364;
  zend_string *v365;
  size_t v366;
  smart_str v367;
  int v368;
  char *v369;
  php_url *theurl;
  zend_string **opened_patha;
  int v372;
  char *src;
  int v374;
  size_t bytes_max;
  __time_t v376;
  php_stream *v377;
  bool v378;
  char v379;
  void *ptr;
  uint32_t v381;
  zend_long v382;
  php_stream_wrapper *v383;
  __int64 v384;
  zend_string *error_string;
  int v386;
  unsigned int v387;
  timeval timeout;
  zval optionvalue;
  char s1[9];
  char nptr[119];
  smart_str str;
  char buf[16];
  char v394[993];
  size_t returned_len[135];

  error_string = 0LL;
  v367 = 0LL;
  s1[0] = 0;
  if ( (int)context <= 0 )
  {
    v19 = 0LL;
    php_stream_wrapper_log_error(wrapper, options, "Redirection limit reached, aborting");
    return v19;
  }
  long_func = (unsigned int)context;
  v368 = options;
  v12 = php_url_parse(path);
  if ( !v12 )
    return 0LL;
  v13 = v12;
  v369 = path;
  scheme = v12->scheme;
  len = v12->scheme->len;
  if ( len == 4 )
  {
    if ( !zend_binary_strcasecmp(scheme->val, 4uLL, "http", 4uLL) )
      goto LABEL_17;
    scheme = v13->scheme;
    len = v13->scheme->len;
  }
  if ( len != 5 || zend_binary_strcasecmp(scheme->val, 5uLL, "https", 5uLL) )
  {
    theurl = v13;
    if ( !opened_path
      || (option = php_stream_context_get_option((php_stream_context *)opened_path, wrapper->wops->label, "proxy")) == 0LL
      || option->u1.v.type != 6
      || (lval = (zend_string *)option->value.lval, !*(_QWORD *)(option->value.lval + 16)) )
    {
      php_url_free(theurl);
      return php_stream_open_wrapper_ex(v369, mode, 8, 0LL, (php_stream_context *)opened_path);
    }
    LOBYTE(option) = 1;
    ptr = option;
    bytes_max = 1LL;
    v374 = 0;
    if ( (lval->gc.u.type_info & 0x40) == 0 )
      ++lval->gc.refcount;
    v18 = v368;
    goto LABEL_39;
  }
LABEL_17:
  if ( strpbrk(mode, "awx+") )
  {
    v19 = 0LL;
    php_stream_wrapper_log_error(wrapper, v368, "HTTP wrapper does not support writeable connections");
    php_url_free(v13);
    return v19;
  }
  src = mode;
  v20 = v13->scheme;
  v21 = v13->scheme == 0LL;
  theurl = v13;
  if ( v21 )
  {
    v374 = 0;
    v22 = 0;
  }
  else
  {
    v374 = 0;
    v22 = 0;
    if ( v20->len >= 5 )
    {
      v374 = 0;
      v22 = 0;
      if ( v20->val[4] == 115 )
      {
        if ( !v13->port )
        {
          v13->port = 443;
          v22 = 1;
          v374 = 1;
          goto LABEL_28;
        }
        v22 = 1;
        v374 = 1;
        if ( !v13->port )
          goto LABEL_27;
        goto LABEL_28;
      }
    }
  }
  if ( !v13->port )
LABEL_27:
    v13->port = 80;
LABEL_28:
  v18 = v368;
  if ( opened_path
    && (v23 = php_stream_context_get_option((php_stream_context *)opened_path, wrapper->wops->label, "proxy")) != 0LL
    && v23->u1.v.type == 6
    && (lval = (zend_string *)v23->value.lval, *(_QWORD *)(v23->value.lval + 16)) )
  {
    bytes_max = 1LL;
    mode = src;
    if ( (lval->gc.u.type_info & 0x40) == 0 )
      ++lval->gc.refcount;
    ptr = 0LL;
  }
  else
  {
    v24 = "tcp";
    if ( v22 )
      v24 = "ssl";
    val = theurl->host->val;
    port = theurl->port;
    bytes_max = 0LL;
    lval = zend_strpprintf(0LL, "%s://%s:%d", v24, val, port);
    if ( !opened_path )
    {
      v376 = 0LL;
      ptr = 0LL;
      mode = src;
      goto LABEL_47;
    }
    ptr = 0LL;
    mode = src;
  }
LABEL_39:
  v27 = (zval_1 *)php_stream_context_get_option((php_stream_context *)opened_path, wrapper->wops->label, "timeout");
  if ( !v27 )
  {
    v376 = 1LL;
LABEL_47:
    src = mode;
    timeout.tv_sec = file_globals.default_socket_timeout;
    v31 = 0LL;
    goto LABEL_48;
  }
  if ( v27->u1.v.type == 5 )
    dval = v27->value.dval;
  else
    dval = zval_get_double_func(v27);
  src = mode;
  v29 = (unsigned int)(int)dval;
  v30 = (dval - (double)(int)v29) * 1000000.0;
  v31 = (unsigned int)(int)v30;
  timeout.tv_sec = v29;
  if ( v30 >= 9.223372036854776e18 )
    v31 = (unsigned int)(int)(v30 - 9.223372036854776e18) ^ 0x8000000000000000LL;
  LOBYTE(v29) = 1;
  v376 = v29;
LABEL_48:
  timeout.tv_usec = v31;
  v32 = php_stream_xport_create(
          lval->val,
          lval->len,
          v18,
          2,
          0LL,
          &timeout,
          (php_stream_context *)opened_path,
          &error_string,
          0LL);
  v33 = v32;
  if ( v32 )
    php_stream_set_option(v32, 4, 0, &timeout);
  v377 = v33;
  v34 = src;
  if ( error_string )
  {
    php_stream_wrapper_log_error(wrapper, v368, "%s", error_string->val);
    v35 = error_string;
    if ( (error_string->gc.u.type_info & 0x40) == 0 )
    {
      v21 = error_string->gc.refcount-- == 1;
      if ( v21 )
        efree(v35);
    }
    error_string = 0LL;
  }
  v36.type_info = (uint32_t)lval->gc.u;
  if ( (v36.type_info & 0x40) == 0 )
  {
    v21 = lval->gc.refcount-- == 1;
    if ( v21 )
    {
      if ( SLOBYTE(v36.type_info) < 0 )
        free(lval);
      else
        efree(lval);
    }
  }
  opened_patha = opened_path;
  v383 = wrapper;
  if ( !v374 )
  {
    v37 = v377;
    if ( v377 )
      goto LABEL_159;
    goto LABEL_70;
  }
  v37 = v377;
  if ( !(_DWORD)bytes_max || !v377 )
    goto LABEL_158;
  str = 0LL;
  if ( !(_BYTE)v376 || !php_stream_context_get_option((php_stream_context *)opened_path, "ssl", "peer_name") )
  {
    host = theurl->host;
    optionvalue.value.lval = (zend_long)host;
    v39.type_info = 6;
    if ( (host->gc.u.type_info & 0x40) == 0 )
    {
      ++host->gc.refcount;
      v39.type_info = 262;
    }
    optionvalue.u1 = (union {uint32_t type_info;struct {zend_uchar type;zend_uchar type_flags;union {uint16_t extra;} u;} v;})v39.type_info;
    ctx = v37->ctx;
    if ( ctx )
      v41 = (php_stream_context *)ctx->ptr;
    else
      v41 = 0LL;
    php_stream_context_set_option(v41, "ssl", "peer_name", &optionvalue);
    zval_ptr_dtor((zval_1 *)&optionvalue);
  }
  s = str.s;
  v382 = long_func;
  if ( !str.s )
  {
    v49 = 8LL;
    goto LABEL_636;
  }
  v48 = str.s->len;
  v49 = v48 + 8;
  if ( v48 + 8 >= str.a )
  {
LABEL_636:
    smart_str_erealloc(&str, v49);
    s = str.s;
    v48 = str.s->len;
  }
  *(_QWORD *)&s->val[v48] = 0x205443454E4E4F43LL;
  v50 = str.s;
  str.s->len = v49;
  v51 = theurl->host->val;
  v52 = strlen(v51);
  v53 = v52;
  v54 = v52;
  if ( !v50 || (v54 = v49 + v52, v49 + v52 >= str.a) )
  {
    smart_str_erealloc(&str, v54);
    v50 = str.s;
    v49 = str.s->len;
  }
  memcpy(&v50->val[v49], v51, v53);
  v55 = str.s;
  str.s->len = v54;
  if ( !v55 )
  {
    v56 = 1LL;
    opened_path = opened_patha;
    v57 = theurl;
    v37 = v377;
    goto LABEL_638;
  }
  v56 = v54 + 1;
  opened_path = opened_patha;
  v57 = theurl;
  v37 = v377;
  if ( v56 >= str.a )
  {
LABEL_638:
    smart_str_erealloc(&str, v56);
    v55 = str.s;
  }
  *((_BYTE *)&v55->len + v56 + 7) = 58;
  str.s->len = v56;
  v58 = v57->port;
  v394[0] = 0;
  v59 = v394;
  do
  {
    *--v59 = (v58 % 0xA) | 0x30;
    v60 = v58 <= 9;
    v58 /= 0xAuLL;
  }
  while ( !v60 );
  v61 = (char *)(v394 - v59);
  v62 = str.s;
  v63 = (char *)(v394 - v59);
  if ( !str.s || (v64 = str.s->len, v63 = &v61[v64], (unsigned __int64)&v61[v64] >= str.a) )
  {
    smart_str_erealloc(&str, (size_t)v63);
    v62 = str.s;
    v64 = str.s->len;
  }
  memcpy(&v62->val[v64], v59, v394 - v59);
  v65 = str.s;
  str.s->len = (size_t)v63;
  if ( v65 )
  {
    v66 = (size_t)(v63 + 11);
    if ( (unsigned __int64)(v63 + 11) < str.a )
      goto LABEL_85;
  }
  else
  {
    v66 = 11LL;
  }
  smart_str_erealloc(&str, v66);
  v65 = str.s;
  v63 = (char *)str.s->len;
LABEL_85:
  *(_QWORD *)&v63[(_QWORD)v65 + 24] = 0x2E312F5054544820LL;
  *(_DWORD *)&v63[(_QWORD)v65 + 31] = 168636462;
  v67 = str.s;
  str.s->len = v66;
  if ( !(_BYTE)v376 )
    goto LABEL_139;
  v68 = php_stream_context_get_option((php_stream_context *)opened_path, "http", "header");
  if ( !v68 )
    goto LABEL_137;
  type = v68->u1.v.type;
  if ( type == 6 )
  {
    if ( *(_QWORD *)(v68->value.lval + 16) )
    {
      v77 = (_BYTE *)(v68->value.lval + 24);
      v78 = 9217LL;
      do
      {
        while ( 1 )
        {
          LOBYTE(v79) = *v77;
          if ( *v77 != 9 && (_BYTE)v79 != 32 )
            break;
          ++v77;
        }
        v80 = v77 + 1;
        if ( (char)v79 <= 12 )
          goto LABEL_124;
        while ( 1 )
        {
          if ( (_BYTE)v79 == 13 )
            goto LABEL_126;
          if ( (_BYTE)v79 == 58 )
            break;
          while ( 1 )
          {
            LOBYTE(v79) = *v80++;
            if ( (char)v79 > 12 )
              break;
LABEL_124:
            if ( !(_BYTE)v79 || (_BYTE)v79 == 10 )
            {
LABEL_126:
              --v80;
              goto LABEL_133;
            }
          }
        }
        if ( v80 - v77 == 20 && !zend_binary_strcasecmp(v77, 0x14uLL, "Proxy-Authorization:", 0x14uLL) )
        {
          v359 = 9217LL;
          while ( 1 )
          {
            v360 = *v80;
            if ( v360 <= 0xD )
            {
              if ( _bittest64(&v359, v360) )
                break;
            }
            ++v80;
          }
          v361 = v80 - v77;
          v362 = str.s;
          v363 = v361;
          if ( !str.s || (v364 = str.s->len, v363 = v364 + v361, v364 + v361 >= str.a) )
          {
            smart_str_erealloc(&str, v363);
            v362 = str.s;
            v364 = str.s->len;
          }
          memcpy(&v362->val[v364], v77, v361);
          v365 = str.s;
          str.s->len = v363;
          if ( v365 )
          {
            v366 = v363 + 2;
            if ( v363 + 2 < str.a )
              goto LABEL_634;
          }
          else
          {
            v366 = 2LL;
          }
          smart_str_erealloc(&str, v366);
          v365 = str.s;
          v363 = str.s->len;
LABEL_634:
          *(_WORD *)&v365->val[v363] = 2573;
          v67 = str.s;
          str.s->len = v366;
LABEL_138:
          opened_path = opened_patha;
          v37 = v377;
LABEL_139:
          if ( !v67 )
            goto LABEL_568;
LABEL_140:
          v81 = v67->len;
          v82 = v81 + 2;
          v83 = v383;
          v34 = src;
          if ( v81 + 2 >= str.a )
            goto LABEL_569;
          goto LABEL_141;
        }
        while ( 1 )
        {
          v79 = *v80;
          if ( v79 <= 0xD )
          {
            if ( _bittest64(&v78, v79) )
              break;
          }
          ++v80;
        }
LABEL_133:
        v77 = v80;
        if ( (_BYTE)v79 != 10 )
          goto LABEL_135;
        do
        {
          do
            LOBYTE(v79) = *++v77;
          while ( (_BYTE)v79 == 10 );
LABEL_135:
          ;
        }
        while ( (_BYTE)v79 == 13 );
      }
      while ( (_BYTE)v79 );
    }
LABEL_137:
    v67 = str.s;
    goto LABEL_138;
  }
  if ( type != 7 )
    goto LABEL_137;
  v70.lval = (zend_long)v68->value;
  if ( !*(_DWORD *)(v70.lval + 24) )
    goto LABEL_137;
  v71 = *(_BYTE **)(v70.lval + 16);
  v72 = &v71[32 * *(unsigned int *)(v70.lval + 24)];
  v73 = 9217LL;
  if ( v71[8] == 6 )
    goto LABEL_93;
  do
  {
LABEL_91:
    v71 += 32;
    if ( v71 == v72 )
      goto LABEL_137;
  }
  while ( v71[8] != 6 );
LABEL_93:
  v74 = (const char *)(*(_QWORD *)v71 + 24LL);
  while ( 1 )
  {
    while ( 1 )
    {
      LOBYTE(v75) = *v74;
      if ( *v74 != 9 && (_BYTE)v75 != 32 )
        break;
      ++v74;
    }
    v76 = v74 + 1;
    if ( (char)v75 <= 12 )
      goto LABEL_101;
    while ( 1 )
    {
      if ( (_BYTE)v75 == 13 )
        goto LABEL_103;
      if ( (_BYTE)v75 == 58 )
        break;
      while ( 1 )
      {
        LOBYTE(v75) = *v76++;
        if ( (char)v75 > 12 )
          break;
LABEL_101:
        if ( !(_BYTE)v75 || (_BYTE)v75 == 10 )
        {
LABEL_103:
          --v76;
          goto LABEL_110;
        }
      }
    }
    if ( v76 - v74 == 20 && !zend_binary_strcasecmp(v74, 0x14uLL, "Proxy-Authorization:", 0x14uLL) )
      break;
    while ( 1 )
    {
      v75 = *(unsigned __int8 *)v76;
      if ( v75 <= 0xD )
      {
        if ( _bittest64(&v73, v75) )
          break;
      }
      ++v76;
    }
LABEL_110:
    v74 = v76;
    if ( (_BYTE)v75 != 10 )
      goto LABEL_112;
    do
    {
      do
        LOBYTE(v75) = *++v74;
      while ( (_BYTE)v75 == 10 );
LABEL_112:
      ;
    }
    while ( (_BYTE)v75 == 13 );
    if ( !(_BYTE)v75 )
      goto LABEL_91;
  }
  v328 = 9217LL;
  opened_path = opened_patha;
  v37 = v377;
  while ( 1 )
  {
    v329 = *(unsigned __int8 *)v76;
    if ( v329 <= 0xD )
    {
      if ( _bittest64(&v328, v329) )
        break;
    }
    ++v76;
  }
  v330 = v76 - v74;
  v331 = str.s;
  v332 = v330;
  if ( !str.s || (v333 = str.s->len, v332 = v333 + v330, v333 + v330 >= str.a) )
  {
    smart_str_erealloc(&str, v332);
    v331 = str.s;
    v333 = str.s->len;
  }
  memcpy(&v331->val[v333], v74, v330);
  v334 = str.s;
  str.s->len = v332;
  if ( v334 )
  {
    v335 = v332 + 2;
    if ( v332 + 2 < str.a )
      goto LABEL_567;
  }
  else
  {
    v335 = 2LL;
  }
  smart_str_erealloc(&str, v335);
  v334 = str.s;
  v332 = str.s->len;
LABEL_567:
  *(_WORD *)&v334->val[v332] = 2573;
  v67 = str.s;
  str.s->len = v335;
  if ( v67 )
    goto LABEL_140;
LABEL_568:
  v82 = 2LL;
  v83 = v383;
  v34 = src;
LABEL_569:
  smart_str_erealloc(&str, v82);
  v67 = str.s;
  v81 = str.s->len;
LABEL_141:
  *(_WORD *)&v67->val[v81] = 2573;
  v84 = str.s;
  str.s->len = v82;
  v85 = php_stream_write(v37, v84->val, v82);
  v86 = str.s;
  if ( v85 != str.s->len )
  {
    php_stream_wrapper_log_error(v83, v368, "Cannot connect to HTTPS server through proxy");
    php_stream_free(v37, 3);
    v86 = str.s;
    v37 = 0LL;
  }
  if ( v86 )
  {
    if ( (v86->gc.u.type_info & 0x40) == 0 )
    {
      v21 = v86->gc.refcount-- == 1;
      if ( v21 )
        efree(v86);
    }
    str.s = 0LL;
  }
  str.a = 0LL;
  if ( v37 )
  {
    v87 = 9217LL;
    while ( php_stream_get_line(v37, buf, 0x3FFuLL, 0LL)
         && ((unsigned __int8)buf[0] > 0xDuLL || !_bittest64(&v87, (unsigned __int8)buf[0])) )
      ;
    v34 = src;
    if ( php_stream_xport_crypto_setup(v37, STREAM_CRYPTO_METHOD_SSLv23_CLIENT, 0LL) < 0
      || php_stream_xport_crypto_enable(v37, 1) < 0 )
    {
      php_stream_wrapper_log_error(v83, v368, "Cannot connect to HTTPS server through proxy");
      php_stream_free(v37, 3);
      goto LABEL_156;
    }
  }
  else
  {
LABEL_156:
    v37 = 0LL;
  }
  long_func = v382;
LABEL_158:
  if ( !v37 )
  {
LABEL_70:
    v42 = v34;
    v43 = 0LL;
    v381 = 0;
    v44 = 0LL;
    v45 = 0;
    v46 = 0LL;
    v19 = 0LL;
    goto out;
  }
LABEL_159:
  if ( (v368 & 0x20) != 0 )
    v88 = php_stream_set_option(v37, 5, 1, 0LL);
  else
    v88 = 0LL;
  v384 = v88;
  v381 = v37->flags;
  v37->flags = v381 & 0xFFFFFFF3;
  php_stream_context_set(v37, (php_stream_context *)opened_path);
  src = v34;
  if ( !(_BYTE)v376 )
  {
    v89 = 0;
    goto LABEL_179;
  }
  if ( *opened_path )
    php_stream_notification_notify((php_stream_context *)opened_path, 2, 0, 0LL, 0, 0LL, 0LL, 0LL);
  v89 = redirect_max;
  if ( (redirect_max & 1) != 0 )
  {
    v90 = (zval_1 *)php_stream_context_get_option((php_stream_context *)opened_path, "http", "max_redirects");
    if ( v90 )
    {
      if ( v90->u1.v.type == 4 )
        long_func = v90->value.lval;
      else
        long_func = zval_get_long_func(v90, 0);
    }
  }
  LOBYTE(v89) = redirect_max & 1;
  v91 = php_stream_context_get_option((php_stream_context *)opened_path, "http", "method");
  if ( !v91 || v91->u1.v.type != 6 )
  {
LABEL_179:
    v100 = v367.s;
    v372 = v89;
    if ( v367.s )
    {
      v101 = v367.s->len;
      v99 = v101 + 4;
      if ( v101 + 4 < v367.a )
      {
LABEL_181:
        *(_DWORD *)&v100->val[v101] = 542393671;
        goto LABEL_182;
      }
    }
    else
    {
      v99 = 4LL;
    }
    smart_str_erealloc(&v367, v99);
    v100 = v367.s;
    v101 = v367.s->len;
    goto LABEL_181;
  }
  v372 = v89;
  v92.lval = (zend_long)v91->value;
  v93 = *(_QWORD *)(v91->value.lval + 16);
  if ( !v93 )
    goto LABEL_552;
  if ( (redirect_max & 2) == 0 )
    goto LABEL_173;
  if ( v93 == 4 )
  {
    if ( *(_DWORD *)(v92.lval + 24) == 1145128264 )
      goto LABEL_173;
    goto LABEL_552;
  }
  if ( v93 != 3 || *(_WORD *)(v92.lval + 24) ^ 0x4547 | *(unsigned __int8 *)(v92.lval + 26) ^ 0x54 )
  {
LABEL_552:
    v89 = v372;
    goto LABEL_179;
  }
LABEL_173:
  v94 = (const void *)(v92.lval + 24);
  v95 = v367.s;
  v96 = v93;
  if ( !v367.s || (v97 = v367.s->len, v96 = v97 + v93, v97 + v93 >= v367.a) )
  {
    smart_str_erealloc(&v367, v96);
    v95 = v367.s;
    v97 = v367.s->len;
  }
  memcpy(&v95->val[v97], v94, v93);
  v98 = v367.s;
  v367.s->len = v96;
  if ( v98 )
  {
    v99 = v96 + 1;
    if ( v99 < v367.a )
      goto LABEL_177;
  }
  else
  {
    v99 = 1LL;
  }
  smart_str_erealloc(&v367, v99);
  v98 = v367.s;
LABEL_177:
  *((_BYTE *)&v98->len + v99 + 7) = 32;
LABEL_182:
  v382 = long_func;
  v367.s->len = v99;
  v102 = (char)ptr;
  v377 = v37;
  v103 = v369;
  v379 = v376 ^ 1;
  if ( (unsigned __int8)v376 ^ 1 | ((_BYTE)ptr != 0) )
  {
LABEL_185:
    if ( !v102 )
      goto LABEL_186;
    v113 = strlen(v103);
    v114 = v367.s;
    v115 = v113;
    if ( !v367.s || (v116 = v367.s->len, v115 = v116 + v113, v116 + v113 >= v367.a) )
    {
      smart_str_erealloc(&v367, v115);
      v114 = v367.s;
      v116 = v367.s->len;
    }
    memcpy(&v114->val[v116], v103, v113);
    v117 = v367.s;
LABEL_203:
    v117->len = v115;
    v112 = opened_patha;
    goto LABEL_204;
  }
  v104 = php_stream_context_get_option((php_stream_context *)opened_patha, "http", "request_fulluri");
  if ( v104 )
  {
    v102 = zend_is_true((zval_1 *)v104) != 0;
    goto LABEL_185;
  }
LABEL_186:
  v105 = theurl->path;
  if ( !v105 || !v105->len )
  {
    v118 = v367.s;
    if ( v367.s )
    {
      v109 = v367.s->len + 1;
      if ( v109 < v367.a )
      {
LABEL_196:
        *((_BYTE *)&v118->len + v109 + 7) = 47;
        v112 = opened_patha;
        v111 = theurl;
        goto LABEL_197;
      }
    }
    else
    {
      v109 = 1LL;
    }
    smart_str_erealloc(&v367, v109);
    v118 = v367.s;
    goto LABEL_196;
  }
  v106 = v105->val;
  v107 = strlen(v106);
  v108 = v367.s;
  v109 = v107;
  if ( !v367.s || (v110 = v367.s->len, v109 = v110 + v107, v110 + v107 >= v367.a) )
  {
    smart_str_erealloc(&v367, v109);
    v108 = v367.s;
    v110 = v367.s->len;
  }
  memcpy(&v108->val[v110], v106, v107);
  v111 = theurl;
  v112 = opened_patha;
LABEL_197:
  v117 = v367.s;
  v367.s->len = v109;
  theurl = v111;
  if ( v111->query )
  {
    if ( v117 )
    {
      v119 = v109 + 1;
      v120 = theurl;
      if ( v119 < v367.a )
      {
LABEL_200:
        *((_BYTE *)&v117->len + v119 + 7) = 63;
        v121 = v367.s;
        v367.s->len = v119;
        v122 = v120->query->val;
        v123 = strlen(v122);
        v124 = v123;
        v115 = v123;
        if ( !v121 || (v115 = v119 + v123, v119 + v123 >= v367.a) )
        {
          smart_str_erealloc(&v367, v115);
          v121 = v367.s;
          v119 = v367.s->len;
        }
        memcpy(&v121->val[v119], v122, v124);
        v117 = v367.s;
        v103 = v369;
        goto LABEL_203;
      }
    }
    else
    {
      v119 = 1LL;
      v120 = theurl;
    }
    smart_str_erealloc(&v367, v119);
    v117 = v367.s;
    goto LABEL_200;
  }
LABEL_204:
  if ( !(_BYTE)v376 )
  {
LABEL_216:
    if ( v117 )
    {
      v137 = v117->len;
      v138 = v137 + 11;
      if ( v137 + 11 < v367.a )
        goto LABEL_218;
    }
    else
    {
      v138 = 11LL;
    }
    smart_str_erealloc(&v367, v138);
    v117 = v367.s;
    v137 = v367.s->len;
LABEL_218:
    *(_QWORD *)&v117->val[v137] = 0x2E312F5054544820LL;
    *(_DWORD *)&v117->val[v137 + 7] = 168636718;
    v367.s->len = v138;
    if ( (_BYTE)v376 )
      goto LABEL_219;
    goto LABEL_236;
  }
  v125 = (zval_1 *)php_stream_context_get_option((php_stream_context *)v112, "http", "protocol_version");
  if ( !v125 )
  {
    v117 = v367.s;
    goto LABEL_216;
  }
  if ( v125->u1.v.type == 5 )
    double_func = v125->value.dval;
  else
    double_func = zval_get_double_func(v125);
  zend_spprintf((char **)buf, 0LL, "%.1F", double_func);
  v127 = v367.s;
  if ( !v367.s )
  {
    v129 = 6LL;
    goto LABEL_670;
  }
  v128 = v367.s->len;
  v129 = v128 + 6;
  if ( v128 + 6 >= v367.a )
  {
LABEL_670:
    smart_str_erealloc(&v367, v129);
    v127 = v367.s;
    v128 = v367.s->len;
  }
  *(_WORD *)&v127->val[v128 + 4] = 12112;
  *(_DWORD *)&v127->val[v128] = 1414809632;
  v130 = v367.s;
  v367.s->len = v129;
  v131 = *(const void **)buf;
  v132 = strlen(*(const char **)buf);
  v133 = v132;
  v134 = v132;
  if ( !v130 || (v134 = v129 + v132, v129 + v132 >= v367.a) )
  {
    smart_str_erealloc(&v367, v134);
    v130 = v367.s;
    v129 = v367.s->len;
  }
  memcpy(&v130->val[v129], v131, v133);
  v135 = v367.s;
  v367.s->len = v134;
  if ( v135 )
  {
    v136 = v134 + 2;
    v112 = opened_patha;
    v103 = v369;
    if ( v134 + 2 < v367.a )
      goto LABEL_214;
  }
  else
  {
    v136 = 2LL;
    v112 = opened_patha;
    v103 = v369;
  }
  smart_str_erealloc(&v367, v136);
  v135 = v367.s;
  v134 = v367.s->len;
LABEL_214:
  *(_WORD *)&v135->val[v134] = 2573;
  v367.s->len = v136;
  efree(*(void **)buf);
LABEL_219:
  v139 = php_stream_context_get_option((php_stream_context *)v112, "http", "header");
  if ( !v139 )
    goto LABEL_236;
  v140 = v139->u1.v.type;
  if ( v140 == 6 )
  {
    if ( !*(_QWORD *)(v139->value.lval + 16) )
      goto LABEL_236;
    v153 = (char *)php_trim(v139->value.str, 0LL, 0LL, 3);
    if ( !v153 )
      goto LABEL_236;
    goto LABEL_381;
  }
  if ( v140 != 7 )
    goto LABEL_236;
  *(_OWORD *)buf = 0LL;
  v141 = (zend_string *)v139->value.lval;
  if ( !*(_DWORD *)v141->val )
    goto LABEL_236;
  v142 = v141->len;
  v143 = 32LL * *(unsigned int *)v141->val;
  v144 = 0LL;
  v145 = 0LL;
  if ( *(_BYTE *)(v142 + 8) != 6 )
    goto LABEL_224;
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
  if ( !v151 )
  {
    v152 = 2LL;
    v103 = v369;
    goto LABEL_233;
  }
  v152 = v149 + 2;
  v103 = v369;
  if ( v149 + 2 >= *(_QWORD *)&buf[8] )
  {
LABEL_233:
    smart_str_erealloc((smart_str *)buf, v152);
    v151 = *(_QWORD *)buf;
    v149 = *(_QWORD *)(*(_QWORD *)buf + 16LL);
  }
  *(_WORD *)(v151 + v149 + 24) = 2573;
  v145 = *(_QWORD *)buf;
  *(_QWORD *)(*(_QWORD *)buf + 16LL) = v152;
LABEL_224:
  while ( 1 )
  {
    v144 += 32LL;
    if ( v143 == v144 )
      break;
    if ( *(_BYTE *)(v142 + v144 + 8) == 6 )
      goto LABEL_226;
  }
  if ( !v145 )
    goto LABEL_236;
  *(_BYTE *)(v145 + *(_QWORD *)(v145 + 16) + 24) = 0;
  if ( !*(_QWORD *)buf )
    goto LABEL_236;
  v153 = (char *)php_trim(*(zend_string **)buf, 0LL, 0LL, 3);
  v271 = *(void **)buf;
  if ( *(_QWORD *)buf )
  {
    if ( (*(_DWORD *)(*(_QWORD *)buf + 4LL) & 0x40) == 0 )
    {
      v21 = (**(_DWORD **)buf)-- == 1;
      if ( v21 )
        efree(v271);
    }
    *(_QWORD *)buf = 0LL;
  }
  *(_QWORD *)&buf[8] = 0LL;
  if ( !v153 )
  {
LABEL_236:
    v154 = 0LL;
    v155 = 0LL;
    goto LABEL_237;
  }
LABEL_381:
  v272 = *((_QWORD *)v153 + 2);
  if ( !v272 )
  {
    v154 = 0LL;
    v155 = 0LL;
    goto LABEL_574;
  }
  v273 = v153 + 24;
  v155 = estrndup(v153 + 24, v272);
  if ( (v153[4] & 0x40) != 0 )
  {
    v301 = *((_QWORD *)v153 + 2);
    v153 = (char *)emalloc((v301 + 32) & 0xFFFFFFFFFFFFFFF8LL);
    *(_QWORD *)v153 = 0x1600000001LL;
    *((_QWORD *)v153 + 1) = 0LL;
    *((_QWORD *)v153 + 2) = v301;
    memcpy(v153 + 24, v273, v301);
    v276 = &v153[v301 + 24];
LABEL_480:
    *v276 = 0;
  }
  else if ( *(_DWORD *)v153 >= 2u )
  {
    --*(_DWORD *)v153;
    v274 = *((_QWORD *)v153 + 2);
    v275 = (char *)emalloc((v274 + 32) & 0xFFFFFFFFFFFFFFF8LL);
    *(_QWORD *)v275 = 0x1600000001LL;
    *((_QWORD *)v275 + 1) = 0LL;
    *((_QWORD *)v275 + 2) = v274;
    memcpy(v275 + 24, v273, v274);
    v276 = &v275[v274 + 24];
    v153 = v275;
    goto LABEL_480;
  }
  v302 = v153 + 24;
  v369 = v153;
  php_strtolower(v153 + 24, *((_QWORD *)v153 + 2));
  if ( (redirect_max & 1) == 0 )
  {
    strip_header(v155, v153 + 24, "content-length:");
    strip_header(v155, v153 + 24, "content-type:");
  }
  v303 = check_has_header(v153 + 24, "user-agent:");
  v304 = v303 + 2;
  if ( !check_has_header(v302, "host:") )
    v304 = v303;
  v305 = v304 + 8;
  if ( !check_has_header(v302, "from:") )
    v305 = v304;
  v306 = v305 + 4;
  if ( !check_has_header(v302, "authorization:") )
    v306 = v305;
  v307 = v306 | 0x10;
  if ( !check_has_header(v302, "content-length:") )
    v307 = v306;
  v308 = v307 | 0x20;
  if ( !check_has_header(v302, "content-type:") )
    v308 = v307;
  v154 = v308 | 0x40;
  if ( !check_has_header(v302, "connection:") )
    v154 = v308;
  if ( v374 )
  {
    v153 = v369;
    if ( (_DWORD)bytes_max )
    {
      v309 = strstr(v302, "proxy-authorization:");
      if ( v309 )
      {
        if ( v309 == v302 || *(v309 - 1) == 10 )
        {
          for ( i = v309; i > v302; --i )
          {
            v311 = *(i - 1);
            if ( v311 != 32 && v311 != 9 )
              break;
          }
          v312 = v309 + 20;
          v313 = 9217LL;
          while ( 1 )
          {
            v314 = *(unsigned __int8 *)v312;
            if ( v314 <= 0xD )
            {
              if ( _bittest64(&v313, v314) )
                break;
            }
            ++v312;
          }
          while ( (_BYTE)v314 == 10 || (_BYTE)v314 == 13 )
            LOBYTE(v314) = *++v312;
          v315 = v154;
          if ( (_BYTE)v314 )
          {
            v326 = &v155[v312 - v302];
            v327 = strlen(v312);
            memmove(&v155[i - v302], v326, v327 + 1);
          }
          else
          {
            if ( i != v302 )
            {
              for ( ; i > v302; --i )
              {
                v316 = *(i - 1);
                if ( v316 != 13 && v316 != 10 )
                  break;
              }
              v155[i - v302] = 0;
              goto LABEL_572;
            }
            efree(v155);
            v155 = 0LL;
          }
          v154 = v315;
          goto LABEL_572;
        }
      }
    }
  }
  else
  {
LABEL_572:
    v153 = v369;
  }
  if ( v153 )
  {
LABEL_574:
    if ( (*((_DWORD *)v153 + 1) & 0x40) == 0 )
    {
      v21 = (*(_DWORD *)v153)-- == 1;
      if ( v21 )
        efree(v153);
    }
  }
  if ( (v154 & 4) == 0 )
  {
LABEL_237:
    v156 = theurl;
    if ( !theurl->user )
      goto LABEL_254;
    bytes_max = v154;
    v157 = strlen(v103);
    v158 = (char *)emalloc(v157 + 1);
    php_url_decode(v156->user->val, v156->user->len);
    strcpy(v158, v156->user->val);
    *(_WORD *)&v158[strlen(v158)] = 58;
    pass = v156->pass;
    if ( pass )
    {
      php_url_decode(pass->val, pass->len);
      strcat(v158, v156->pass->val);
    }
    strlen(v158);
    v160 = (char *)j_resolve_base64_encode();
    v161 = v367.s;
    v369 = v155;
    if ( v367.s )
    {
      v162 = v367.s->len;
      v163 = v162 + 21;
      if ( v162 + 21 < v367.a )
      {
LABEL_242:
        qmemcpy(&v161->val[v162], "Authorization: Basic ", 21);
        v161->len = v163;
        ptr = v160;
        v164 = v160 + 24;
        v165 = strlen(v160 + 24);
        v166 = v165;
        v167 = v165;
        if ( !v161 || (v167 = v163 + v165, v163 + v165 >= v367.a) )
        {
          smart_str_erealloc(&v367, v167);
          v161 = v367.s;
          v163 = v367.s->len;
        }
        memcpy(&v161->val[v163], v164, v166);
        v168 = v367.s;
        v367.s->len = v167;
        if ( v168 )
        {
          v169 = v167 + 2;
          v170 = opened_patha;
          if ( v167 + 2 < v367.a )
            goto LABEL_246;
        }
        else
        {
          v169 = 2LL;
          v170 = opened_patha;
        }
        smart_str_erealloc(&v367, v169);
        v168 = v367.s;
        v167 = v367.s->len;
LABEL_246:
        *(_WORD *)&v168->val[v167] = 2573;
        v367.s->len = v169;
        if ( (_BYTE)v376 && *v170 )
          php_stream_notification_notify((php_stream_context *)v170, 3, 0, 0LL, 0, 0LL, 0LL, 0LL);
        v171 = *((_DWORD *)ptr + 1);
        v155 = v369;
        if ( (v171 & 0x40) == 0 )
        {
          if ( (v171 & 0x80u) != 0 )
            free(ptr);
          else
            efree(ptr);
        }
        efree(v158);
        v154 = bytes_max;
        goto LABEL_254;
      }
    }
    else
    {
      v163 = 21LL;
    }
    smart_str_erealloc(&v367, v163);
    v161 = v367.s;
    v162 = v367.s->len;
    goto LABEL_242;
  }
LABEL_254:
  v369 = v155;
  if ( (v154 & 8) != 0 || !file_globals.from_address )
    goto LABEL_263;
  v172 = v154;
  v173 = v367.s;
  if ( !v367.s )
  {
    v175 = 6LL;
    goto LABEL_653;
  }
  v174 = v367.s->len;
  v175 = v174 + 6;
  if ( v174 + 6 >= v367.a )
  {
LABEL_653:
    smart_str_erealloc(&v367, v175);
    v173 = v367.s;
    v174 = v367.s->len;
  }
  *(_WORD *)&v173->val[v174 + 4] = 8250;
  *(_DWORD *)&v173->val[v174] = 1836020294;
  v176 = v367.s;
  v367.s->len = v175;
  from_address = file_globals.from_address;
  v178 = strlen(from_address);
  v179 = v178;
  v180 = v178;
  if ( !v176 || (v180 = v175 + v178, v175 + v178 >= v367.a) )
  {
    smart_str_erealloc(&v367, v180);
    v176 = v367.s;
    v175 = v367.s->len;
  }
  memcpy(&v176->val[v175], from_address, v179);
  v181 = v367.s;
  v367.s->len = v180;
  if ( v181 )
  {
    v182 = v180 + 2;
    v154 = v172;
    v155 = v369;
    if ( v180 + 2 < v367.a )
      goto LABEL_262;
  }
  else
  {
    v182 = 2LL;
    v154 = v172;
    v155 = v369;
  }
  smart_str_erealloc(&v367, v182);
  v181 = v367.s;
  v180 = v367.s->len;
LABEL_262:
  *(_WORD *)&v181->val[v180] = 2573;
  v367.s->len = v182;
LABEL_263:
  if ( (v154 & 2) != 0 )
  {
    if ( (v154 & 0x40) != 0 )
      goto LABEL_289;
LABEL_273:
    v195 = v367.s;
    if ( v367.s )
    {
      v196 = v367.s->len;
      v197 = v196 + 19;
      if ( v196 + 19 < v367.a )
        goto LABEL_275;
    }
    else
    {
      v197 = 19LL;
    }
    smart_str_erealloc(&v367, v197);
    v195 = v367.s;
    v196 = v367.s->len;
LABEL_275:
    *(_OWORD *)&v195->val[v196] = xmmword_8B251A;
    *(uint32_t *)((char *)&v195[1].gc.u.type_info + v196 + 3) = 168650099;
    v195->len = v197;
    if ( (_BYTE)v376 )
      goto LABEL_290;
    goto LABEL_293;
  }
  v183 = v367.s;
  v184 = v154;
  if ( !v367.s )
  {
    v186 = 6LL;
    goto LABEL_657;
  }
  v185 = v367.s->len;
  v186 = v185 + 6;
  if ( v185 + 6 >= v367.a )
  {
LABEL_657:
    smart_str_erealloc(&v367, v186);
    v183 = v367.s;
    v185 = v367.s->len;
  }
  *(_WORD *)&v183->val[v185 + 4] = 8250;
  *(_DWORD *)&v183->val[v185] = 1953722184;
  v187 = v367.s;
  v367.s->len = v186;
  v188 = theurl->host->val;
  v189 = strlen(v188);
  v190 = v189;
  v191 = v189;
  if ( !v187 || (v191 = v186 + v189, v186 + v189 >= v367.a) )
  {
    smart_str_erealloc(&v367, v191);
    v187 = v367.s;
    v186 = v367.s->len;
  }
  memcpy(&v187->val[v186], v188, v190);
  v192 = v367.s;
  v367.s->len = v191;
  v193 = theurl;
  v194 = theurl->port;
  if ( !v374 )
  {
    v154 = v184;
    v155 = v369;
    if ( !v194 || v194 == 80 )
      goto LABEL_286;
LABEL_279:
    if ( v192 )
    {
      v198 = v191 + 1;
      if ( v198 < v367.a )
        goto LABEL_281;
    }
    else
    {
      v198 = 1LL;
    }
    smart_str_erealloc(&v367, v198);
    v192 = v367.s;
LABEL_281:
    *((_BYTE *)&v192->len + v198 + 7) = 58;
    v367.s->len = v198;
    v199 = v193->port;
    v394[0] = 0;
    v200 = v394;
    do
    {
      *--v200 = (v199 % 0xA) | 0x30;
      v60 = v199 <= 9;
      v199 /= 0xAuLL;
    }
    while ( !v60 );
    v201 = (char *)(v394 - v200);
    v202 = v367.s;
    v203 = (char *)(v394 - v200);
    if ( !v367.s || (v204 = v367.s->len, v203 = &v201[v204], (unsigned __int64)&v201[v204] >= v367.a) )
    {
      smart_str_erealloc(&v367, (size_t)v203);
      v202 = v367.s;
      v204 = v367.s->len;
    }
    memcpy(&v202->val[v204], v200, v394 - v200);
    v192 = v367.s;
    v367.s->len = (size_t)v203;
    v155 = v369;
    goto LABEL_286;
  }
  v154 = v184;
  v155 = v369;
  if ( v194 && v194 != 443 )
    goto LABEL_279;
LABEL_286:
  if ( v192 )
  {
    v205 = v192->len;
    v206 = v205 + 2;
    if ( v205 + 2 < v367.a )
      goto LABEL_288;
  }
  else
  {
    v206 = 2LL;
  }
  smart_str_erealloc(&v367, v206);
  v192 = v367.s;
  v205 = v367.s->len;
LABEL_288:
  *(_WORD *)&v192->val[v205] = 2573;
  v367.s->len = v206;
  if ( (v154 & 0x40) == 0 )
    goto LABEL_273;
LABEL_289:
  if ( !(_BYTE)v376 )
  {
LABEL_293:
    user_agent = file_globals.user_agent;
    goto LABEL_294;
  }
LABEL_290:
  v207 = php_stream_context_get_option((php_stream_context *)opened_patha, "http", "user_agent");
  if ( !v207 || v207->u1.v.type != 6 )
    goto LABEL_293;
  user_agent = (char *)(v207->value.lval + 24);
LABEL_294:
  v209 = v377;
  v210 = opened_patha;
  if ( (v154 & 1) == 0 )
  {
    if ( user_agent )
    {
      v211 = strlen(user_agent);
      v212 = v211 + 17;
      if ( v211 + 17 >= 0x12 )
      {
        bytes_max = v154;
        v154 = (size_t)emalloc(v211 + 18);
        v213 = ap_php_slprintf((char *)v154, v212, "User-Agent: %s\r\n", user_agent);
        if ( v213 )
        {
          v214 = v213;
          *(_BYTE *)(v154 + v213) = 0;
          v215 = v367.s;
          v216 = v214;
          if ( !v367.s || (v217 = v367.s->len, v216 = v217 + v214, v217 + v214 >= v367.a) )
          {
            smart_str_erealloc(&v367, v216);
            v215 = v367.s;
            v217 = v367.s->len;
          }
          memcpy(&v215->val[v217], (const void *)v154, v214);
          v367.s->len = v216;
          v210 = opened_patha;
          v155 = v369;
        }
        else
        {
          php_error_docref(0LL, 2, "Cannot construct User-agent header");
        }
        efree((void *)v154);
        LOBYTE(v154) = bytes_max;
      }
    }
  }
  if ( !v155 )
    goto LABEL_322;
  if ( ((unsigned __int8)(v154 & 0x10) >> 4) | (unsigned __int8)v372 ^ 1 )
    goto LABEL_317;
  v218 = php_stream_context_get_option((php_stream_context *)v210, "http", "content");
  if ( !v218 )
    goto LABEL_317;
  v219 = v218;
  if ( v218->u1.v.type != 6 || !*(_QWORD *)(v218->value.lval + 16) )
    goto LABEL_317;
  v220 = v367.s;
  if ( !v367.s )
  {
    v222 = 16LL;
    goto LABEL_686;
  }
  v221 = v367.s->len;
  v222 = v221 + 16;
  if ( v221 + 16 >= v367.a )
  {
LABEL_686:
    smart_str_erealloc(&v367, v222);
    v220 = v367.s;
    v221 = v367.s->len;
  }
  *(_OWORD *)&v220->val[v221] = xmmword_8B2562;
  v367.s->len = v222;
  v223 = *(_QWORD *)(v219->value.lval + 16);
  v394[0] = 0;
  v224 = v394;
  do
  {
    *--v224 = (v223 % 0xA) | 0x30;
    v60 = v223 <= 9;
    v223 /= 0xAuLL;
  }
  while ( !v60 );
  v225 = (char *)(v394 - v224);
  v226 = v367.s;
  v227 = (char *)(v394 - v224);
  if ( !v367.s || (v228 = v367.s->len, v227 = &v225[v228], (unsigned __int64)&v225[v228] >= v367.a) )
  {
    smart_str_erealloc(&v367, (size_t)v227);
    v226 = v367.s;
    v228 = v367.s->len;
  }
  memcpy(&v226->val[v228], v224, v394 - v224);
  v229 = v367.s;
  v367.s->len = (size_t)v227;
  if ( v229 )
  {
    v230 = (size_t)(v227 + 2);
    v210 = opened_patha;
    v155 = v369;
    if ( (unsigned __int64)(v227 + 2) < v367.a )
      goto LABEL_316;
  }
  else
  {
    v230 = 2LL;
    v210 = opened_patha;
    v155 = v369;
  }
  smart_str_erealloc(&v367, v230);
  v229 = v367.s;
  v227 = (char *)v367.s->len;
LABEL_316:
  *(_WORD *)&v227[(_QWORD)v229 + 24] = 2573;
  v367.s->len = v230;
  LOBYTE(v154) = v154 | 0x10;
LABEL_317:
  v231 = strlen(v155);
  v232 = v367.s;
  v233 = v231;
  if ( !v367.s || (v234 = v367.s->len, v233 = v234 + v231, v234 + v231 >= v367.a) )
  {
    smart_str_erealloc(&v367, v233);
    v232 = v367.s;
    v234 = v367.s->len;
  }
  memcpy(&v232->val[v234], v155, v231);
  v235 = v367.s;
  v367.s->len = v233;
  if ( v235 )
  {
    v236 = v233 + 2;
    if ( v233 + 2 < v367.a )
      goto LABEL_321;
  }
  else
  {
    v236 = 2LL;
  }
  smart_str_erealloc(&v367, v236);
  v235 = v367.s;
  v233 = v367.s->len;
LABEL_321:
  *(_WORD *)&v235->val[v233] = 2573;
  v367.s->len = v236;
  efree(v155);
LABEL_322:
  v237 = v383;
  if ( !(_BYTE)v372
    || (v238 = php_stream_context_get_option((php_stream_context *)v210, "http", "content")) == 0LL
    || (v239 = v238, v238->u1.v.type != 6)
    || !*(_QWORD *)(v238->value.lval + 16) )
  {
    v263 = v367.s;
    if ( v367.s )
    {
      v264 = v367.s->len;
      v262 = v264 + 2;
      if ( v264 + 2 < v367.a )
      {
LABEL_347:
        *(_WORD *)&v263->val[v264] = 2573;
        goto LABEL_348;
      }
    }
    else
    {
      v262 = 2LL;
    }
    smart_str_erealloc(&v367, v262);
    v263 = v367.s;
    v264 = v367.s->len;
    goto LABEL_347;
  }
  if ( (v154 & 0x10) != 0 )
    goto LABEL_336;
  v240 = v367.s;
  if ( !v367.s )
  {
    v242 = 16LL;
    goto LABEL_690;
  }
  v241 = v367.s->len;
  v242 = v241 + 16;
  if ( v241 + 16 >= v367.a )
  {
LABEL_690:
    smart_str_erealloc(&v367, v242);
    v240 = v367.s;
    v241 = v367.s->len;
  }
  v243 = v154;
  *(_OWORD *)&v240->val[v241] = xmmword_8B2562;
  v367.s->len = v242;
  v244 = *(_QWORD *)(v239->value.lval + 16);
  v394[0] = 0;
  v245 = v394;
  do
  {
    *--v245 = (v244 % 0xA) | 0x30;
    v60 = v244 <= 9;
    v244 /= 0xAuLL;
  }
  while ( !v60 );
  v246 = (char *)(v394 - v245);
  v247 = v367.s;
  v154 = v394 - v245;
  if ( !v367.s || (v248 = v367.s->len, v154 = (size_t)&v246[v248], (unsigned __int64)&v246[v248] >= v367.a) )
  {
    smart_str_erealloc(&v367, v154);
    v247 = v367.s;
    v248 = v367.s->len;
  }
  memcpy(&v247->val[v248], v245, v394 - v245);
  v249 = v367.s;
  v367.s->len = v154;
  if ( v249 )
  {
    v250 = v154 + 2;
    if ( v154 + 2 < v367.a )
      goto LABEL_335;
  }
  else
  {
    v250 = 2LL;
  }
  smart_str_erealloc(&v367, v250);
  v249 = v367.s;
  v154 = v367.s->len;
LABEL_335:
  *(_WORD *)&v249->val[v154] = 2573;
  v367.s->len = v250;
  v237 = v383;
  LOBYTE(v154) = v243;
LABEL_336:
  if ( (v154 & 0x20) == 0 )
  {
    v251 = v237;
    v252 = v367.s;
    if ( v367.s )
    {
      v253 = v367.s->len;
      v254 = v253 + 49;
      if ( v253 + 49 < v367.a )
        goto LABEL_339;
    }
    else
    {
      v254 = 49LL;
    }
    smart_str_erealloc(&v367, v254);
    v252 = v367.s;
    v253 = v367.s->len;
LABEL_339:
    *(_OWORD *)&v252[1].val[v253] = xmmword_8B2593;
    *(_OWORD *)((char *)&v252[1].h + v253) = xmmword_8B2583;
    *(_OWORD *)&v252->val[v253] = xmmword_8B2573;
    *((_BYTE *)&v252[2].h + v253) = 10;
    v252->len = v254;
    php_error_docref(0LL, 8, "Content-type not specified assuming application/x-www-form-urlencoded");
    v237 = v251;
  }
  v255 = v367.s;
  v256 = v237;
  if ( !v367.s )
  {
    v258 = 2LL;
    goto LABEL_682;
  }
  v257 = v367.s->len;
  v258 = v257 + 2;
  if ( v257 + 2 >= v367.a )
  {
LABEL_682:
    smart_str_erealloc(&v367, v258);
    v255 = v367.s;
    v257 = v367.s->len;
  }
  *(_WORD *)&v255->val[v257] = 2573;
  v259 = v367.s;
  v367.s->len = v258;
  v260 = *(_QWORD *)(v239->value.lval + 16);
  v261 = (const void *)(v239->value.lval + 24);
  v262 = v260;
  if ( !v259 || (v262 = v260 + v258, v260 + v258 >= v367.a) )
  {
    smart_str_erealloc(&v367, v262);
    v259 = v367.s;
    v258 = v367.s->len;
  }
  memcpy(&v259->val[v258], v261, v260);
  v237 = v256;
LABEL_348:
  v265 = v367.s;
  v367.s->len = v262;
  php_stream_write(v209, v265->val, v262);
  buf[0] = 0;
  if ( !LOBYTE(flags[1].dval) )
  {
    flags->lval = (zend_long)zend_new_array_0();
    flags[1].ww.w1 = 775;
  }
  v381 &= 0xCu;
  if ( php_stream_eof(v209) || !php_stream_get_line(v209, s1, 0x7FuLL, returned_len) )
  {
    php_stream_free(v209, 3);
    v43 = 0LL;
    php_stream_wrapper_log_error(v237, v368, "HTTP request failed!");
    v44 = 0LL;
    v46 = 0LL;
    v19 = 0LL;
    v42 = src;
    v45 = v384;
    goto out;
  }
  v266 = 0;
  if ( returned_len[0] >= 0xA )
    v266 = atoi(nptr);
  if ( (_BYTE)v376
    && (v267 = php_stream_context_get_option((php_stream_context *)opened_patha, "http", "ignore_errors")) != 0LL )
  {
    is_true = zend_is_true((zval_1 *)v267);
    LOBYTE(is_true) = is_true != 0;
  }
  else
  {
    is_true = 0;
  }
  LODWORD(ptr) = is_true;
  v387 = ((unsigned int)v368 >> 9) & 1;
  v372 = v387 | (unsigned __int8)is_true;
  if ( v266 != 101 && (unsigned int)(v266 - 100) <= 0x63 )
  {
    v269 = v237;
    if ( php_stream_eof(v209) )
      goto LABEL_362;
    while ( 2 )
    {
      if ( php_stream_get_line(v209, s1, 0x7FuLL, returned_len) )
      {
        v270 = returned_len[0];
        if ( returned_len[0] >= 6 && !strncasecmp(s1, "HTTP/1", 6uLL) )
        {
LABEL_363:
          v266 = 0;
          if ( v270 >= 0xA )
          {
            v266 = atoi(nptr);
            v237 = v269;
            goto LABEL_365;
          }
LABEL_398:
          if ( !v270 )
            s1[0] = 0;
          if ( (_BYTE)v376 )
          {
            v237 = v269;
            if ( *opened_patha )
              php_stream_notification_notify((php_stream_context *)opened_patha, 9, 2, s1, v266, 0LL, 0LL, 0LL);
          }
          else
          {
            v237 = v269;
          }
          goto LABEL_404;
        }
        if ( !php_stream_eof(v209) )
          continue;
      }
      break;
    }
LABEL_362:
    v270 = returned_len[0];
    goto LABEL_363;
  }
LABEL_365:
  if ( (unsigned int)(v266 - 200) >= 0xC8 )
  {
    if ( v266 != 403 )
    {
      v269 = v237;
      v270 = returned_len[0];
      goto LABEL_398;
    }
    v266 = 403;
    if ( (_BYTE)v376 && *opened_patha )
    {
      v266 = 403;
      php_stream_notification_notify((php_stream_context *)opened_patha, 10, 2, s1, 403, 0LL, 0LL, 0LL);
    }
  }
  else
  {
    v372 = 1;
  }
LABEL_404:
  v277 = returned_len[0];
  v278 = v237;
  if ( !returned_len[0] )
    goto LABEL_410;
  if ( *((_BYTE *)&optionvalue.u2.opline_num + returned_len[0] + 3) != 10 )
    goto LABEL_409;
  v279 = --returned_len[0];
  if ( v277 == 1 )
  {
LABEL_410:
    v279 = 0LL;
  }
  else if ( *((_BYTE *)&optionvalue.u2.cache_slot + v277 + 2) == 13 )
  {
    v277 -= 2LL;
    returned_len[0] = v277;
LABEL_409:
    v279 = v277;
  }
  v280 = (zend_string *)emalloc((v279 + 32) & 0xFFFFFFFFFFFFFFF8LL);
  v280->gc = (zend_refcounted_h)0x1600000001LL;
  v280->h = 0LL;
  v280->len = v279;
  memcpy(v280->val, s1, v279);
  v280->val[v279] = 0;
  str.s = v280;
  LODWORD(str.a) = 262;
  zend_hash_next_index_insert(flags->arr, (zval *)&str);
  v281 = php_stream_eof(v209);
  if ( v281 )
  {
    LOBYTE(v281) = 1;
    LODWORD(v369) = v281;
    v43 = 0LL;
    bytes_max = 0LL;
    v46 = 0LL;
    v282 = v278;
    v283 = v382;
    goto LABEL_463;
  }
  v386 = v368 & 0x200;
  v284 = v266 & 0xFFFFFFFC;
  v378 = (v266 & 0xFFFFFFFC) == 300 || (unsigned int)(v266 - 307) < 2;
  LOBYTE(v284) = 1;
  LODWORD(v369) = v284;
  v46 = 0LL;
  bytes_max = 0LL;
  v285 = 0LL;
  v282 = v278;
  v283 = v382;
  while ( 2 )
  {
    if ( v46 )
      efree(v46);
    line = php_stream_get_line(v377, 0LL, 0LL, returned_len);
    v46 = line;
    if ( !line || (v287 = *line, *v46 == 10) || v287 == 13 )
    {
      v43 = v285;
      break;
    }
    for ( j = &v46[returned_len[0] - 1]; j >= v46; --j )
    {
      if ( *j != 13 && *j != 10 )
        break;
    }
    while ( j >= v46 && (*j == 32 || *j == 9) )
      --j;
    v289 = j + 1;
    j[1] = 0;
    returned_len[0] = j + 1 - v46;
    v290 = (char *)memchr(v46, 58, returned_len[0]);
    if ( v290 )
    {
      if ( v290 < j )
      {
        do
        {
          v291 = v290[1];
          if ( v291 != 32 && v291 != 9 )
            break;
          ++v290;
        }
        while ( j != v290 );
      }
      v289 = v290 + 1;
    }
    if ( !strncasecmp(v46, "Location:", 9uLL) )
    {
      if ( (_BYTE)v376
        && (v294 = php_stream_context_get_option((php_stream_context *)opened_patha, "http", "follow_location")) != 0LL )
      {
        v295 = zend_is_true((zval_1 *)v294);
        LOBYTE(v295) = v295 != 0;
        LODWORD(v369) = v295;
      }
      else
      {
        v296 = (unsigned __int8)v369;
        if ( !v378 )
          v296 = 0;
        LODWORD(v369) = v296;
      }
      php_strlcpy(buf, v289, 0x400uLL);
      goto LABEL_459;
    }
    if ( !strncasecmp(v46, "Content-Type:", 0xDuLL) )
    {
      if ( (_BYTE)v376 && *opened_patha )
        php_stream_notification_notify((php_stream_context *)opened_patha, 4, 0, v289, 0, 0LL, 0LL, 0LL);
      goto LABEL_459;
    }
    if ( !strncasecmp(v46, "Content-Length:", 0xFuLL) )
    {
      bytes_max = atoi(v289);
      if ( (_BYTE)v376 && *opened_patha )
        php_stream_notification_notify((php_stream_context *)opened_patha, 5, 0, v46, 0, 0LL, bytes_max, 0LL);
LABEL_459:
      v297 = returned_len[0];
      v298 = (zend_string *)emalloc((returned_len[0] + 32) & 0xFFFFFFFFFFFFFFF8LL);
      v298->gc = (zend_refcounted_h)0x1600000001LL;
      v298->h = 0LL;
      v298->len = v297;
      memcpy(v298->val, v46, v297);
      v298->val[v297] = 0;
      str.s = v298;
      LODWORD(str.a) = 262;
      zend_hash_next_index_insert(flags->arr, (zval *)&str);
      v43 = v285;
      goto LABEL_460;
    }
    if ( strncasecmp(v46, "Transfer-Encoding:", 0x12uLL) )
      goto LABEL_459;
    v292 = strncasecmp(v289, "Chunked", 7uLL);
    if ( v386 | v292 )
      goto LABEL_459;
    if ( (_BYTE)v376 )
    {
      v293 = php_stream_context_get_option((php_stream_context *)opened_patha, "http", "auto_decode");
      if ( v293 )
      {
        if ( !zend_is_true((zval_1 *)v293) )
          goto LABEL_459;
      }
    }
    v43 = php_stream_filter_create("dechunk", 0LL, *((_BYTE *)v377 + 96) & 1);
    v285 = 0LL;
    if ( !v43 )
      goto LABEL_459;
LABEL_460:
    v299 = php_stream_eof(v377);
    v285 = v43;
    v282 = v383;
    if ( !v299 )
      continue;
    break;
  }
LABEL_463:
  if ( v372 )
  {
    v19 = v377;
    v45 = v384;
    if ( ((unsigned __int8)v369 & 1) == 0 || !buf[0] )
    {
LABEL_522:
      v42 = src;
      goto LABEL_523;
    }
  }
  else
  {
    v19 = v377;
    v45 = v384;
    if ( ((unsigned __int8)v369 & 1) == 0 )
      goto LABEL_522;
  }
  if ( v283 <= 1 && ((_BYTE)ptr != 0) | (unsigned __int8)v387 )
    goto LABEL_522;
  v379 |= buf[0] == 0;
  if ( !v379 && *opened_patha )
    php_stream_notification_notify((php_stream_context *)opened_patha, 6, 0, buf, 0, 0LL, 0LL, 0LL);
  php_stream_free(v19, 3);
  if ( v43 )
    php_stream_filter_free(v43);
  v300 = buf[0];
  if ( !buf[0] )
  {
    v43 = 0LL;
    php_stream_wrapper_log_error(v282, v368, "HTTP request failed! %s", s1);
    v19 = 0LL;
    goto LABEL_522;
  }
  LOBYTE(str.s) = 0;
  if ( strlen(buf) >= 8
    && (!strncasecmp(buf, "http://", 7uLL)
     || !strncasecmp(buf, "https://", 8uLL)
     || !strncasecmp(buf, "ftp://", 6uLL)
     || !strncasecmp(buf, "ftps://", 7uLL)) )
  {
    php_strlcpy((char *)&str, buf, 0x400uLL);
    v322 = theurl;
    goto LABEL_597;
  }
  if ( v300 == 47 )
  {
    php_strlcpy((char *)returned_len, buf, 0x400uLL);
  }
  else
  {
    v323 = v282;
    if ( buf[1] && (v324 = theurl->path) != 0LL )
    {
      v325 = strrchr(v324->val, 47);
      if ( !v325 )
      {
        if ( v324->len )
        {
          v324->val[0] = 47;
          v325 = v324->val;
        }
        else
        {
          if ( (v324->gc.u.type_info & 0x40) == 0 )
          {
            v21 = v324->gc.refcount-- == 1;
            if ( v21 )
              efree(v324);
          }
          v336 = (char *)emalloc_32();
          *(_QWORD *)v336 = 0x1600000001LL;
          *(_OWORD *)(v336 + 8) = xmmword_7CACC0;
          *((_WORD *)v336 + 12) = 47;
          theurl->path = (zend_string *)v336;
          v325 = v336 + 24;
          v45 = v384;
        }
      }
      v325[1] = 0;
      v337 = theurl->path;
      if ( v337 && v337->val[0] == 47 && !v337->val[1] )
        ap_php_snprintf((char *)returned_len, 0x3FFuLL, "%s%s", v337->val, buf);
      else
        ap_php_snprintf((char *)returned_len, 0x3FFuLL, "%s/%s", v337->val, buf);
      v282 = v323;
      v283 = v382;
    }
    else
    {
      ap_php_snprintf((char *)returned_len, 0x3FFuLL, "/%s", buf);
      v282 = v323;
    }
  }
  v338 = theurl->port;
  if ( v374 )
  {
    if ( (_DWORD)v338 == 443 )
      goto LABEL_594;
LABEL_596:
    v322 = theurl;
    ap_php_snprintf(
      (char *)&str,
      0x3FFuLL,
      "%s://%s:%d%s",
      theurl->scheme->val,
      theurl->host->val,
      v338,
      (const char *)returned_len);
  }
  else
  {
    if ( (_WORD)v338 != 80 )
      goto LABEL_596;
LABEL_594:
    v322 = theurl;
    ap_php_snprintf(
      (char *)&str,
      0x3FFuLL,
      "%s://%s%s",
      theurl->scheme->val,
      theurl->host->val,
      (const char *)returned_len);
  }
LABEL_597:
  php_url_free(v322);
  theurl = php_url_parse((const char *)&str);
  if ( !theurl )
  {
    v19 = 0LL;
    php_stream_wrapper_log_error(v282, v368, "Invalid redirect URL! %s", &str);
    goto LABEL_618;
  }
  v339 = v282;
  if ( !strncasecmp((const char *)&str, "http://", 7uLL) && !strncasecmp((const char *)&str, "https://", 8uLL) )
    goto LABEL_615;
  user = theurl->user;
  if ( !user || (v341 = php_url_decode(user->val, user->len), v342 = theurl->user, v342->len = v341, v341 <= 0) )
  {
LABEL_605:
    v346 = theurl->pass;
    if ( v346 )
    {
      v347 = php_url_decode(v346->val, v346->len);
      v348 = theurl->pass;
      v348->len = v347;
      if ( v347 > 0 )
      {
        v349 = (unsigned __int64)&v348->val[v347];
        v350 = v348->val;
        v351 = *__ctype_b_loc();
        while ( (v351[(unsigned __int8)*v350] & 2) == 0 )
        {
          if ( (unsigned __int64)++v350 >= v349 )
            goto LABEL_610;
        }
        goto LABEL_617;
      }
    }
LABEL_610:
    v352 = theurl->path;
    if ( v352 )
    {
      v353 = php_url_decode(v352->val, v352->len);
      v354 = theurl->path;
      v354->len = v353;
      if ( v353 > 0 )
      {
        v355 = (unsigned __int64)&v354->val[v353];
        v356 = v354->val;
        v357 = *__ctype_b_loc();
        while ( (v357[(unsigned __int8)*v356] & 2) == 0 )
        {
          if ( (unsigned __int64)++v356 >= v355 )
            goto LABEL_615;
        }
        goto LABEL_617;
      }
    }
LABEL_615:
    v358 = (php_stream_context *)(unsigned int)(v283 - 1);
    v42 = src;
    v19 = php_stream_url_wrap_http_ex(v339, (char *)&str, src, v368, opened_patha, v358, 2, flags);
    v43 = 0LL;
    goto LABEL_523;
  }
  v343 = (unsigned __int64)&v342->val[v341];
  v344 = v342->val;
  v345 = *__ctype_b_loc();
  while ( (v345[(unsigned __int8)*v344] & 2) == 0 )
  {
    if ( (unsigned __int64)++v344 >= v343 )
      goto LABEL_605;
  }
LABEL_617:
  v19 = 0LL;
  php_stream_wrapper_log_error(v339, v368, "Invalid redirect URL! %s", &str);
LABEL_618:
  v42 = src;
  v43 = 0LL;
LABEL_523:
  v44 = bytes_max;
out:
  v317 = v367.s;
  if ( v367.s )
  {
    if ( (v367.s->gc.u.type_info & 0x40) == 0 )
    {
      v21 = v367.s->gc.refcount-- == 1;
      if ( v21 )
        efree(v317);
    }
    v367.s = 0LL;
  }
  v367.a = 0LL;
  if ( v46 )
    efree(v46);
  if ( theurl )
    php_url_free(theurl);
  if ( !v19 )
    return 0LL;
  if ( (redirect_max & 1) != 0 )
  {
    v318 = (_DWORD *)flags->lval;
    w1 = flags[1].ww.w1;
    v19->wrapperdata.value = (zend_value_1)flags->lval;
    v19->wrapperdata.u1.type_info = w1;
    if ( (w1 & 0xFF00) != 0 )
      ++*v318;
  }
  if ( (_BYTE)v376 )
  {
    v320 = *opened_patha;
    if ( *opened_patha )
    {
      v320[1].h = 0LL;
      v320[1].len = v44;
      LOBYTE(v320[1].gc.refcount) |= 1u;
      php_stream_notification_notify((php_stream_context *)opened_patha, 7, 0, 0LL, 0, 0LL, v44, 0LL);
    }
  }
  if ( (v368 & 0x20) != 0 )
    php_stream_set_option(v19, 5, v45, 0LL);
  v19->flags |= v381;
  v19->position = 0LL;
  php_strlcpy(v19->mode, v42, 0x10uLL);
  if ( v43 )
    php_stream_filter_append(&v19->readfilters, v43);
  return v19;
}

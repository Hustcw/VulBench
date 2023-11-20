GfxGouraudTriangleShading *__fastcall GfxGouraudTriangleShading::parse(
        GfxResources *res,
        int typeA,
        Dict *dict,
        Stream *str,
        OutputDev *out,
        GfxState *gfxState)
{
  __m128d v6;
  double v7;
  __int64 v11;
  GfxGouraudTriangleShading *v12;
  __int64 v13;
  __m128d v14;
  int v15;
  __m128d v16;
  int Length;
  __int64 v18;
  int v19;
  bool v20;
  int v21;
  int v23;
  int v24;
  GfxShadingBitBuf *v25;
  double v26;
  int v27;
  int v28;
  __int64 v29;
  unsigned int *v30;
  double v31;
  int v32;
  unsigned int v33;
  Stream *v34;
  Stream *v35;
  Stream *v36;
  double v37;
  __int64 v38;
  __m128i v39;
  __m128d v40;
  Stream *v41;
  __int64 v42;
  unsigned int v43;
  __int64 v44;
  __int64 v45;
  int (*v46)[3];
  int v47;
  unsigned __int64 v48;
  int v49;
  int (*v50)[3];
  unsigned __int64 v51;
  GfxState *v52;
  GfxResources *v53;
  int v54;
  int v55;
  int (*v56)[3];
  int *v57;
  int v58;
  int v59;
  int v60;
  int *v61;
  int v62;
  int v63;
  int v64;
  std::vector<std::unique_ptr<Function>> *funcsA;
  double v67;
  unsigned int v68;
  Object funcObj;
  void *ok;
  int __lcpp_y;
  Stream *strA;
  int (*v73[2])[3];
  double v74;
  int n;
  unsigned int val;
  double Num;
  __int64 v78;
  unsigned int v79;
  __m128d v80;
  void *p[2];
  GfxResources *v82;
  GfxState *v83;
  Dict *v84;
  int v85[2];
  __m128d v86;
  __m128d v87;
  __m128d v88;
  OutputDev *v89;
  char v90[24];
  Object v91;
  Object other;
  double v93[39];

  strA = str;
  std::vector<std::unique_ptr<Function>>::vector((std::vector<std::unique_ptr<Function>> *)v90);
  Object::Object(&funcObj);
  Dict::lookup(dict, "BitsPerCoordinate", 0);
  Object::operator=(&funcObj, &other);
  Object::~Object(&other);
  if ( Object::isInt(&funcObj) )
  {
    __lcpp_y = Object::getInt(&funcObj);
    if ( __lcpp_y <= 0 )
    {
      v12 = 0LL;
      error(ErrorCategory::errSyntaxWarning, -1LL, "Invalid BitsPerCoordinate in shading dictionary");
      goto LABEL_27;
    }
    Dict::lookup(dict, "BitsPerComponent", 0);
    Object::operator=(&funcObj, &other);
    Object::~Object(&other);
    if ( Object::isInt(&funcObj) )
    {
      LODWORD(v11) = Object::getInt(&funcObj);
      *(_QWORD *)v85 = v11;
      if ( (unsigned int)(v11 - 1) > 0x1E )
      {
        v12 = 0LL;
        error(ErrorCategory::errSyntaxWarning, -1LL, "Invalid BitsPerComponent in shading dictionary");
        goto LABEL_27;
      }
      if ( typeA == 4 )
      {
        v78 = 0LL;
        Dict::lookup(dict, "BitsPerFlag", 0);
        Object::operator=(&funcObj, &other);
        Object::~Object(&other);
        if ( !Object::isInt(&funcObj) )
        {
          v12 = 0LL;
          error(ErrorCategory::errSyntaxWarning, -1LL, "Missing or invalid BitsPerFlag in shading dictionary");
          goto LABEL_27;
        }
        n = Object::getInt(&funcObj);
      }
      else
      {
        n = 0;
        Dict::lookup(dict, "VerticesPerRow", 0);
        Object::operator=(&funcObj, &other);
        Object::~Object(&other);
        if ( !Object::isInt(&funcObj) )
        {
          v12 = 0LL;
          error(ErrorCategory::errSyntaxWarning, -1LL, "Missing or invalid VerticesPerRow in shading dictionary");
          goto LABEL_27;
        }
        LODWORD(v13) = Object::getInt(&funcObj);
        v78 = v13;
      }
      Dict::lookup(dict, "Decode", 0);
      Object::operator=(&funcObj, &other);
      Object::~Object(&other);
      if ( !Object::isArray(&funcObj) || Object::arrayGetLength(&funcObj) < 6 )
        goto LABEL_24;
      v82 = res;
      v89 = out;
      v83 = gfxState;
      LOBYTE(ok) = 1;
      LODWORD(out) = 0;
      Object::arrayGet(&funcObj, 0, 0);
      v6.m128d_f64[0] = Object::getNum(&other, (bool *)&ok);
      v87 = v6;
      Object::~Object(&other);
      Object::arrayGet(&funcObj, 1, 0);
      v6.m128d_f64[0] = Object::getNum(&other, (bool *)&ok);
      v88 = v6;
      Object::~Object(&other);
      v14 = (__m128d)0x4000000000000000uLL;
      v15 = __lcpp_y;
      v14.m128d_f64[0] = pow<double,int>(v7, __lcpp_y);
      *(__m128d *)v73 = v14;
      Object::arrayGet(&funcObj, 2, 0);
      v14.m128d_f64[0] = Object::getNum(&other, (bool *)&ok);
      *(__m128d *)p = v14;
      Object::~Object(&other);
      Object::arrayGet(&funcObj, 3, 0);
      v14.m128d_f64[0] = Object::getNum(&other, (bool *)&ok);
      v80 = v14;
      Object::~Object(&other);
      v16 = (__m128d)0x4000000000000000uLL;
      v16.m128d_f64[0] = pow<double,int>(v7, v15);
      v86 = v16;
      Length = Object::arrayGetLength(&funcObj);
      v84 = dict;
      if ( Length >= 6 )
      {
        v67 = (double)~(-1 << SLOBYTE(v85[0]));
        v18 = 7LL;
        out = 0LL;
        do
        {
          Object::arrayGet(&funcObj, v18 - 3, 0);
          Num = Object::getNum(&v91, (bool *)&ok);
          *((double *)&other.type + (_QWORD)out) = Num;
          Object::~Object(&v91);
          Object::arrayGet(&funcObj, v18 - 2, 0);
          v74 = Object::getNum(&v91, (bool *)&ok);
          Object::~Object(&v91);
          v93[(_QWORD)out] = (v74 - Num) / v67;
          out = (OutputDev *)((char *)out + 1);
          v19 = Object::arrayGetLength(&funcObj);
          if ( (unsigned __int64)out > 0x1F )
            break;
          v20 = v18 < v19;
          v18 += 2LL;
        }
        while ( v20 );
        dict = v84;
      }
      if ( !(_BYTE)ok )
      {
LABEL_24:
        v12 = 0LL;
        error(ErrorCategory::errSyntaxWarning, -1LL, "Missing or invalid Decode array in shading dictionary");
        goto LABEL_27;
      }
      v68 = 0;
      Dict::lookup(dict, "Function", 0);
      Object::operator=(&funcObj, &v91);
      Object::~Object(&v91);
      if ( !Object::isNull(&funcObj) )
      {
        if ( Object::isArray(&funcObj) )
        {
          v21 = Object::arrayGetLength(&funcObj);
          if ( v21 > 32 )
          {
            v12 = 0LL;
            error(ErrorCategory::errSyntaxWarning, -1LL, "Invalid Function array in shading dictionary");
            goto LABEL_27;
          }
          v23 = v21;
          if ( v21 > 0 )
          {
            v24 = 0;
            while ( 1 )
            {
              Object::arrayGet(&funcObj, v24, 0);
              ok = Function::parse(&v91);
              if ( !ok )
                break;
              std::vector<std::unique_ptr<Function>>::emplace_back<Function*&>(
                (std::vector<std::unique_ptr<Function>> *)v90,
                (Function **)&ok);
              Object::~Object(&v91);
              if ( v23 == ++v24 )
                goto LABEL_34;
            }
            Object::~Object(&v91);
            goto LABEL_84;
          }
        }
        else
        {
          *(_QWORD *)&v91.type = Function::parse(&funcObj);
          if ( !*(_QWORD *)&v91.type )
            goto LABEL_84;
          std::vector<std::unique_ptr<Function>>::emplace_back<Function*&>(
            (std::vector<std::unique_ptr<Function>> *)v90,
            (Function **)&v91);
        }
      }
LABEL_34:
      v88 = _mm_div_pd(
              _mm_sub_pd(_mm_unpacklo_pd(v88, v80), _mm_unpacklo_pd(v87, *(__m128d *)p)),
              _mm_add_pd(_mm_unpacklo_pd(*(__m128d *)v73, v86), (__m128d)xmmword_50A670));
      val = 0;
      v25 = (GfxShadingBitBuf *)operator new(0x10uLL);
      GfxShadingBitBuf::GfxShadingBitBuf(v25, strA);
      v87 = _mm_unpacklo_pd(v87, *(__m128d *)p);
      v26 = 0.0;
      v73[0] = 0LL;
      p[0] = 0LL;
      strA = 0LL;
      Num = 0.0;
      v86.m128d_f64[0] = 0.0;
      v27 = 0;
LABEL_35:
      v28 = typeA;
LABEL_36:
      LODWORD(v80.m128d_f64[0]) = v27;
      while ( (v28 != 4 || GfxShadingBitBuf::getBits(v25, n, &val))
           && GfxShadingBitBuf::getBits(v25, __lcpp_y, (unsigned int *)&ok)
           && GfxShadingBitBuf::getBits(v25, __lcpp_y, &v79) )
      {
        if ( (_DWORD)out )
        {
          v29 = (unsigned int)out;
          v30 = (unsigned int *)&v91;
          while ( GfxShadingBitBuf::getBits(v25, v85[0], v30) )
          {
            ++v30;
            if ( !--v29 )
              goto LABEL_45;
          }
          break;
        }
LABEL_45:
        v31 = v26;
        v32 = LODWORD(Num);
        v74 = v31;
        if ( *(_QWORD *)&v31 == LODWORD(Num) )
        {
          v33 = 2 * LODWORD(Num);
          if ( !LODWORD(Num) )
            v33 = 16;
          v34 = (Stream *)greallocn_checkoverflow(p[0], v33, 144);
          if ( !v34 )
          {
            v12 = 0LL;
            error(ErrorCategory::errSyntaxWarning, -1LL, "GfxGouraudTriangleShading::parse: vertices size overflow");
            gfree(v73[0]);
            GfxShadingBitBuf::~GfxShadingBitBuf(v25);
            operator delete(v25);
            goto LABEL_27;
          }
          v35 = v34;
          memset(&v34[9 * v32], 0, 144LL * (int)(v33 - v32));
          p[0] = v35;
          v36 = v35;
          *(_QWORD *)&Num = v33;
        }
        else
        {
          v36 = strA;
        }
        v37 = v74;
        v38 = 9LL * *(_QWORD *)&v74;
        v39 = _mm_unpacklo_epi32(_mm_cvtsi32_si128((unsigned int)ok), _mm_cvtsi32_si128(v79));
        v40 = _mm_add_pd(
                _mm_mul_pd(
                  _mm_add_pd(
                    _mm_mul_pd(_mm_cvtepi32_pd(_mm_srli_epi32(v39, 0x10u)), (__m128d)xmmword_50A690),
                    _mm_cvtepi32_pd(_mm_and_si128(v39, (__m128i)xmmword_50A680))),
                  v88),
                v87);
        strA = v36;
        v36[9 * *(_QWORD *)&v74] = (Stream)v40;
        if ( (_DWORD)out )
        {
          v41 = &strA[v38 + 1];
          v42 = 0LL;
          do
            *((_DWORD *)&v41->_vptr$Stream + v42++) = dblToCol(v40.m128d_f64[0]);
          while ( (unsigned int)out != v42 );
        }
        *(_QWORD *)&v26 = *(_QWORD *)&v37 + 1LL;
        GfxShadingBitBuf::flushBits(v25);
        v28 = typeA;
        if ( typeA == 4 )
        {
          if ( LODWORD(v80.m128d_f64[0]) <= 1 )
          {
            v27 = LODWORD(v80.m128d_f64[0]) + 1;
            goto LABEL_36;
          }
          v43 = val;
          if ( LODWORD(v80.m128d_f64[0]) == 2 || (v27 = 1, val) )
          {
            if ( v68 == LODWORD(v86.m128d_f64[0]) )
            {
              v44 = 2 * v68;
              if ( !v68 )
                v44 = 16LL;
              *(_QWORD *)&v86.m128d_f64[0] = v44;
              v73[0] = (int (*)[3])greallocn(v73[0], 3 * (int)v44, 4, 0, 1);
            }
            if ( LODWORD(v80.m128d_f64[0]) == 2 )
            {
              v45 = v68;
              v48 = v68;
              v49 = LODWORD(v74);
              v50 = v73[0];
              v73[0][v48][0] = LODWORD(v74) - 2;
              v50[v48][1] = v49 - 1;
              LODWORD(v80.m128d_f64[0]) = 3;
            }
            else
            {
              v45 = v68;
              v46 = v73[0];
              if ( v43 == 1 )
                v47 = v73[0][v68 - 1][1];
              else
                v47 = v73[0][v68 - 1][0];
              v51 = v68;
              v73[0][v51][0] = v47;
              v46[v51][1] = v46[v68 - 1][2];
            }
            v73[0][v45][2] = LODWORD(v74);
            ++v68;
            v27 = LODWORD(v80.m128d_f64[0]);
            goto LABEL_35;
          }
          goto LABEL_36;
        }
      }
      GfxShadingBitBuf::~GfxShadingBitBuf(v25);
      operator delete(v25);
      if ( typeA == 5 )
      {
        v52 = v83;
        v53 = v82;
        if ( LODWORD(v26) )
        {
          v54 = SLODWORD(v26) / (int)v78 - 1;
          v55 = v78 - 1;
          v68 = 2 * (v78 - 1) * v54;
          v56 = (int (*)[3])gmallocn_checkoverflow(6 * ((int)v78 - 1) * v54, 4);
          if ( v56 )
          {
            v73[0] = v56;
            if ( v54 > 0 )
            {
              v57 = &(*v56)[5];
              v58 = 0;
              v59 = 0;
              v60 = v78;
              if ( v55 > 0 )
                goto LABEL_78;
LABEL_75:
              ++v59;
              while ( v59 != v54 )
              {
                if ( v55 <= 0 )
                  goto LABEL_75;
LABEL_78:
                v61 = &v57[3 * v58];
                v62 = v59 * v60;
                v63 = ++v59 * v60;
                v64 = v55;
                do
                {
                  *(v61 - 5) = v62++;
                  *(v61 - 4) = v62;
                  *(v61 - 3) = v63;
                  *(v61 - 2) = v62;
                  *(v61 - 1) = v63++;
                  *v61 = v63;
                  v61 += 6;
                  v58 += 2;
                  --v64;
                }
                while ( v64 );
              }
            }
            goto LABEL_82;
          }
          gfree(p[0]);
LABEL_84:
          v12 = 0LL;
          goto LABEL_27;
        }
      }
      else
      {
        v52 = v83;
        v53 = v82;
      }
LABEL_82:
      v12 = (GfxGouraudTriangleShading *)operator new(0xF0uLL);
      funcsA = std::move<std::vector<std::unique_ptr<Function>> &>((std::vector<std::unique_ptr<Function>> *)v90);
      GfxGouraudTriangleShading::GfxGouraudTriangleShading(
        v12,
        typeA,
        (GfxGouraudVertex *)strA,
        SLODWORD(v26),
        v73[0],
        v68,
        funcsA);
      if ( (*(unsigned __int8 (__fastcall **)(GfxGouraudTriangleShading *, GfxResources *, Dict *, OutputDev *, GfxState *))(*(_QWORD *)v12 + 24LL))(
             v12,
             v53,
             v84,
             v89,
             v52) )
      {
        goto LABEL_27;
      }
      (*(void (__fastcall **)(GfxGouraudTriangleShading *))(*(_QWORD *)v12 + 8LL))(v12);
      goto LABEL_84;
    }
    v12 = 0LL;
    error(ErrorCategory::errSyntaxWarning, -1LL, "Missing or invalid BitsPerComponent in shading dictionary");
  }
  else
  {
    v12 = 0LL;
    error(ErrorCategory::errSyntaxWarning, -1LL, "Missing or invalid BitsPerCoordinate in shading dictionary");
  }
LABEL_27:
  Object::~Object(&funcObj);
  std::vector<std::unique_ptr<Function>>::~vector((std::vector<std::unique_ptr<Function>> *)v90);
  return v12;
}

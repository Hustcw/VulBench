__int64 __fastcall SplashOutputDev::tilingPatternFill(
        SplashOutputDev *this,
        GfxState *state,
        Gfx *gfxA,
        Catalog *catalog,
        GfxTilingPattern *tPat,
        const double *mat,
        double xStep,
        double yStep,
        double a9,
        double a10,
        double a11,
        double a12,
        double a13,
        int x0,
        int y0,
        int x1,
        int y1)
{
  PDFRectangle *BBox;
  double v21;
  double v22;
  const double *CTM;
  const double *v24;
  double v25;
  SplashCoord v26;
  double v27;
  unsigned __int64 *v28;
  double v29;
  double v30;
  __int128 v31;
  double v32;
  double v33;
  double v34;
  int v35;
  int v36;
  double v37;
  int v38;
  int v39;
  __m128d v40;
  double v41;
  __m128d v42;
  int v43;
  double v44;
  int v45;
  int v46;
  const double *v47;
  double v48;
  __int64 v49;
  __int64 v50;
  double v51;
  Gfx *v52;
  GfxState *v53;
  SplashCoord v54;
  double v55;
  double v56;
  double v57;
  double v58;
  int v59;
  int v60;
  int v61;
  double v62;
  const double *v64;
  bool v65;
  SplashBitmap *v66;
  SplashColorMode colorMode;
  SplashOutputDev *v68;
  Splash *v69;
  Gfx *v70;
  GfxState *v71;
  SplashCoord v72;
  Splash *v73;
  unsigned __int8 *paperColor;
  SplashBitmap *v75;
  SplashBitmap *v76;
  Splash_0 *v77;
  SplashThinLineMode ThinLineMode;
  Splash *v79;
  Splash_0 *v80;
  SplashPattern *FillPattern;
  SplashPattern *v82;
  Splash *v83;
  Splash *v84;
  SplashPattern *StrokePattern;
  SplashPattern *v86;
  Gfx *v87;
  Object *ContentStream;
  Splash *v89;
  SplashOutputDev *v90;
  Splash *v91;
  SplashColorMode v92;
  int v93;
  int v94;
  SplashBitmap *v95;
  int v96;
  int v97;
  int v98;
  int v99;
  int v100;
  int Height;
  double v102;
  int heightA;
  double ty;
  int PaintType;
  __int128 v106;
  __int128 v107;
  __int64 v108;
  double a;
  double b;
  double c;
  double d;
  double e;
  double v114[2];
  double v115[2];
  SplashOutputDev *v116;
  Matrix v117;
  double v118[2];
  __int128 v119;
  double v120;
  double v121;
  SplashBitmap *bitmap;
  Splash_0 *splash;
  std::unique_ptr<Gfx> v124;
  double v125;
  SplashOutputDev *srcData[2];
  SplashColorMode v127;
  int v128;
  int v129;
  int v130;
  int v131;
  SplashCoord v132;
  double v133;
  double v134;
  double v135;
  double v136;
  double v137;
  void *v138;
  void *__args;
  void *v140;
  PDFRectangle *v141;
  Dict *ResDict;
  Gfx *v143;
  PDFRectangle v144;

  *(double *)&v106 = yStep;
  *(double *)&v107 = xStep;
  v143 = gfxA;
  PDFRectangle::PDFRectangle(&v144);
  bitmap = this->bitmap;
  splash = (Splash_0 *)this->splash;
  BBox = (PDFRectangle *)GfxTilingPattern::getBBox(tPat);
  *(_QWORD *)&v115[0] = GfxTilingPattern::getMatrix(tPat);
  PaintType = GfxTilingPattern::getPaintType(tPat);
  ResDict = GfxTilingPattern::getResDict(tPat);
  v21 = BBox->x2 - BBox->x1;
  LODWORD(v22) = 0;
  if ( v21 != *(double *)&v107 || BBox->y2 - BBox->y1 != *(double *)&v106 )
    return LODWORD(v22);
  v114[0] = BBox->y2 - BBox->y1;
  v118[0] = v21;
  v116 = this;
  CTM = GfxState::getCTM(state);
  v108 = *(_QWORD *)CTM;
  a = CTM[1];
  b = CTM[2];
  c = CTM[3];
  d = CTM[4];
  e = CTM[5];
  GfxState::concatCTM(state, mat[1], mat[2], mat[3], mat[4], mat[5], a13);
  GfxState::concatCTM(state, 0.0, 0.0, 1.0, BBox->x1, BBox->y1, a13);
  v24 = GfxState::getCTM(state);
  if ( !isfinite<double>(0.0)
    || !isfinite<double>(0.0)
    || !isfinite<double>(0.0)
    || !isfinite<double>(0.0)
    || !isfinite<double>(0.0)
    || !isfinite<double>(0.0) )
  {
    goto LABEL_36;
  }
  v25 = (double)x0 * *(double *)&v107;
  v26 = *v24 * v25;
  v27 = (double)y0 * *(double *)&v106;
  v136 = v24[2] * v27 + v26 + v24[4];
  v137 = v27 * v24[3] + v25 * v24[1] + v24[5];
  v107 = *((unsigned __int64 *)v24 + 1);
  *(_QWORD *)&v106 = splashAbs(v26);
  v119 = *(unsigned __int64 *)v24;
  if ( *(double *)&v106 <= splashAbs(v26) )
  {
    v28 = (unsigned __int64 *)(v24 + 3);
    v29 = *(double *)&v119;
    v102 = *(double *)&v119;
    v30 = *(double *)&v107 * v24[2] / *v24;
  }
  else
  {
    v28 = (unsigned __int64 *)(v24 + 2);
    v29 = -*(double *)&v107;
    v102 = -*(double *)&v107;
    v30 = *v24 * v24[3] / *(double *)&v107;
  }
  v31 = *v28;
  *(double *)&v31 = *(double *)&v31 - v30;
  v106 = v31;
  LODWORD(v107) = x1 - x0;
  v120 = (double)(x1 - x0);
  *(_QWORD *)&v119 = ceil(fabs(v29 * v118[0] * v120));
  LODWORD(v106) = y1 - y0;
  v125 = (double)(y1 - y0);
  v121 = ceil(fabs(*(double *)&v31 * v114[0] * v125));
  v102 = GfxState::getHDPI(state) / 72.0;
  v32 = GfxState::getVDPI(state) / 72.0;
  ty = v32;
  v33 = **(double **)&v115[0];
  if ( **(double **)&v115[0] == 0.0 )
    v33 = *(double *)(*(_QWORD *)&v115[0] + 16LL);
  heightA = (int)*(double *)&v119;
  LODWORD(v119) = (int)v121;
  v117.m[0] = fabs(v33) * v102;
  *(_OWORD *)&v117.m[1] = 0LL;
  v34 = *(double *)(*(_QWORD *)&v115[0] + 24LL);
  if ( v34 == 0.0 )
    v34 = *(double *)(*(_QWORD *)&v115[0] + 8LL);
  v117.m[3] = v32 * fabs(v34);
  *(_OWORD *)&v117.m[4] = 0LL;
  Matrix::transform(&v117, v118[0], v114[0], &v102, &ty);
  v35 = (int)ceil(fabs(v102));
  v36 = (int)ceil(fabs(ty));
  v117.m[0] = (double)heightA / (double)(v35 * (int)v107) * v117.m[0];
  v117.m[3] = (double)(int)v119 / (double)(v36 * (int)v106) * v117.m[3];
  Matrix::transform(&v117, v118[0], v114[0], &v102, &ty);
  v37 = v102;
  if ( fabs(v102) >= 1.0 || fabs(ty) >= 1.0 )
  {
    if ( (unsigned __int64)(v35 * (__int64)v36) > 0x800000 )
      goto LABEL_36;
    v40 = (__m128d)xmmword_5C8240;
    while ( 1 )
    {
      *(_QWORD *)&v41 = *(_QWORD *)&v37 & *(_QWORD *)&v40.m128d_f64[0];
      if ( v41 <= 16384.0 )
      {
        v42 = _mm_and_pd((__m128d)*(unsigned __int64 *)&ty, v40);
        if ( v42.m128d_f64[0] <= 16384.0 )
          break;
      }
      v117.m[0] = v117.m[0] * 0.5;
      v117.m[3] = v117.m[3] * 0.5;
      Matrix::transform(&v117, v118[0], v114[0], &v102, &ty);
      v40 = (__m128d)xmmword_5C8240;
      v37 = v102;
    }
    *(__m128d *)v115 = v42;
    v43 = (int)ceil(v41);
    v44 = ceil(v115[0]);
    LODWORD(v115[0]) = v43;
    if ( !v43 || !(int)v44 )
      goto LABEL_36;
    v46 = heightA / SLODWORD(v115[0]) + (LODWORD(v115[0]) * (heightA / SLODWORD(v115[0])) < heightA);
    heightA = (int)v44;
    v45 = (int)v44;
    v38 = v107;
    if ( (int)v107 < v46 )
      v38 = v46;
    v39 = v106;
    if ( (int)v106 < (int)v119 / v45 + (v45 * ((int)v119 / v45) < (int)v119) )
      v39 = (int)v119 / v45 + (v45 * ((int)v119 / v45) < (int)v119);
    v120 = (double)v38;
    v125 = (double)v39;
  }
  else
  {
    v102 = *std::min<double>(&v102, &ty);
    ty = 2.0 / v102;
    v117.m[0] = v117.m[0] * (2.0 / v102);
    v117.m[3] = 2.0 / v102 * v117.m[3];
    Matrix::transform(&v117, v118[0], v114[0], &v102, &ty);
    LODWORD(v115[0]) = (int)ceil(fabs(v102));
    heightA = (int)ceil(fabs(ty));
    v38 = v107;
    v39 = v106;
  }
  GfxState::setCTM(state, a, b, c, d, e, a13);
  GfxState::concatCTM(state, mat[1], mat[2], mat[3], mat[4], mat[5], a13);
  GfxState::concatCTM(state, 0.0, 0.0, v114[0] * v125, BBox->x1, BBox->y1, a13);
  v47 = GfxState::getCTM(state);
  v48 = *v47;
  v132 = *v47;
  v49 = *((__int64 *)v47 + 1);
  v133 = *(double *)&v49;
  v50 = *((__int64 *)v47 + 2);
  v134 = *(double *)&v50;
  v51 = v47[3];
  v135 = v51;
  if ( v38 * v39 < 5 || !heightA || !LODWORD(v115[0]) )
  {
LABEL_36:
    GfxState::setCTM(state, a, b, c, d, e, a13);
    LODWORD(v22) = 0;
    return LODWORD(v22);
  }
  LODWORD(v106) = v39;
  LODWORD(v107) = v38;
  *(_OWORD *)v118 = (unsigned __int64)v49;
  *(_OWORD *)v114 = *(unsigned __int64 *)&v48;
  v121 = v51;
  v119 = (unsigned __int64)v50;
  Matrix::transform(&v117, BBox->x1, BBox->y1, &v102, &ty);
  *(__m128 *)&v117.m[4] = _mm_xor_ps(_mm_loadh_ps(&ty), (__m128)xmmword_5C8230);
  v144 = *BBox;
  srcData[0] = v116;
  v141 = &v144;
  v140 = 0LL;
  __args = 0LL;
  v138 = 0LL;
  std::make_unique<Gfx,PDFDoc *&,SplashOutputDev *,Dict *&,PDFRectangle *,decltype(nullptr),decltype(nullptr),decltype(nullptr),Gfx*&>(
    &v116->doc,
    srcData,
    &ResDict,
    &v141,
    &v140,
    &__args,
    &v138,
    &v143);
  v52 = std::unique_ptr<Gfx>::operator->(&v124);
  v53 = Gfx::getState(v52);
  v54 = v117.m[1];
  GfxState::setCTM(v53, v117.m[1], v117.m[2], v117.m[3], v117.m[4], v117.m[5], a13);
  v120 = splashAbs(v54);
  v55 = splashAbs(v54);
  if ( v120 <= v55 )
  {
    v102 = v48;
    v57 = v118[0] * *(double *)&v119;
    v58 = v114[0];
    v56 = v114[0];
    v62 = v121;
    v59 = v107;
    v60 = v106;
    v61 = heightA;
  }
  else
  {
    v56 = v118[0];
    v102 = -v118[0];
    v57 = v114[0] * v121;
    v58 = -v118[0];
    v59 = v107;
    v60 = v106;
    v61 = heightA;
    v62 = *(double *)&v119;
  }
  *(_QWORD *)&v22 = (unsigned int)(v60 * v61);
  *(_QWORD *)&v114[0] = (unsigned int)(v59 * LODWORD(v115[0]));
  v102 = (double)SLODWORD(v114[0]) / (fabs(v58) + 1.0);
  ty = (double)SLODWORD(v22) / (fabs(v62 - v57 / v56) + 1.0);
  GfxState::concatCTM(state, 0.0, 0.0, ty, 0.0, 0.0, a13);
  v64 = GfxState::getCTM(state);
  v132 = *v64;
  v133 = v64[1];
  v134 = v64[2];
  v135 = v64[3];
  v65 = v132 > 0.0 && v133 == 0.0 && v134 == 0.0 && v135 > 0.0;
  v66 = (SplashBitmap *)operator new(0x30uLL);
  if ( PaintType == 1 || (colorMode = SplashColorMode::splashModeMono8, v65) )
    colorMode = v116->colorMode;
  SplashBitmap::SplashBitmap(v66, SLODWORD(v115[0]), heightA, 1, colorMode, 1, 1, 0LL);
  v68 = v116;
  v116->bitmap = v66;
  if ( SplashBitmap::getDataPtr(v66) )
  {
    v69 = (Splash *)operator new(0xD0uLL);
    Splash::Splash(v69, v68->bitmap, 1, 0LL);
    v68->splash = v69;
    v70 = std::unique_ptr<Gfx>::operator->(&v124);
    v71 = Gfx::getState(v70);
    v72 = v117.m[1];
    (*((void (__fastcall **)(SplashOutputDev *, GfxState *, double, double, double, double, double, double))v68->_vptr$OutputDev
     + 23))(
      v68,
      v71,
      v117.m[0],
      v117.m[1],
      v117.m[2],
      v117.m[3],
      v117.m[4],
      v117.m[5]);
    if ( PaintType == 2 )
    {
      LOBYTE(srcData[0]) = -((unsigned int)(v68->colorMode - 5) > 1);
      v73 = v68->splash;
      paperColor = (unsigned __int8 *)srcData;
    }
    else
    {
      v73 = v68->splash;
      paperColor = v68->paperColor;
    }
    Splash::clear(v73, paperColor, 0);
    v76 = bitmap;
    v77 = (Splash_0 *)v68->splash;
    ThinLineMode = Splash::getThinLineMode(splash);
    Splash::setThinLineMode(v77, ThinLineMode);
    Splash::setMinLineWidth((Splash_0 *)v68->splash, v72);
    if ( v65 )
    {
      v79 = v68->splash;
      v115[0] = v22;
      v22 = *(double *)&v76;
      v80 = splash;
      FillPattern = Splash::getFillPattern((Splash *)splash);
      v82 = (SplashPattern *)(*(__int64 (__fastcall **)(SplashPattern *, double))FillPattern->_vptr$SplashPattern)(
                               FillPattern,
                               0.0);
      Splash::setFillPattern(v79, v82);
      v83 = v68->splash;
      v84 = (Splash *)v80;
      v76 = *(SplashBitmap **)&v22;
      LODWORD(v22) = LODWORD(v115[0]);
      StrokePattern = Splash::getStrokePattern(v84);
      v86 = (SplashPattern *)(*(__int64 (__fastcall **)(SplashPattern *))StrokePattern->_vptr$SplashPattern)(StrokePattern);
      Splash::setStrokePattern(v83, v86);
    }
    v87 = std::unique_ptr<Gfx>::operator->(&v124);
    ContentStream = GfxTilingPattern::getContentStream(tPat);
    Gfx::display(v87, ContentStream, 1);
    v89 = v68->splash;
    if ( v89 )
    {
      Splash::~Splash(v68->splash);
      operator delete(v89);
    }
    v90 = v116;
    v91 = (Splash *)splash;
    v116->splash = (Splash *)splash;
    srcData[0] = (SplashOutputDev *)v90->bitmap;
    v128 = PaintType;
    srcData[1] = (SplashOutputDev *)Splash::getFillPattern(v91);
    v92 = v90->colorMode;
    v127 = v92;
    v131 = 0;
    v93 = v107;
    v129 = v107;
    v94 = v106;
    v130 = v106;
    v95 = v90->bitmap;
    v90->bitmap = v76;
    if ( v65 )
    {
      LOBYTE(v22) = 1;
      if ( v94 > 0 )
      {
        v96 = 0;
        if ( v93 > 0 )
          goto LABEL_58;
        while ( ++v96 < v94 )
        {
          if ( v93 > 0 )
          {
LABEL_58:
            v97 = 0;
            do
            {
              v98 = splashFloor(v72);
              v99 = v97 * SplashBitmap::getWidth(v95) + v98;
              v100 = splashFloor(v72);
              Height = SplashBitmap::getHeight(v95);
              Splash::blitImage(v116->splash, v95, 1, v99, v96 * Height + v100);
              ++v97;
              v93 = v129;
            }
            while ( v97 < v129 );
            v94 = v130;
          }
        }
      }
    }
    else
    {
      LOBYTE(v22) = Splash::drawImage(
                      v90->splash,
                      SplashOutputDev::tilingBitmapSrc,
                      0LL,
                      srcData,
                      v92,
                      1,
                      SLODWORD(v114[0]),
                      SLODWORD(v22),
                      &v132,
                      0,
                      1) == 0;
    }
    if ( v95 )
    {
      SplashBitmap::~SplashBitmap(v95);
      operator delete(v95);
    }
  }
  else
  {
    v75 = v68->bitmap;
    v68->bitmap = bitmap;
    if ( v75 )
    {
      SplashBitmap::~SplashBitmap(v75);
      operator delete(v75);
    }
    GfxState::setCTM(state, a, b, c, d, e, a13);
    LODWORD(v22) = 0;
  }
  std::unique_ptr<Gfx>::~unique_ptr(&v124);
  return LODWORD(v22);
}

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
  unsigned int v22;
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
  const double *v46;
  double v47;
  __int64 v48;
  __int64 v49;
  double v50;
  Gfx *v51;
  GfxState *v52;
  SplashCoord v53;
  double v54;
  double v55;
  double v56;
  double v57;
  int v58;
  int v59;
  double v60;
  const double *v62;
  bool v63;
  SplashBitmap *v64;
  SplashColorMode colorMode;
  SplashOutputDev *v66;
  Splash *v67;
  Gfx *v68;
  GfxState *v69;
  SplashCoord v70;
  Splash *v71;
  unsigned __int8 *paperColor;
  SplashBitmap *v73;
  Splash *v74;
  Splash_0 *v75;
  SplashThinLineMode ThinLineMode;
  Splash *v77;
  SplashPattern *FillPattern;
  SplashPattern *v79;
  Splash *v80;
  SplashPattern *StrokePattern;
  SplashPattern *v82;
  Gfx *v83;
  Object *ContentStream;
  Splash *v85;
  SplashOutputDev *v86;
  SplashColorMode v87;
  int v88;
  int v89;
  SplashBitmap *v90;
  int v91;
  int v92;
  int v93;
  int v94;
  int v95;
  int Height;
  double tx;
  double ty;
  int PaintType;
  __int128 v100;
  __int128 v101;
  int widthA[2];
  double v103[2];
  double v104;
  SplashOutputDev *v105;
  __int64 v106;
  double a;
  double b;
  double c;
  double d;
  double e;
  Matrix v112;
  double v113[2];
  __int128 v114;
  double v115;
  double v116[2];
  std::unique_ptr<Gfx> v117;
  double v118;
  Splash_0 *splash;
  SplashBitmap *bitmap;
  SplashOutputDev *srcData[2];
  SplashColorMode v122;
  int v123;
  int v124;
  int v125;
  int v126;
  SplashCoord v127;
  double v128;
  double v129;
  double v130;
  double v131;
  double v132;
  void *v133;
  void *__args;
  void *v135;
  PDFRectangle *v136;
  Dict *ResDict;
  Gfx *v138;
  PDFRectangle v139;

  *(double *)&v100 = yStep;
  *(double *)&v101 = xStep;
  v138 = gfxA;
  PDFRectangle::PDFRectangle(&v139);
  bitmap = this->bitmap;
  splash = (Splash_0 *)this->splash;
  BBox = (PDFRectangle *)GfxTilingPattern::getBBox(tPat);
  *(_QWORD *)&v116[0] = GfxTilingPattern::getMatrix(tPat);
  PaintType = GfxTilingPattern::getPaintType(tPat);
  ResDict = GfxTilingPattern::getResDict(tPat);
  v21 = BBox->x2 - BBox->x1;
  v22 = 0;
  if ( v21 != *(double *)&v101 || BBox->y2 - BBox->y1 != *(double *)&v100 )
    return v22;
  v103[0] = BBox->y2 - BBox->y1;
  v113[0] = v21;
  v105 = this;
  CTM = GfxState::getCTM(state);
  v106 = *(_QWORD *)CTM;
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
    goto LABEL_34;
  }
  v25 = (double)x0 * *(double *)&v101;
  v26 = *v24 * v25;
  v27 = (double)y0 * *(double *)&v100;
  v131 = v24[2] * v27 + v26 + v24[4];
  v132 = v27 * v24[3] + v25 * v24[1] + v24[5];
  v101 = *((unsigned __int64 *)v24 + 1);
  *(_QWORD *)&v100 = splashAbs(v26);
  v114 = *(unsigned __int64 *)v24;
  if ( *(double *)&v100 <= splashAbs(v26) )
  {
    v28 = (unsigned __int64 *)(v24 + 3);
    v29 = *(double *)&v114;
    tx = *(double *)&v114;
    v30 = *(double *)&v101 * v24[2] / *v24;
  }
  else
  {
    v28 = (unsigned __int64 *)(v24 + 2);
    v29 = -*(double *)&v101;
    tx = -*(double *)&v101;
    v30 = *v24 * v24[3] / *(double *)&v101;
  }
  v31 = *v28;
  *(double *)&v31 = *(double *)&v31 - v30;
  v100 = v31;
  LODWORD(v101) = x1 - x0;
  v115 = (double)(x1 - x0);
  *(_QWORD *)&v114 = ceil(fabs(v29 * v113[0] * v115));
  LODWORD(v100) = y1 - y0;
  v118 = (double)(y1 - y0);
  *(double *)widthA = ceil(fabs(*(double *)&v31 * v103[0] * v118));
  tx = GfxState::getHDPI(state) / 72.0;
  v32 = GfxState::getVDPI(state) / 72.0;
  ty = v32;
  v33 = **(double **)&v116[0];
  if ( **(double **)&v116[0] == 0.0 )
    v33 = *(double *)(*(_QWORD *)&v116[0] + 16LL);
  LODWORD(v104) = (int)*(double *)&v114;
  LODWORD(v114) = (int)*(double *)widthA;
  v112.m[0] = fabs(v33) * tx;
  *(_OWORD *)&v112.m[1] = 0LL;
  v34 = *(double *)(*(_QWORD *)&v116[0] + 24LL);
  if ( v34 == 0.0 )
    v34 = *(double *)(*(_QWORD *)&v116[0] + 8LL);
  v112.m[3] = v32 * fabs(v34);
  *(_OWORD *)&v112.m[4] = 0LL;
  Matrix::transform(&v112, v113[0], v103[0], &tx, &ty);
  v35 = (int)ceil(fabs(tx));
  v36 = (int)ceil(fabs(ty));
  v112.m[0] = (double)SLODWORD(v104) / (double)(v35 * (int)v101) * v112.m[0];
  v112.m[3] = (double)(int)v114 / (double)(v36 * (int)v100) * v112.m[3];
  Matrix::transform(&v112, v113[0], v103[0], &tx, &ty);
  v37 = tx;
  if ( fabs(tx) < 1.0 && fabs(ty) < 1.0 )
  {
    tx = *std::min<double>(&tx, &ty);
    ty = 2.0 / tx;
    v112.m[0] = v112.m[0] * (2.0 / tx);
    v112.m[3] = 2.0 / tx * v112.m[3];
    Matrix::transform(&v112, v113[0], v103[0], &tx, &ty);
    widthA[0] = (int)ceil(fabs(tx));
    LODWORD(v116[0]) = (int)ceil(fabs(ty));
    v38 = v101;
    v39 = v100;
    goto LABEL_29;
  }
  if ( (unsigned __int64)(v35 * (__int64)v36) > 0x800000 )
  {
LABEL_34:
    GfxState::setCTM(state, a, b, c, d, e, a13);
    return 0;
  }
  v40 = (__m128d)xmmword_5CBCE0;
  while ( 1 )
  {
    *(_QWORD *)&v41 = *(_QWORD *)&v37 & *(_QWORD *)&v40.m128d_f64[0];
    if ( v41 <= 16384.0 )
    {
      v42 = _mm_and_pd((__m128d)*(unsigned __int64 *)&ty, v40);
      if ( v42.m128d_f64[0] <= 16384.0 )
        break;
    }
    v112.m[0] = v112.m[0] * 0.5;
    v112.m[3] = v112.m[3] * 0.5;
    Matrix::transform(&v112, v113[0], v103[0], &tx, &ty);
    v40 = (__m128d)xmmword_5CBCE0;
    v37 = tx;
  }
  *(__m128d *)v116 = v42;
  v43 = (int)ceil(v41);
  v44 = ceil(v116[0]);
  widthA[0] = v43;
  v45 = SLODWORD(v104) / v43 + (v43 * (SLODWORD(v104) / v43) < SLODWORD(v104));
  LODWORD(v116[0]) = (int)v44;
  v38 = v101;
  if ( (int)v101 < v45 )
    v38 = v45;
  v39 = v100;
  if ( (int)v100 < (int)v114 / (int)v44 + ((int)v44 * ((int)v114 / (int)v44) < (int)v114) )
    v39 = (int)v114 / (int)v44 + ((int)v44 * ((int)v114 / (int)v44) < (int)v114);
  v115 = (double)v38;
  v118 = (double)v39;
LABEL_29:
  GfxState::setCTM(state, a, b, c, d, e, a13);
  GfxState::concatCTM(state, mat[1], mat[2], mat[3], mat[4], mat[5], a13);
  GfxState::concatCTM(state, 0.0, 0.0, v103[0] * v118, BBox->x1, BBox->y1, a13);
  v46 = GfxState::getCTM(state);
  v47 = *v46;
  v127 = *v46;
  v48 = *((__int64 *)v46 + 1);
  v128 = *(double *)&v48;
  v49 = *((__int64 *)v46 + 2);
  v129 = *(double *)&v49;
  v50 = v46[3];
  v130 = v50;
  if ( v38 * v39 < 5 || !LODWORD(v116[0]) || !widthA[0] )
    goto LABEL_34;
  LODWORD(v100) = v39;
  LODWORD(v101) = v38;
  *(_OWORD *)v113 = (unsigned __int64)v48;
  *(_OWORD *)v103 = *(unsigned __int64 *)&v47;
  v104 = v50;
  v114 = (unsigned __int64)v49;
  Matrix::transform(&v112, BBox->x1, BBox->y1, &tx, &ty);
  *(__m128 *)&v112.m[4] = _mm_xor_ps(_mm_loadh_ps(&ty), (__m128)xmmword_5CBE00);
  v139 = *BBox;
  srcData[0] = v105;
  v136 = &v139;
  v135 = 0LL;
  __args = 0LL;
  v133 = 0LL;
  std::make_unique<Gfx,PDFDoc *&,SplashOutputDev *,Dict *&,PDFRectangle *,decltype(nullptr),decltype(nullptr),decltype(nullptr),Gfx*&>(
    &v105->doc,
    srcData,
    &ResDict,
    &v136,
    &v135,
    &__args,
    &v133,
    &v138);
  v51 = std::unique_ptr<Gfx>::operator->(&v117);
  v52 = Gfx::getState(v51);
  v53 = v112.m[1];
  GfxState::setCTM(v52, v112.m[1], v112.m[2], v112.m[3], v112.m[4], v112.m[5], a13);
  v115 = splashAbs(v53);
  v54 = splashAbs(v53);
  if ( v115 <= v54 )
  {
    tx = v47;
    v56 = v113[0] * *(double *)&v114;
    v57 = v103[0];
    v55 = v103[0];
    v60 = v104;
    v58 = v101;
    v59 = v100;
  }
  else
  {
    v55 = v113[0];
    tx = -v113[0];
    v56 = v103[0] * v104;
    v57 = -v113[0];
    v58 = v101;
    v59 = v100;
    v60 = *(double *)&v114;
  }
  v22 = v59 * LODWORD(v116[0]);
  *(_QWORD *)&v103[0] = (unsigned int)(v58 * widthA[0]);
  tx = (double)SLODWORD(v103[0]) / (fabs(v57) + 1.0);
  ty = (double)(v59 * LODWORD(v116[0])) / (fabs(v60 - v56 / v55) + 1.0);
  GfxState::concatCTM(state, 0.0, 0.0, ty, 0.0, 0.0, a13);
  v62 = GfxState::getCTM(state);
  v127 = *v62;
  v128 = v62[1];
  v129 = v62[2];
  v130 = v62[3];
  v63 = v127 > 0.0 && v128 == 0.0 && v129 == 0.0 && v130 > 0.0;
  v64 = (SplashBitmap *)operator new(0x30uLL);
  if ( PaintType == 1 || (colorMode = SplashColorMode::splashModeMono8, v63) )
    colorMode = v105->colorMode;
  SplashBitmap::SplashBitmap(v64, widthA[0], SLODWORD(v116[0]), 1, colorMode, 1, 1, 0LL);
  v66 = v105;
  v105->bitmap = v64;
  if ( SplashBitmap::getDataPtr(v64) )
  {
    v67 = (Splash *)operator new(0xD0uLL);
    Splash::Splash(v67, v66->bitmap, 1, 0LL);
    v66->splash = v67;
    v68 = std::unique_ptr<Gfx>::operator->(&v117);
    v69 = Gfx::getState(v68);
    v70 = v112.m[1];
    (*((void (__fastcall **)(SplashOutputDev *, GfxState *, double, double, double, double, double, double))v66->_vptr$OutputDev
     + 23))(
      v66,
      v69,
      v112.m[0],
      v112.m[1],
      v112.m[2],
      v112.m[3],
      v112.m[4],
      v112.m[5]);
    if ( PaintType == 2 )
    {
      LOBYTE(srcData[0]) = -((unsigned int)(v66->colorMode - 5) > 1);
      v71 = v66->splash;
      paperColor = (unsigned __int8 *)srcData;
    }
    else
    {
      v71 = v66->splash;
      paperColor = v66->paperColor;
    }
    Splash::clear(v71, paperColor, 0);
    v74 = (Splash *)splash;
    v75 = (Splash_0 *)v66->splash;
    ThinLineMode = Splash::getThinLineMode(splash);
    Splash::setThinLineMode(v75, ThinLineMode);
    Splash::setMinLineWidth((Splash_0 *)v66->splash, v70);
    if ( v63 )
    {
      v77 = v66->splash;
      FillPattern = Splash::getFillPattern(v74);
      v79 = (SplashPattern *)(*(__int64 (__fastcall **)(SplashPattern *, double))FillPattern->_vptr$SplashPattern)(
                               FillPattern,
                               0.0);
      Splash::setFillPattern(v77, v79);
      v80 = v66->splash;
      StrokePattern = Splash::getStrokePattern(v74);
      v82 = (SplashPattern *)(*(__int64 (__fastcall **)(SplashPattern *))StrokePattern->_vptr$SplashPattern)(StrokePattern);
      Splash::setStrokePattern(v80, v82);
    }
    v83 = std::unique_ptr<Gfx>::operator->(&v117);
    ContentStream = GfxTilingPattern::getContentStream(tPat);
    Gfx::display(v83, ContentStream, 1);
    v85 = v66->splash;
    if ( v85 )
    {
      Splash::~Splash(v66->splash);
      operator delete(v85);
    }
    v86 = v105;
    v105->splash = v74;
    srcData[0] = (SplashOutputDev *)v86->bitmap;
    v123 = PaintType;
    srcData[1] = (SplashOutputDev *)Splash::getFillPattern(v74);
    v87 = v86->colorMode;
    v122 = v87;
    v126 = 0;
    v88 = v101;
    v124 = v101;
    v89 = v100;
    v125 = v100;
    v90 = v86->bitmap;
    v86->bitmap = bitmap;
    if ( v63 )
    {
      LOBYTE(v22) = 1;
      if ( v89 > 0 )
      {
        v91 = 0;
        if ( v88 > 0 )
          goto LABEL_56;
        while ( ++v91 < v89 )
        {
          if ( v88 > 0 )
          {
LABEL_56:
            v92 = 0;
            do
            {
              v93 = splashFloor(v70);
              v94 = v92 * SplashBitmap::getWidth(v90) + v93;
              v95 = splashFloor(v70);
              Height = SplashBitmap::getHeight(v90);
              Splash::blitImage(v105->splash, v90, 1, v94, v91 * Height + v95);
              ++v92;
              v88 = v124;
            }
            while ( v92 < v124 );
            v89 = v125;
          }
        }
      }
    }
    else
    {
      LOBYTE(v22) = Splash::drawImage(
                      v86->splash,
                      SplashOutputDev::tilingBitmapSrc,
                      0LL,
                      srcData,
                      v87,
                      1,
                      SLODWORD(v103[0]),
                      v22,
                      &v127,
                      0,
                      1) == 0;
    }
    if ( v90 )
    {
      SplashBitmap::~SplashBitmap(v90);
      operator delete(v90);
    }
  }
  else
  {
    v73 = v66->bitmap;
    v66->bitmap = bitmap;
    if ( v73 )
    {
      SplashBitmap::~SplashBitmap(v73);
      operator delete(v73);
    }
    GfxState::setCTM(state, a, b, c, d, e, a13);
    v22 = 0;
  }
  std::unique_ptr<Gfx>::~unique_ptr(&v117);
  return v22;
}

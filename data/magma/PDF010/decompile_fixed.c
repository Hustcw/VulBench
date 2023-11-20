void __fastcall SplashOutputDev::type3D1(
        SplashOutputDev *this,
        GfxState *state,
        double wx,
        double wy,
        double llx,
        double lly,
        double urx,
        double ury,
        double a9)
{
  T3GlyphStack *t3GlyphStack;
  T3FontCache *cache;
  double v13;
  double v14;
  double v15;
  double v16;
  double v17;
  double v18;
  double v19;
  double v20;
  double v21;
  int glyphX;
  double v23;
  int glyphY;
  T3FontCacheTag *cacheTags;
  T3GlyphStack *v26;
  __int64 cacheAssoc;
  unsigned __int16 code;
  int v29;
  __int64 v30;
  T3FontCacheTag *v31;
  const double *CTM;
  T3GlyphStack *v33;
  SplashColorMode colorMode;
  SplashBitmap *v35;
  int glyphW;
  int glyphH;
  Splash *v38;
  bool vectorAntialias;
  SplashScreen *Screen;
  Splash *v41;
  SplashBitmap *v42;
  bool v43;
  Splash *splash;
  SplashSolidColor *v45;
  Splash *v46;
  SplashSolidColor *v47;
  double v48;
  double v49;
  double v51;
  double v52;
  double v53;
  double *v54;
  double v56;
  double v57;
  char colorA[8];
  double y2;
  double x2[7];

  t3GlyphStack = this->t3GlyphStack;
  if ( !t3GlyphStack )
    return;
  if ( t3GlyphStack->haveDx )
    return;
  t3GlyphStack->haveDx = 1;
  if ( t3GlyphStack->doNotCache )
    return;
  if ( t3GlyphStack->origBitmap )
  {
    error(
      ErrorCategory::errSyntaxWarning,
      -1LL,
      "t3GlyphStack origBitmap was not null in SplashOutputDev::type3D1",
      wx,
      wy,
      llx,
      lly,
      urx,
      ury,
      a9);
    return;
  }
  if ( t3GlyphStack->origSplash )
  {
    error(
      ErrorCategory::errSyntaxWarning,
      -1LL,
      "t3GlyphStack origSplash was not null in SplashOutputDev::type3D1",
      wx,
      wy,
      llx,
      lly,
      urx,
      ury,
      a9,
      *(_QWORD *)&lly);
    return;
  }
  cache = t3GlyphStack->cache;
  GfxState::transform(state, 0.0, 0.0, x2, &y2);
  GfxState::transform(state, llx, lly, &v57, &v56);
  v53 = v57;
  v52 = v56;
  GfxState::transform(state, llx, ury, &v57, &v56);
  v13 = v53;
  if ( v53 <= v57 )
  {
    if ( v57 <= v53 )
      v49 = v53;
    else
      v49 = v57;
  }
  else
  {
    v49 = v53;
    v13 = v57;
  }
  v14 = v52;
  if ( v52 <= v56 )
  {
    if ( v56 <= v52 )
    {
      v48 = v52;
    }
    else
    {
      v52 = v56;
      v48 = v14;
    }
  }
  else
  {
    v48 = v56;
  }
  GfxState::transform(state, urx, lly, &v57, &v56);
  if ( v13 <= v57 )
  {
    v15 = ury;
    if ( v57 > v49 )
      v49 = v57;
  }
  else
  {
    v13 = v57;
    v15 = ury;
  }
  if ( v48 <= v56 )
  {
    if ( v56 <= v52 )
      v51 = v52;
    else
      v51 = v56;
  }
  else
  {
    v48 = v56;
    v51 = v52;
  }
  GfxState::transform(state, urx, v15, &v57, &v56);
  v17 = v13;
  if ( v13 <= v57 )
  {
    if ( v57 > v49 )
      v49 = v57;
  }
  else
  {
    v17 = v57;
  }
  v18 = v48;
  v19 = v56;
  if ( v48 > v56 )
  {
    v18 = v56;
LABEL_32:
    v19 = v51;
    goto LABEL_33;
  }
  if ( v56 <= v51 )
    goto LABEL_32;
LABEL_33:
  v20 = x2[0];
  v21 = v17 - x2[0];
  glyphX = cache->glyphX;
  v23 = (double)glyphX;
  if ( (double)glyphX > v21 )
    goto LABEL_55;
  v23 = y2;
  v18 = v18 - y2;
  glyphY = cache->glyphY;
  v21 = (double)glyphY;
  if ( (double)glyphY > v18 )
    goto LABEL_55;
  v21 = v49 - x2[0];
  v20 = (double)(cache->glyphW + glyphX);
  if ( v49 - x2[0] <= v20 && (v19 = v19 - y2, v20 = (double)(cache->glyphH + glyphY), v19 <= v20) )
  {
    cacheTags = cache->cacheTags;
    if ( cacheTags )
    {
      v26 = this->t3GlyphStack;
      cacheAssoc = (unsigned int)cache->cacheAssoc;
      if ( (int)cacheAssoc > 0 )
      {
        code = v26->code;
        v29 = cacheAssoc - 1;
        v30 = (int)(cacheAssoc * (v26->code & (cache->cacheSets - 1)));
        v31 = &cacheTags[v30];
        do
        {
          if ( v29 == (v31->mru & 0x7FFF) )
          {
            v31->mru = 0x8000;
            v31->code = code;
            v26->cacheTag = v31;
            v26->cacheData = &cache->cacheData[v30 * cache->glyphSize];
          }
          else
          {
            ++v31->mru;
          }
          ++v30;
          ++v31;
          --cacheAssoc;
        }
        while ( cacheAssoc );
      }
      *(_OWORD *)&v26->origBitmap = *(_OWORD *)&this->bitmap;
      CTM = GfxState::getCTM(state);
      v33 = this->t3GlyphStack;
      v33->origCTM4 = CTM[4];
      v33->origCTM5 = CTM[5];
      colorMode = this->colorMode;
      v35 = (SplashBitmap *)operator new(0x30uLL);
      glyphW = cache->glyphW;
      glyphH = cache->glyphH;
      v54 = (double *)CTM;
      if ( colorMode )
      {
        SplashBitmap::SplashBitmap(v35, glyphW, glyphH, 1, SplashColorMode::splashModeMono8, 0, 1, 0LL);
        this->bitmap = v35;
        v38 = (Splash *)operator new(0xD0uLL);
        vectorAntialias = this->vectorAntialias;
        Screen = Splash::getScreen(this->t3GlyphStack->origSplash);
        v41 = v38;
        v42 = v35;
        v43 = vectorAntialias;
      }
      else
      {
        SplashBitmap::SplashBitmap(v35, glyphW, glyphH, 1, SplashColorMode::splashModeMono1, 0, 1, 0LL);
        this->bitmap = v35;
        v38 = (Splash *)operator new(0xD0uLL);
        Screen = Splash::getScreen(this->t3GlyphStack->origSplash);
        v41 = v38;
        v42 = v35;
        v43 = 0;
      }
      Splash::Splash(v41, v42, v43, Screen);
      this->splash = v38;
      colorA[0] = 0;
      Splash::clear(v38, (SplashColorPtr)colorA, 0);
      colorA[0] = -1;
      Splash::setMinLineWidth((Splash_0 *)this->splash, v20);
      Splash::setThinLineMode((Splash_0 *)this->splash, SplashThinLineMode::splashThinLineDefault);
      splash = this->splash;
      v45 = (SplashSolidColor *)operator new(0x10uLL);
      SplashSolidColor::SplashSolidColor(v45, (SplashColorPtr)colorA);
      Splash::setFillPattern(splash, v45);
      v46 = this->splash;
      v47 = (SplashSolidColor *)operator new(0x10uLL);
      SplashSolidColor::SplashSolidColor(v47, (SplashColorPtr)colorA);
      Splash::setStrokePattern(v46, v47);
      GfxState::setCTM(state, v54[1], v54[2], v54[3], (double)-cache->glyphX, (double)-cache->glyphY, a9);
      (*((void (__fastcall **)(SplashOutputDev *, GfxState *, double, double, double, double, double, double))this->_vptr$OutputDev
       + 23))(
        this,
        state,
        0.0,
        0.0,
        0.0,
        0.0,
        0.0,
        0.0);
    }
  }
  else
  {
LABEL_55:
    if ( cache->validBBox )
      error(
        ErrorCategory::errSyntaxWarning,
        -1LL,
        "Bad bounding box in Type 3 glyph",
        v19,
        v20,
        v23,
        v21,
        v18,
        v16,
        a9,
        *(_QWORD *)&v48);
  }
}

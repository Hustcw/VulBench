void SplashOutputDev::type3D1(GfxState *state, double wx, double wy, double llx,
                              double lly, double urx, double ury) {
  T3FontCache *t3Font;
  SplashColor color;
  double xt, yt, xMin, xMax, yMin, yMax, x1, y1;
  int i, j;

  // ignore multiple d0/d1 operators
  if (!t3GlyphStack || t3GlyphStack->haveDx) {
    return;
  }
  t3GlyphStack->haveDx = true;
  // don't cache if we got a gsave/grestore before the d1
  if (t3GlyphStack->doNotCache) {
    return;
  }

  if (unlikely(t3GlyphStack == nullptr)) {
    error(errSyntaxWarning, -1,
          "t3GlyphStack was null in SplashOutputDev::type3D1");
    return;
  }

  if (unlikely(t3GlyphStack->origBitmap != nullptr)) {
    error(errSyntaxWarning, -1,
          "t3GlyphStack origBitmap was not null in SplashOutputDev::type3D1");
    return;
  }

  if (unlikely(t3GlyphStack->origSplash != nullptr)) {
    error(errSyntaxWarning, -1,
          "t3GlyphStack origSplash was not null in SplashOutputDev::type3D1");
    return;
  }

  t3Font = t3GlyphStack->cache;

  // check for a valid bbox
  state->transform(0, 0, &xt, &yt);
  state->transform(llx, lly, &x1, &y1);
  xMin = xMax = x1;
  yMin = yMax = y1;
  state->transform(llx, ury, &x1, &y1);
  if (x1 < xMin) {
    xMin = x1;
  } else if (x1 > xMax) {
    xMax = x1;
  }
  if (y1 < yMin) {
    yMin = y1;
  } else if (y1 > yMax) {
    yMax = y1;
  }
  state->transform(urx, lly, &x1, &y1);
  if (x1 < xMin) {
    xMin = x1;
  } else if (x1 > xMax) {
    xMax = x1;
  }
  if (y1 < yMin) {
    yMin = y1;
  } else if (y1 > yMax) {
    yMax = y1;
  }
  state->transform(urx, ury, &x1, &y1);
  if (x1 < xMin) {
    xMin = x1;
  } else if (x1 > xMax) {
    xMax = x1;
  }
  if (y1 < yMin) {
    yMin = y1;
  } else if (y1 > yMax) {
    yMax = y1;
  }
  if (xMin - xt < t3Font->glyphX || yMin - yt < t3Font->glyphY ||
      xMax - xt > t3Font->glyphX + t3Font->glyphW ||
      yMax - yt > t3Font->glyphY + t3Font->glyphH) {
    if (t3Font->validBBox) {
      error(errSyntaxWarning, -1, "Bad bounding box in Type 3 glyph");
    }
    return;
  }

  if (t3Font->cacheTags == nullptr)
    return;

  // allocate a cache entry
  i = (t3GlyphStack->code & (t3Font->cacheSets - 1)) * t3Font->cacheAssoc;
  for (j = 0; j < t3Font->cacheAssoc; ++j) {
    if ((t3Font->cacheTags[i + j].mru & 0x7fff) == t3Font->cacheAssoc - 1) {
      t3Font->cacheTags[i + j].mru = 0x8000;
      t3Font->cacheTags[i + j].code = t3GlyphStack->code;
      t3GlyphStack->cacheTag = &t3Font->cacheTags[i + j];
      t3GlyphStack->cacheData = t3Font->cacheData + (i + j) * t3Font->glyphSize;
    } else {
      ++t3Font->cacheTags[i + j].mru;
    }
  }

  // save state
  t3GlyphStack->origBitmap = bitmap;
  t3GlyphStack->origSplash = splash;
  const double *ctm = state->getCTM();
  t3GlyphStack->origCTM4 = ctm[4];
  t3GlyphStack->origCTM5 = ctm[5];

  // create the temporary bitmap
  if (colorMode == splashModeMono1) {
    bitmap = new SplashBitmap(t3Font->glyphW, t3Font->glyphH, 1,
                              splashModeMono1, false);
    splash = new Splash(bitmap, false, t3GlyphStack->origSplash->getScreen());
    color[0] = 0;
    splash->clear(color);
    color[0] = 0xff;
  } else {
    bitmap = new SplashBitmap(t3Font->glyphW, t3Font->glyphH, 1,
                              splashModeMono8, false);
    splash = new Splash(bitmap, vectorAntialias,
                        t3GlyphStack->origSplash->getScreen());
    color[0] = 0x00;
    splash->clear(color);
    color[0] = 0xff;
  }
  splash->setMinLineWidth(s_minLineWidth);
  splash->setThinLineMode(splashThinLineDefault);
  splash->setFillPattern(new SplashSolidColor(color));
  splash->setStrokePattern(new SplashSolidColor(color));
  //~ this should copy other state from t3GlyphStack->origSplash?
  state->setCTM(ctm[0], ctm[1], ctm[2], ctm[3], -t3Font->glyphX,
                -t3Font->glyphY);
  updateCTM(state, 0, 0, 0, 0, 0, 0);
}

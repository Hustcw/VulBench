bool SplashOutputDev::tilingPatternFill(GfxState *state, Gfx *gfxA,
                                        Catalog *catalog,
                                        GfxTilingPattern *tPat,
                                        const double *mat, int x0, int y0,
                                        int x1, int y1, double xStep,
                                        double yStep) {
  PDFRectangle box;
  Splash *formerSplash = splash;
  SplashBitmap *formerBitmap = bitmap;
  double width, height;
  int surface_width, surface_height, result_width, result_height, i;
  int repeatX, repeatY;
  SplashCoord matc[6];
  Matrix m1;
  const double *ctm;
  double savedCTM[6];
  double kx, ky, sx, sy;
  bool retValue = false;
  const double *bbox = tPat->getBBox();
  const double *ptm = tPat->getMatrix();
  const int paintType = tPat->getPaintType();
  Dict *resDict = tPat->getResDict();

  width = bbox[2] - bbox[0];
  height = bbox[3] - bbox[1];

  if (xStep != width || yStep != height)
    return false;

  // calculate offsets
  ctm = state->getCTM();
  for (i = 0; i < 6; ++i) {
    savedCTM[i] = ctm[i];
  }
  state->concatCTM(mat[0], mat[1], mat[2], mat[3], mat[4], mat[5]);
  state->concatCTM(1, 0, 0, 1, bbox[0], bbox[1]);
  ctm = state->getCTM();
  for (i = 0; i < 6; ++i) {
    if (!std::isfinite(ctm[i])) {
      state->setCTM(savedCTM[0], savedCTM[1], savedCTM[2], savedCTM[3],
                    savedCTM[4], savedCTM[5]);
      return false;
    }
  }
  matc[4] = x0 * xStep * ctm[0] + y0 * yStep * ctm[2] + ctm[4];
  matc[5] = x0 * xStep * ctm[1] + y0 * yStep * ctm[3] + ctm[5];
  if (splashAbs(ctm[1]) > splashAbs(ctm[0])) {
    kx = -ctm[1];
    ky = ctm[2] - (ctm[0] * ctm[3]) / ctm[1];
  } else {
    kx = ctm[0];
    ky = ctm[3] - (ctm[1] * ctm[2]) / ctm[0];
  }
  result_width = (int)ceil(fabs(kx * width * (x1 - x0)));
  result_height = (int)ceil(fabs(ky * height * (y1 - y0)));
  kx = state->getHDPI() / 72.0;
  ky = state->getVDPI() / 72.0;
  m1.m[0] = (ptm[0] == 0) ? fabs(ptm[2]) * kx : fabs(ptm[0]) * kx;
  m1.m[1] = 0;
  m1.m[2] = 0;
  m1.m[3] = (ptm[3] == 0) ? fabs(ptm[1]) * ky : fabs(ptm[3]) * ky;
  m1.m[4] = 0;
  m1.m[5] = 0;
  m1.transform(width, height, &kx, &ky);
  surface_width = (int)ceil(fabs(kx));
  surface_height = (int)ceil(fabs(ky));

  sx = (double)result_width / (surface_width * (x1 - x0));
  sy = (double)result_height / (surface_height * (y1 - y0));
  m1.m[0] *= sx;
  m1.m[3] *= sy;
  m1.transform(width, height, &kx, &ky);

  if (fabs(kx) < 1 && fabs(ky) < 1) {
    kx = std::min<double>(kx, ky);
    ky = 2 / kx;
    m1.m[0] *= ky;
    m1.m[3] *= ky;
    m1.transform(width, height, &kx, &ky);
    surface_width = (int)ceil(fabs(kx));
    surface_height = (int)ceil(fabs(ky));
    repeatX = x1 - x0;
    repeatY = y1 - y0;
  } else {
    if ((unsigned long)surface_width * surface_height > 0x800000L) {
      state->setCTM(savedCTM[0], savedCTM[1], savedCTM[2], savedCTM[3],
                    savedCTM[4], savedCTM[5]);
      return false;
    }
    while (fabs(kx) > 16384 || fabs(ky) > 16384) {
      // limit pattern bitmap size
      m1.m[0] /= 2;
      m1.m[3] /= 2;
      m1.transform(width, height, &kx, &ky);
    }
    surface_width = (int)ceil(fabs(kx));
    surface_height = (int)ceil(fabs(ky));
    // adjust repeat values to completely fill region
    if (unlikely(surface_width == 0 || surface_height == 0)) {
      state->setCTM(savedCTM[0], savedCTM[1], savedCTM[2], savedCTM[3],
                    savedCTM[4], savedCTM[5]);
      return false;
    }
    repeatX = result_width / surface_width;
    repeatY = result_height / surface_height;
    if (surface_width * repeatX < result_width)
      repeatX++;
    if (surface_height * repeatY < result_height)
      repeatY++;
    if (x1 - x0 > repeatX)
      repeatX = x1 - x0;
    if (y1 - y0 > repeatY)
      repeatY = y1 - y0;
  }
  // restore CTM and calculate rotate and scale with rounded matrix
  state->setCTM(savedCTM[0], savedCTM[1], savedCTM[2], savedCTM[3], savedCTM[4],
                savedCTM[5]);
  state->concatCTM(mat[0], mat[1], mat[2], mat[3], mat[4], mat[5]);
  state->concatCTM(width * repeatX, 0, 0, height * repeatY, bbox[0], bbox[1]);
  ctm = state->getCTM();
  matc[0] = ctm[0];
  matc[1] = ctm[1];
  matc[2] = ctm[2];
  matc[3] = ctm[3];

  if (surface_width == 0 || surface_height == 0 || repeatX * repeatY <= 4) {
    state->setCTM(savedCTM[0], savedCTM[1], savedCTM[2], savedCTM[3],
                  savedCTM[4], savedCTM[5]);
    return false;
  }
  m1.transform(bbox[0], bbox[1], &kx, &ky);
  m1.m[4] = -kx;
  m1.m[5] = -ky;

  box.x1 = bbox[0];
  box.y1 = bbox[1];
  box.x2 = bbox[2];
  box.y2 = bbox[3];
  std::unique_ptr<Gfx> gfx = std::make_unique<Gfx>(
      doc, this, resDict, &box, nullptr, nullptr, nullptr, gfxA);
  // set pattern transformation matrix
  gfx->getState()->setCTM(m1.m[0], m1.m[1], m1.m[2], m1.m[3], m1.m[4], m1.m[5]);
  if (splashAbs(matc[1]) > splashAbs(matc[0])) {
    kx = -matc[1];
    ky = matc[2] - (matc[0] * matc[3]) / matc[1];
  } else {
    kx = matc[0];
    ky = matc[3] - (matc[1] * matc[2]) / matc[0];
  }
  result_width = surface_width * repeatX;
  result_height = surface_height * repeatY;
  kx = result_width / (fabs(kx) + 1);
  ky = result_height / (fabs(ky) + 1);
  state->concatCTM(kx, 0, 0, ky, 0, 0);
  ctm = state->getCTM();
  matc[0] = ctm[0];
  matc[1] = ctm[1];
  matc[2] = ctm[2];
  matc[3] = ctm[3];

  const bool doFastBlit =
      matc[0] > 0 && matc[1] == 0 && matc[2] == 0 && matc[3] > 0;
  bitmap = new SplashBitmap(
      surface_width, surface_height, 1,
      (paintType == 1 || doFastBlit) ? colorMode : splashModeMono8, true);
  if (bitmap->getDataPtr() == nullptr) {
    SplashBitmap *tBitmap = bitmap;
    bitmap = formerBitmap;
    delete tBitmap;
    state->setCTM(savedCTM[0], savedCTM[1], savedCTM[2], savedCTM[3],
                  savedCTM[4], savedCTM[5]);
    return false;
  }
  splash = new Splash(bitmap, true);
  updateCTM(gfx->getState(), m1.m[0], m1.m[1], m1.m[2], m1.m[3], m1.m[4],
            m1.m[5]);

  if (paintType == 2) {
    SplashColor clearColor;
    clearColor[0] =
        (colorMode == splashModeCMYK8 || colorMode == splashModeDeviceN8)
            ? 0x00
            : 0xFF;
    splash->clear(clearColor, 0);
  } else {
    splash->clear(paperColor, 0);
  }
  splash->setThinLineMode(formerSplash->getThinLineMode());
  splash->setMinLineWidth(s_minLineWidth);
  if (doFastBlit) {
    // drawImage would colorize the greyscale pattern in tilingBitmapSrc buffer
    // accessor while tiling. blitImage can't, it has no buffer accessor. We
    // instead colorize the pattern prototype in advance.
    splash->setFillPattern(formerSplash->getFillPattern()->copy());
    splash->setStrokePattern(formerSplash->getStrokePattern()->copy());
  }
  gfx->display(tPat->getContentStream());
  delete splash;
  splash = formerSplash;

  TilingSplashOutBitmap imgData;
  imgData.bitmap = bitmap;
  imgData.paintType = paintType;
  imgData.pattern = splash->getFillPattern();
  imgData.colorMode = colorMode;
  imgData.y = 0;
  imgData.repeatX = repeatX;
  imgData.repeatY = repeatY;
  SplashBitmap *tBitmap = bitmap;
  bitmap = formerBitmap;
  if (doFastBlit) {
    // draw the tiles
    for (int y = 0; y < imgData.repeatY; ++y) {
      for (int x = 0; x < imgData.repeatX; ++x) {
        x0 = splashFloor(matc[4]) + x * tBitmap->getWidth();
        y0 = splashFloor(matc[5]) + y * tBitmap->getHeight();
        splash->blitImage(tBitmap, true, x0, y0);
      }
    }
    retValue = true;
  } else {
    retValue = splash->drawImage(&tilingBitmapSrc, nullptr, &imgData, colorMode,
                                 true, result_width, result_height, matc, false,
                                 true) == splashOk;
  }
  delete tBitmap;
  return retValue;
}

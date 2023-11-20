void SplashXPathScanner::clipAALine(SplashBitmap *aaBuf, int *x0, int *x1,
                                    int y) {
  int xx0, xx1, xx, yy, yyMin, yyMax, interCount;
  size_t interIdx;
  unsigned char mask;
  SplashColorPtr p;

  yyMin = 0;
  yyMax = splashAASize - 1;
  // clamp start and end position
  if (yMin > splashAASize * y) {
    yyMin = yMin - splashAASize * y;
  }
  if (yyMax + splashAASize * y > yMax) {
    yyMax = yMax - splashAASize * y;
  }
  for (yy = 0; yy < splashAASize; ++yy) {
    xx = *x0 * splashAASize;
    if (yy >= yyMin && yy <= yyMax) {
      const int intersectionIndex = splashAASize * y + yy - yMin;
      if (unlikely(intersectionIndex < 0 ||
                   (unsigned)intersectionIndex >= allIntersections.size()))
        break;
      const auto &line = allIntersections[intersectionIndex];
      interIdx = 0;
      interCount = 0;
      while (interIdx < line.size() && xx < (*x1 + 1) * splashAASize) {
        xx0 = line[interIdx].x0;
        xx1 = line[interIdx].x1;
        interCount += line[interIdx].count;
        ++interIdx;
        while (interIdx < line.size() &&
               (line[interIdx].x0 <= xx1 ||
                (eo ? (interCount & 1) : (interCount != 0)))) {
          if (line[interIdx].x1 > xx1) {
            xx1 = line[interIdx].x1;
          }
          interCount += line[interIdx].count;
          ++interIdx;
        }
        if (xx0 > aaBuf->getWidth()) {
          xx0 = aaBuf->getWidth();
        }
        // set [xx, xx0) to 0
        if (xx < xx0) {
          p = aaBuf->getDataPtr() + yy * aaBuf->getRowSize() + (xx >> 3);
          if (xx & 7) {
            mask = (unsigned char)(0xff00 >> (xx & 7));
            if ((xx & ~7) == (xx0 & ~7)) {
              mask |= 0xff >> (xx0 & 7);
            }
            *p++ &= mask;
            xx = (xx & ~7) + 8;
          }
          for (; xx + 7 < xx0; xx += 8) {
            *p++ = 0x00;
          }
          if (xx < xx0) {
            *p &= 0xff >> (xx0 & 7);
          }
        }
        if (xx1 >= xx) {
          xx = xx1 + 1;
        }
      }
    }
    xx0 = (*x1 + 1) * splashAASize;
    if (xx0 > aaBuf->getWidth())
      xx0 = aaBuf->getWidth();
    // set [xx, xx0) to 0
    if (xx < xx0 && xx >= 0) {
      p = aaBuf->getDataPtr() + yy * aaBuf->getRowSize() + (xx >> 3);
      if (xx & 7) {
        mask = (unsigned char)(0xff00 >> (xx & 7));
        if ((xx & ~7) == (xx0 & ~7)) {
          mask &= 0xff >> (xx0 & 7);
        }
        *p++ &= mask;
        xx = (xx & ~7) + 8;
      }
      for (; xx + 7 < xx0; xx += 8) {
        *p++ = 0x00;
      }
      if (xx < xx0) {
        *p &= 0xff >> (xx0 & 7);
      }
    }
  }
}

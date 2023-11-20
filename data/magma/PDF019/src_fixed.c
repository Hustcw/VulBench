void JBIG2Bitmap::combine(JBIG2Bitmap *bitmap, int x, int y,
                          unsigned int combOp) {
  int x0, x1, y0, y1, xx, yy;
  unsigned char *srcPtr, *destPtr;
  unsigned int src0, src1, src, dest, s1, s2, m1, m2, m3;
  bool oneByte;

  // check for the pathological case where y = -2^31
  if (y < -0x7fffffff) {
    return;
  }
  if (y < 0) {
    y0 = -y;
  } else {
    y0 = 0;
  }
  if (y + bitmap->h > h) {
    y1 = h - y;
  } else {
    y1 = bitmap->h;
  }
  if (y0 >= y1) {
    return;
  }

  if (x >= 0) {
    x0 = x & ~7;
  } else {
    x0 = 0;
  }
  if (unlikely(checkedAdd(x, bitmap->w, &x1))) {
    return;
  }
  if (x1 > w) {
    x1 = w;
  }
  if (x0 >= x1) {
    return;
  }

  s1 = x & 7;
  s2 = 8 - s1;
  m1 = 0xff >> (x1 & 7);
  m2 = 0xff << (((x1 & 7) == 0) ? 0 : 8 - (x1 & 7));
  m3 = (0xff >> s1) & m2;

  oneByte = x0 == ((x1 - 1) & ~7);

  for (yy = y0; yy < y1; ++yy) {
    if (unlikely((y + yy >= h) || (y + yy < 0)))
      continue;

    // one byte per line -- need to mask both left and right side
    if (oneByte) {
      if (x >= 0) {
        destPtr = data + (y + yy) * line + (x >> 3);
        srcPtr = bitmap->data + yy * bitmap->line;
        dest = *destPtr;
        src1 = *srcPtr;
        switch (combOp) {
        case 0: // or
          dest |= (src1 >> s1) & m2;
          break;
        case 1: // and
          dest &= ((0xff00 | src1) >> s1) | m1;
          break;
        case 2: // xor
          dest ^= (src1 >> s1) & m2;
          break;
        case 3: // xnor
          dest ^= ((src1 ^ 0xff) >> s1) & m2;
          break;
        case 4: // replace
          dest = (dest & ~m3) | ((src1 >> s1) & m3);
          break;
        }
        *destPtr = dest;
      } else {
        destPtr = data + (y + yy) * line;
        srcPtr = bitmap->data + yy * bitmap->line + (-x >> 3);
        dest = *destPtr;
        src1 = *srcPtr;
        switch (combOp) {
        case 0: // or
          dest |= src1 & m2;
          break;
        case 1: // and
          dest &= src1 | m1;
          break;
        case 2: // xor
          dest ^= src1 & m2;
          break;
        case 3: // xnor
          dest ^= (src1 ^ 0xff) & m2;
          break;
        case 4: // replace
          dest = (src1 & m2) | (dest & m1);
          break;
        }
        *destPtr = dest;
      }

      // multiple bytes per line -- need to mask left side of left-most
      // byte and right side of right-most byte
    } else {

      // left-most byte
      if (x >= 0) {
        destPtr = data + (y + yy) * line + (x >> 3);
        srcPtr = bitmap->data + yy * bitmap->line;
        src1 = *srcPtr++;
        dest = *destPtr;
        switch (combOp) {
        case 0: // or
          dest |= src1 >> s1;
          break;
        case 1: // and
          dest &= (0xff00 | src1) >> s1;
          break;
        case 2: // xor
          dest ^= src1 >> s1;
          break;
        case 3: // xnor
          dest ^= (src1 ^ 0xff) >> s1;
          break;
        case 4: // replace
          dest = (dest & (0xff << s2)) | (src1 >> s1);
          break;
        }
        *destPtr++ = dest;
        xx = x0 + 8;
      } else {
        destPtr = data + (y + yy) * line;
        srcPtr = bitmap->data + yy * bitmap->line + (-x >> 3);
        src1 = *srcPtr++;
        xx = x0;
      }

      // middle bytes
      for (; xx < x1 - 8; xx += 8) {
        dest = *destPtr;
        src0 = src1;
        src1 = *srcPtr++;
        src = (((src0 << 8) | src1) >> s1) & 0xff;
        switch (combOp) {
        case 0: // or
          dest |= src;
          break;
        case 1: // and
          dest &= src;
          break;
        case 2: // xor
          dest ^= src;
          break;
        case 3: // xnor
          dest ^= src ^ 0xff;
          break;
        case 4: // replace
          dest = src;
          break;
        }
        *destPtr++ = dest;
      }

      // right-most byte
      // note: this last byte (src1) may not actually be used, depending
      // on the values of s1, m1, and m2 - and in fact, it may be off
      // the edge of the source bitmap, which means we need to allocate
      // one extra guard byte at the end of each bitmap
      dest = *destPtr;
      src0 = src1;
      src1 = *srcPtr++;
      src = (((src0 << 8) | src1) >> s1) & 0xff;
      switch (combOp) {
      case 0: // or
        dest |= src & m2;
        break;
      case 1: // and
        dest &= src | m1;
        break;
      case 2: // xor
        dest ^= src & m2;
        break;
      case 3: // xnor
        dest ^= (src ^ 0xff) & m2;
        break;
      case 4: // replace
        dest = (src & m2) | (dest & m1);
        break;
      }
      *destPtr = dest;
    }
  }
}

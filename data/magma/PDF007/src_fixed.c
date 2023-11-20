unsigned char *ImageStream::getLine() {
  if (unlikely(inputLine == nullptr)) {
    return nullptr;
  }

  int readChars = str->doGetChars(inputLineSize, inputLine);
  if (unlikely(readChars == -1)) {
    readChars = 0;
  }
  for (; readChars < inputLineSize; readChars++)
    inputLine[readChars] = EOF;
  if (nBits == 1) {
    unsigned char *p = inputLine;
    for (int i = 0; i < nVals; i += 8) {
      const int c = *p++;
      imgLine[i + 0] = (unsigned char)((c >> 7) & 1);
      imgLine[i + 1] = (unsigned char)((c >> 6) & 1);
      imgLine[i + 2] = (unsigned char)((c >> 5) & 1);
      imgLine[i + 3] = (unsigned char)((c >> 4) & 1);
      imgLine[i + 4] = (unsigned char)((c >> 3) & 1);
      imgLine[i + 5] = (unsigned char)((c >> 2) & 1);
      imgLine[i + 6] = (unsigned char)((c >> 1) & 1);
      imgLine[i + 7] = (unsigned char)(c & 1);
    }
  } else if (nBits == 8) {
    // special case: imgLine == inputLine
  } else if (nBits == 16) {
    // this is a hack to support 16 bits images, everywhere
    // we assume a component fits in 8 bits, with this hack
    // we treat 16 bit images as 8 bit ones until it's fixed correctly.
    // The hack has another part on GfxImageColorMap::GfxImageColorMap
    unsigned char *p = inputLine;
    for (int i = 0; i < nVals; ++i) {
      imgLine[i] = *p++;
      p++;
    }
  } else {
    const unsigned long bitMask = (1 << nBits) - 1;
    unsigned long buf = 0;
    int bits = 0;
    unsigned char *p = inputLine;
    for (int i = 0; i < nVals; ++i) {
      while (bits < nBits) {
        buf = (buf << 8) | (*p++ & 0xff);
        bits += 8;
      }
      imgLine[i] = (unsigned char)((buf >> (bits - nBits)) & bitMask);
      bits -= nBits;
    }
  }
  return imgLine;
}

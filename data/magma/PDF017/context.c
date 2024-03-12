void FoFiTrueType::dumpString(const unsigned char *s, int length, FoFiOutputFunc outputFunc, void *outputStream) const
{
    GooString *buf;
    int pad, i, j;

    (*outputFunc)(outputStream, "<", 1);
    for (i = 0; i < length; i += 32) {
        for (j = 0; j < 32 && i + j < length; ++j) {
            buf = GooString::format("{0:02x}", s[i + j] & 0xff);
            (*outputFunc)(outputStream, buf->c_str(), buf->getLength());
            delete buf;
        }
        if (i % (65536 - 32) == 65536 - 64) {
            (*outputFunc)(outputStream, ">\n<", 3);
        } else if (i + 32 < length) {
            (*outputFunc)(outputStream, "\n", 1);
        }
    }
    if (length & 3) {
        pad = 4 - (length & 3);
        for (i = 0; i < pad; ++i) {
            (*outputFunc)(outputStream, "00", 2);
        }
    }
    // add an extra zero byte because the Adobe Type 42 spec says so
    (*outputFunc)(outputStream, "00>\n", 4);
}

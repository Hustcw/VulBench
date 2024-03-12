inline unsigned char *toUnsignedChars(int *length, int initialSize = 4096, int sizeIncrement = 4096)
{
    int readChars;
    unsigned char *buf = (unsigned char *)gmalloc(initialSize);
    int size = initialSize;
    *length = 0;
    int charsToRead = initialSize;
    bool continueReading = true;
    reset();
    while (continueReading && (readChars = doGetChars(charsToRead, &buf[*length])) != 0) {
        *length += readChars;
        if (readChars == charsToRead) {
            if (lookChar() != EOF) {
                size += sizeIncrement;
                charsToRead = sizeIncrement;
                buf = (unsigned char *)grealloc(buf, size);
            } else {
                continueReading = false;
            }
        } else {
            continueReading = false;
        }
    }
    return buf;
}
class POPPLER_PRIVATE_EXPORT Stream {
		...
    inline int doGetChars(int nChars, unsigned char *buffer)
    {
        if (hasGetChars()) {
            return getChars(nChars, buffer);
        } else {
            for (int i = 0; i < nChars; ++i) {
                const int c = getChar();
                if (likely(c != EOF))
                    buffer[i] = c;
                else
                    return i;
            }
            return nChars;
        }
    }
		...
}

class BaseStreamStream : public Stream
{
		...
    std::unique_ptr<Stream> str;
		...
};

class POPPLER_PRIVATE_EXPORT BaseStream : public Stream {
		...
}

class POPPLER_PRIVATE_EXPORT EmbedStream : public BaseStream {
		...
		bool hasGetChars() override { return true; }
    int getChars(int nChars, unsigned char *buffer) override;
		...
}

int EmbedStream::getChars(int nChars, unsigned char *buffer)
{
    int len;

    if (nChars <= 0) {
        return 0;
    }
    if (replay) {
        if (bufPos >= bufLen)
            return EOF;
        len = bufLen - bufPos;
        if (nChars > len)
            nChars = len;
        memcpy(buffer, bufData, nChars);
        return len;
    } else {
        if (limited && length < nChars) {
            nChars = length;
        }
        len = str->doGetChars(nChars, buffer);
        if (record) {
            if (bufLen + len >= bufMax) {
                while (bufLen + len >= bufMax)
                    bufMax *= 2;
                bufData = (unsigned char *)grealloc(bufData, bufMax);
            }
            memcpy(bufData + bufLen, buffer, len);
            bufLen += len;
        }
    }
    return len;
}
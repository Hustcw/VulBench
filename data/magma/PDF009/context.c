    Stream *makeSubStream(Goffset startA, bool limited, Goffset lengthA, Object &&dictA) override
    {
        Goffset newLength;

        if (!limited || startA + lengthA > start + length) {
            newLength = start + length - startA;
        } else {
            newLength = lengthA;
        }
        return new BaseMemStream(buf, startA, newLength, std::move(dictA));
    }
static int get_bits(Jpeg2000DecoderContext *s, int n)
{
    int res = 0;
    if (s->buf_end - s->buf < ((n - s->bit_index) >> 8))
        return AVERROR(EINVAL);
    while (--n >= 0) {
        res <<= 1;
        if (s->bit_index == 0) {
            s->bit_index = 7 + (*s->buf != 0xff);
            s->buf++;
        }
        s->bit_index--;
        res |= (*s->buf >> s->bit_index) & 1;
    }
    return res;
}
static int get_qcc(Jpeg2000DecoderContext *s, int n, Jpeg2000QuantStyle *q,
                   uint8_t *properties)
{
    int compno;

    if (s->buf_end - s->buf < 1)
        return AVERROR(EINVAL);

    compno              = bytestream_get_byte(&s->buf);
    properties[compno] |= HAD_QCC;
    return get_qcx(s, n - 1, q + compno);
}
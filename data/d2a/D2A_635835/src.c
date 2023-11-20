static int asf_read_multiple_payload(AVFormatContext *s, AVPacket *pkt,
                                 ASFPacket *asf_pkt)
{
    ASFContext *asf = s->priv_data;
    AVIOContext *pb = s->pb;
    uint16_t pay_len;
    unsigned char *p;
    int ret;
    int skip = 0;

    // if replicated lenght is 1, subpayloads are present
    if (asf->rep_data_len == 1) {
        asf->sub_left = 1;
        asf->state = READ_MULTI_SUB;
        pkt->flags = asf_pkt->flags;
        if ((ret = asf_read_subpayload(s, pkt, 1)) < 0)
            return ret;
    } else {
        if (asf->rep_data_len)
            if ((ret = asf_read_replicated_data(s, asf_pkt)) < 0)
                return ret;
        pay_len = avio_rl16(pb); // payload length should be WORD
        if (pay_len > asf->packet_size) {
            av_log(s, AV_LOG_ERROR,
                   "Error: invalid data packet size, pay_len %"PRIu16", "
                   "asf->packet_size %"PRIu32", offset %"PRId64".\n",
                   pay_len, asf->packet_size, avio_tell(pb));
            return AVERROR_INVALIDDATA;
        }
        p = asf_pkt->avpkt.data + asf_pkt->data_size - asf_pkt->size_left;
        if (pay_len > asf_pkt->size_left) {
            av_log(s, AV_LOG_ERROR,
                   "Error: invalid buffer size, pay_len %d, data size left %d.\n",
            pay_len, asf_pkt->size_left);
            skip = pay_len - asf_pkt->size_left;
            pay_len = asf_pkt->size_left;
        }
        if (asf_pkt->size_left <= 0)
            return AVERROR_INVALIDDATA;
        if ((ret = avio_read(pb, p, pay_len)) < 0)
            return ret;
        if (s->key && s->keylen == 20)
            ff_asfcrypt_dec(s->key, p, ret);
        avio_skip(pb, skip);
        asf_pkt->size_left -= pay_len;
        asf->nb_mult_left--;
    }

    return 0;
}
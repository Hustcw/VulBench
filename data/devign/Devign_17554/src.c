void av_init_packet(AVPacket *pkt)
{
    pkt->pts                  = AV_NOPTS_VALUE;
    pkt->dts                  = AV_NOPTS_VALUE;
    pkt->pos                  = -1;
    pkt->duration             = 0;
#if FF_API_CONVERGENCE_DURATION
FF_DISABLE_DEPRECATION_WARNINGS
    pkt->convergence_duration = 0;
FF_ENABLE_DEPRECATION_WARNINGS
#endif
    pkt->flags                = 0;
    pkt->stream_index         = 0;
    pkt->buf                  = NULL;
    pkt->side_data            = NULL;
    pkt->side_data_elems      = 0;
}

int av_read_frame(AVFormatContext *s, AVPacket *pkt)
{
    const int genpts = s->flags & AVFMT_FLAG_GENPTS;
    int eof = 0;

    if (!genpts)
        return s->internal->packet_buffer
               ? read_from_packet_buffer(&s->internal->packet_buffer,
                                         &s->internal->packet_buffer_end, pkt)
               : read_frame_internal(s, pkt);

    for (;;) {
        int ret;
        AVPacketList *pktl = s->internal->packet_buffer;

        if (pktl) {
            AVPacket *next_pkt = &pktl->pkt;

            if (next_pkt->dts != AV_NOPTS_VALUE) {
                int wrap_bits = s->streams[next_pkt->stream_index]->pts_wrap_bits;
                while (pktl && next_pkt->pts == AV_NOPTS_VALUE) {
                    if (pktl->pkt.stream_index == next_pkt->stream_index &&
                        (av_compare_mod(next_pkt->dts, pktl->pkt.dts, 2LL << (wrap_bits - 1)) < 0) &&
                         av_compare_mod(pktl->pkt.pts, pktl->pkt.dts, 2LL << (wrap_bits - 1))) {
                        // not B-frame
                        next_pkt->pts = pktl->pkt.dts;
                    }
                    pktl = pktl->next;
                }
                pktl = s->internal->packet_buffer;
            }

            /* read packet from packet buffer, if there is data */
            if (!(next_pkt->pts == AV_NOPTS_VALUE &&
                  next_pkt->dts != AV_NOPTS_VALUE && !eof))
                return read_from_packet_buffer(&s->internal->packet_buffer,
                                               &s->internal->packet_buffer_end, pkt);
        }

        ret = read_frame_internal(s, pkt);
        if (ret < 0) {
            if (pktl && ret != AVERROR(EAGAIN)) {
                eof = 1;
                continue;
            } else
                return ret;
        }

        if (av_dup_packet(add_to_pktbuf(&s->internal->packet_buffer, pkt,
                                        &s->internal->packet_buffer_end)) < 0)
            return AVERROR(ENOMEM);
    }
}

static void show_packet(AVFormatContext *fmt_ctx, AVPacket *pkt)
{
    char val_str[128];
    AVStream *st = fmt_ctx->streams[pkt->stream_index];

    probe_object_header("packet");
    probe_str("codec_type", media_type_string(st->codec->codec_type));
    probe_int("stream_index", pkt->stream_index);
    probe_str("pts", ts_value_string(val_str, sizeof(val_str), pkt->pts));
    probe_str("pts_time", time_value_string(val_str, sizeof(val_str),
                                               pkt->pts, &st->time_base));
    probe_str("dts", ts_value_string(val_str, sizeof(val_str), pkt->dts));
    probe_str("dts_time", time_value_string(val_str, sizeof(val_str),
                                               pkt->dts, &st->time_base));
    probe_str("duration", ts_value_string(val_str, sizeof(val_str),
                                             pkt->duration));
    probe_str("duration_time", time_value_string(val_str, sizeof(val_str),
                                                    pkt->duration,
                                                    &st->time_base));
    probe_str("size", value_string(val_str, sizeof(val_str),
                                      pkt->size, unit_byte_str));
    probe_int("pos", pkt->pos);
    probe_str("flags", pkt->flags & AV_PKT_FLAG_KEY ? "K" : "_");
    probe_object_footer("packet");
}
static void show_packets(AVFormatContext *fmt_ctx)

{

    AVPacket pkt;



    av_init_packet(&pkt);

    probe_array_header("packets", 0);

    while (!av_read_frame(fmt_ctx, &pkt))

        show_packet(fmt_ctx, &pkt);

    probe_array_footer("packets", 0);

}

static int decode_frame_header(NUTContext *nut, int64_t *pts, int *stream_id,

                               uint8_t *header_idx, int frame_code)

{

    AVFormatContext *s = nut->avf;

    AVIOContext *bc    = s->pb;

    StreamContext *stc;

    int size, flags, size_mul, pts_delta, i, reserved_count;

    uint64_t tmp;



    if (avio_tell(bc) > nut->last_syncpoint_pos + nut->max_distance) {

        av_log(s, AV_LOG_ERROR,

               "Last frame must have been damaged %"PRId64" > %"PRId64" + %d\n",

               avio_tell(bc), nut->last_syncpoint_pos, nut->max_distance);

        return AVERROR_INVALIDDATA;

    }



    flags          = nut->frame_code[frame_code].flags;

    size_mul       = nut->frame_code[frame_code].size_mul;

    size           = nut->frame_code[frame_code].size_lsb;

    *stream_id     = nut->frame_code[frame_code].stream_id;

    pts_delta      = nut->frame_code[frame_code].pts_delta;

    reserved_count = nut->frame_code[frame_code].reserved_count;

    *header_idx    = nut->frame_code[frame_code].header_idx;



    if (flags & FLAG_INVALID)

        return AVERROR_INVALIDDATA;

    if (flags & FLAG_CODED)

        flags ^= ffio_read_varlen(bc);

    if (flags & FLAG_STREAM_ID) {

        GET_V(*stream_id, tmp < s->nb_streams);

    }

    stc = &nut->stream[*stream_id];

    if (flags & FLAG_CODED_PTS) {

        int coded_pts = ffio_read_varlen(bc);

        // FIXME check last_pts validity?

        if (coded_pts < (1 << stc->msb_pts_shift)) {

            *pts = ff_lsb2full(stc, coded_pts);

        } else

            *pts = coded_pts - (1 << stc->msb_pts_shift);

    } else

        *pts = stc->last_pts + pts_delta;

    if (flags & FLAG_SIZE_MSB)

        size += size_mul * ffio_read_varlen(bc);

    if (flags & FLAG_MATCH_TIME)

        get_s(bc);

    if (flags & FLAG_HEADER_IDX)

        *header_idx = ffio_read_varlen(bc);

    if (flags & FLAG_RESERVED)

        reserved_count = ffio_read_varlen(bc);

    for (i = 0; i < reserved_count; i++)

        ffio_read_varlen(bc);



    if (*header_idx >= (unsigned)nut->header_count) {

        av_log(s, AV_LOG_ERROR, "header_idx invalid\n");

        return AVERROR_INVALIDDATA;

    }

    if (size > 4096)

        *header_idx = 0;

    size -= nut->header_len[*header_idx];



    if (flags & FLAG_CHECKSUM) {

        avio_rb32(bc); // FIXME check this

    } else if (size > 2 * nut->max_distance || FFABS(stc->last_pts - *pts) >

               stc->max_pts_distance) {

        av_log(s, AV_LOG_ERROR, "frame size > 2max_distance and no checksum\n");

        return AVERROR_INVALIDDATA;

    }



    stc->last_pts   = *pts;

    stc->last_flags = flags;



    return size;

}

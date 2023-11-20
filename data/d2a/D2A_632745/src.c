static char *extradata2psets_hevc(AVCodecContext *c)
{
    char *psets;
    uint8_t *extradata = c->extradata;
    int extradata_size = c->extradata_size;
    uint8_t *tmpbuf = NULL;
    int ps_pos[3] = { 0 };
    static const char * const ps_names[3] = { "vps", "sps", "pps" };
    int num_arrays, num_nalus;
    int pos, i, j;

    // Convert to hvcc format. Since we need to group multiple NALUs of
    // the same type, and we might need to convert from one format to the
    // other anyway, we get away with a little less work by using the hvcc
    // format.
    if (c->extradata[0] != 1) {
        AVIOContext *pb;
        if (avio_open_dyn_buf(&pb) < 0)
            return NULL;
        if (ff_isom_write_hvcc(pb, c->extradata, c->extradata_size, 0) < 0) {
            avio_close_dyn_buf(pb, &tmpbuf);
            goto err;
        }
        extradata_size = avio_close_dyn_buf(pb, &extradata);
        tmpbuf = extradata;
    }

    if (extradata_size < 23)
        goto err;

    num_arrays = extradata[22];
    pos = 23;
    for (i = 0; i < num_arrays; i++) {
        int num_nalus, nalu_type;
        if (pos + 3 > extradata_size)
            goto err;
        nalu_type = extradata[pos] & 0x3f;
        // Not including libavcodec/hevc.h to avoid confusion between
        // NAL_* with the same name for both H264 and HEVC.
        if (nalu_type == 32) // VPS
            ps_pos[0] = pos;
        else if (nalu_type == 33) // SPS
            ps_pos[1] = pos;
        else if (nalu_type == 34) // PPS
            ps_pos[2] = pos;
        num_nalus = AV_RB16(&extradata[pos + 1]);
        pos += 3;
        for (j = 0; j < num_nalus; j++) {
            int len;
            if (pos + 2 > extradata_size)
                goto err;
            len = AV_RB16(&extradata[pos]);
            pos += 2;
            if (pos + len > extradata_size)
                goto err;
            pos += len;
        }
    }
    if (!ps_pos[0] || !ps_pos[1] || !ps_pos[2])
        goto err;

    psets = av_mallocz(MAX_PSET_SIZE);
    if (!psets)
        goto err;
    psets[0] = '\0';

    for (i = 0; i < 3; i++) {
        pos = ps_pos[i];

        if (i > 0)
            av_strlcat(psets, "; ", MAX_PSET_SIZE);
        av_strlcatf(psets, MAX_PSET_SIZE, "sprop-%s=", ps_names[i]);

        // Skipping boundary checks in the input here; we've already traversed
        // the whole hvcc structure above without issues
        num_nalus = AV_RB16(&extradata[pos + 1]);
        pos += 3;
        for (j = 0; j < num_nalus; j++) {
            int len = AV_RB16(&extradata[pos]);
            int strpos;
            pos += 2;
            if (j > 0)
                av_strlcat(psets, ",", MAX_PSET_SIZE);
            strpos = strlen(psets);
            if (!av_base64_encode(psets + strpos, MAX_PSET_SIZE - strpos,
                                  &extradata[pos], len)) {
                av_free(psets);
                goto err;
            }
            pos += len;
        }
    }
    av_free(tmpbuf);

    return psets;

err:
    av_free(tmpbuf);
    return NULL;
}
static int read_frame(BVID_DemuxContext *vid, AVIOContext *pb, AVPacket *pkt,
                      uint8_t block_type, AVFormatContext *s)
{
    uint8_t * vidbuf_start = NULL;
    int vidbuf_nbytes = 0;
    int code;
    int bytes_copied = 0;
    int position, duration, npixels;
    unsigned int vidbuf_capacity;
    int ret = 0;
    AVStream *st;

    if (vid->video_index < 0) {
        st = avformat_new_stream(s, NULL);
        if (!st)
            return AVERROR(ENOMEM);
        vid->video_index = st->index;
        if (vid->audio_index < 0) {
            av_log_ask_for_sample(s, "No audio packet before first video "
                                  "packet. Using default video time base.\n");
        }
        avpriv_set_pts_info(st, 64, 185, vid->sample_rate);
        st->codec->codec_type = AVMEDIA_TYPE_VIDEO;
        st->codec->codec_id   = AV_CODEC_ID_BETHSOFTVID;
        st->codec->width      = vid->width;
        st->codec->height     = vid->height;
    }
    st      = s->streams[vid->video_index];
    npixels = st->codec->width * st->codec->height;

    vidbuf_start = av_malloc(vidbuf_capacity = BUFFER_PADDING_SIZE);
    if(!vidbuf_start)
        return AVERROR(ENOMEM);

    // save the file position for the packet, include block type
    position = avio_tell(pb) - 1;

    vidbuf_start[vidbuf_nbytes++] = block_type;

    // get the current packet duration
    duration = vid->bethsoft_global_delay + avio_rl16(pb);

    // set the y offset if it exists (decoder header data should be in data section)
    if(block_type == VIDEO_YOFF_P_FRAME){
        if (avio_read(pb, &vidbuf_start[vidbuf_nbytes], 2) != 2) {
            ret = AVERROR(EIO);
            goto fail;
        }
        vidbuf_nbytes += 2;
    }

    do{
        vidbuf_start = av_fast_realloc(vidbuf_start, &vidbuf_capacity, vidbuf_nbytes + BUFFER_PADDING_SIZE);
        if(!vidbuf_start)
            return AVERROR(ENOMEM);

        code = avio_r8(pb);
        vidbuf_start[vidbuf_nbytes++] = code;

        if(code >= 0x80){ // rle sequence
            if(block_type == VIDEO_I_FRAME)
                vidbuf_start[vidbuf_nbytes++] = avio_r8(pb);
        } else if(code){ // plain sequence
            if (avio_read(pb, &vidbuf_start[vidbuf_nbytes], code) != code) {
                ret = AVERROR(EIO);
                goto fail;
            }
            vidbuf_nbytes += code;
        }
        bytes_copied += code & 0x7F;
        if(bytes_copied == npixels){ // sometimes no stop character is given, need to keep track of bytes copied
            // may contain a 0 byte even if read all pixels
            if(avio_r8(pb))
                avio_seek(pb, -1, SEEK_CUR);
            break;
        }
        if (bytes_copied > npixels) {
            ret = AVERROR_INVALIDDATA;
            goto fail;
        }
    } while(code);

    // copy data into packet
    if ((ret = av_new_packet(pkt, vidbuf_nbytes)) < 0)
        goto fail;
    memcpy(pkt->data, vidbuf_start, vidbuf_nbytes);
    av_free(vidbuf_start);

    pkt->pos = position;
    pkt->stream_index = vid->video_index;
    pkt->duration = duration;
    if (block_type == VIDEO_I_FRAME)
        pkt->flags |= AV_PKT_FLAG_KEY;

    /* if there is a new palette available, add it to packet side data */
    if (vid->palette) {
        uint8_t *pdata = av_packet_new_side_data(pkt, AV_PKT_DATA_PALETTE,
                                                 BVID_PALETTE_SIZE);
        memcpy(pdata, vid->palette, BVID_PALETTE_SIZE);
        av_freep(&vid->palette);
    }

    vid->nframes--;  // used to check if all the frames were read
    return 0;
fail:
    av_free(vidbuf_start);
    return ret;
}
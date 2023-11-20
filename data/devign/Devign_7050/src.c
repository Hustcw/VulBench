static int ea_read_header(AVFormatContext *s,
                          AVFormatParameters *ap)
{
    EaDemuxContext *ea = s->priv_data;
    AVStream *st;
    if (!process_ea_header(s))
        return AVERROR(EIO);
    if (ea->video_codec) {
        /* initialize the video decoder stream */
        st = av_new_stream(s, 0);
        if (!st)
            return AVERROR(ENOMEM);
        ea->video_stream_index = st->index;
        st->codec->codec_type = AVMEDIA_TYPE_VIDEO;
        st->codec->codec_id = ea->video_codec;
        st->codec->codec_tag = 0;  /* no fourcc */
        st->codec->time_base = ea->time_base;
        st->codec->width = ea->width;
        st->codec->height = ea->height;
    if (ea->num_channels <= 0) {
        av_log(s, AV_LOG_WARNING, "Unsupported number of channels: %d\n", ea->num_channels);
    if (ea->audio_codec) {
        /* initialize the audio decoder stream */
        st = av_new_stream(s, 0);
        if (!st)
            return AVERROR(ENOMEM);
        av_set_pts_info(st, 33, 1, ea->sample_rate);
        st->codec->codec_type = AVMEDIA_TYPE_AUDIO;
        st->codec->codec_id = ea->audio_codec;
        st->codec->codec_tag = 0;  /* no tag */
        st->codec->channels = ea->num_channels;
        st->codec->sample_rate = ea->sample_rate;
        st->codec->bits_per_coded_sample = ea->bytes * 8;
        st->codec->bit_rate = st->codec->channels * st->codec->sample_rate *
            st->codec->bits_per_coded_sample / 4;
        st->codec->block_align = st->codec->channels*st->codec->bits_per_coded_sample;
        ea->audio_stream_index = st->index;
        ea->audio_frame_counter = 0;
    return 1;
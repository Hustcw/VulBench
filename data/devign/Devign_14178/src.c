static void do_subtitle_out(AVFormatContext *s,

                            OutputStream *ost,

                            InputStream *ist,

                            AVSubtitle *sub,

                            int64_t pts)

{

    int subtitle_out_max_size = 1024 * 1024;

    int subtitle_out_size, nb, i;

    AVCodecContext *enc;

    AVPacket pkt;



    if (pts == AV_NOPTS_VALUE) {

        av_log(NULL, AV_LOG_ERROR, "Subtitle packets must have a pts\n");

        if (exit_on_error)

            exit_program(1);

        return;

    }



    enc = ost->st->codec;



    if (!subtitle_out) {

        subtitle_out = av_malloc(subtitle_out_max_size);

    }



    /* Note: DVB subtitle need one packet to draw them and one other

       packet to clear them */

    /* XXX: signal it in the codec context ? */

    if (enc->codec_id == CODEC_ID_DVB_SUBTITLE)

        nb = 2;

    else

        nb = 1;



    for (i = 0; i < nb; i++) {

        ost->sync_opts = av_rescale_q(pts, ist->st->time_base, enc->time_base);

        if (!check_recording_time(ost))

            return;



        sub->pts = av_rescale_q(pts, ist->st->time_base, AV_TIME_BASE_Q);

        // start_display_time is required to be 0

        sub->pts               += av_rescale_q(sub->start_display_time, (AVRational){ 1, 1000 }, AV_TIME_BASE_Q);

        sub->end_display_time  -= sub->start_display_time;

        sub->start_display_time = 0;

        subtitle_out_size = avcodec_encode_subtitle(enc, subtitle_out,

                                                    subtitle_out_max_size, sub);

        if (subtitle_out_size < 0) {

            av_log(NULL, AV_LOG_FATAL, "Subtitle encoding failed\n");

            exit_program(1);

        }



        av_init_packet(&pkt);

        pkt.data = subtitle_out;

        pkt.size = subtitle_out_size;

        pkt.pts  = av_rescale_q(sub->pts, AV_TIME_BASE_Q, ost->st->time_base);

        pkt.duration = av_rescale_q(sub->end_display_time, (AVRational){ 1, 1000 }, ost->st->time_base);

        if (enc->codec_id == CODEC_ID_DVB_SUBTITLE) {

            /* XXX: the pts correction is handled here. Maybe handling

               it in the codec would be better */

            if (i == 0)

                pkt.pts += 90 * sub->start_display_time;

            else

                pkt.pts += 90 * sub->end_display_time;

        }

        write_frame(s, &pkt, ost);

        subtitle_size += pkt.size;

    }

}

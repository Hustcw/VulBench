static int reap_filters(void)

{

    AVFilterBufferRef *picref;

    AVFrame *filtered_frame = NULL;

    int i;

    int64_t frame_pts;



    /* Reap all buffers present in the buffer sinks */

    for (i = 0; i < nb_output_streams; i++) {

        OutputStream *ost = output_streams[i];

        OutputFile    *of = output_files[ost->file_index];

        int ret = 0;



        if (!ost->filter)

            continue;



        if (!ost->filtered_frame && !(ost->filtered_frame = avcodec_alloc_frame())) {

            return AVERROR(ENOMEM);

        } else

            avcodec_get_frame_defaults(ost->filtered_frame);

        filtered_frame = ost->filtered_frame;



        while (1) {

            ret = av_buffersink_get_buffer_ref(ost->filter->filter, &picref,

                                               AV_BUFFERSINK_FLAG_NO_REQUEST);

            if (ret < 0) {

                if (ret != AVERROR(EAGAIN) && ret != AVERROR_EOF) {

                    char buf[256];

                    av_strerror(ret, buf, sizeof(buf));

                    av_log(NULL, AV_LOG_WARNING,

                           "Error in av_buffersink_get_buffer_ref(): %s\n", buf);




            frame_pts = AV_NOPTS_VALUE;

            if (picref->pts != AV_NOPTS_VALUE) {

                filtered_frame->pts = frame_pts = av_rescale_q(picref->pts,

                                                ost->filter->filter->inputs[0]->time_base,

                                                ost->st->codec->time_base) -

                                    av_rescale_q(of->start_time,

                                                AV_TIME_BASE_Q,

                                                ost->st->codec->time_base);



                if (of->start_time && filtered_frame->pts < 0) {

                    avfilter_unref_buffer(picref);

                    continue;



            //if (ost->source_index >= 0)

            //    *filtered_frame= *input_streams[ost->source_index]->decoded_frame; //for me_threshold





            switch (ost->filter->filter->inputs[0]->type) {

            case AVMEDIA_TYPE_VIDEO:

                avfilter_copy_buf_props(filtered_frame, picref);

                filtered_frame->pts = frame_pts;

                if (!ost->frame_aspect_ratio)

                    ost->st->codec->sample_aspect_ratio = picref->video->sample_aspect_ratio;



                do_video_out(of->ctx, ost, filtered_frame);


            case AVMEDIA_TYPE_AUDIO:

                avfilter_copy_buf_props(filtered_frame, picref);

                filtered_frame->pts = frame_pts;







                do_audio_out(of->ctx, ost, filtered_frame);


            default:

                // TODO support subtitle filters

                av_assert0(0);




            avfilter_unref_buffer(picref);





    return 0;

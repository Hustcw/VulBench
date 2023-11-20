static int v4l2_read_header(AVFormatContext *s1)

{

    struct video_data *s = s1->priv_data;

    AVStream *st;

    int res = 0;

    uint32_t desired_format;

    enum AVCodecID codec_id = AV_CODEC_ID_NONE;

    enum AVPixelFormat pix_fmt = AV_PIX_FMT_NONE;

    struct v4l2_input input = { 0 };



    st = avformat_new_stream(s1, NULL);

    if (!st)

        return AVERROR(ENOMEM);



#if CONFIG_LIBV4L2

    /* silence libv4l2 logging. if fopen() fails v4l2_log_file will be NULL

       and errors will get sent to stderr */

    v4l2_log_file = fopen("/dev/null", "w");

#endif



    s->fd = device_open(s1);

    if (s->fd < 0)

        return s->fd;



    if (s->channel != -1) {

        /* set video input */

        av_log(s1, AV_LOG_DEBUG, "Selecting input_channel: %d\n", s->channel);

        if (v4l2_ioctl(s->fd, VIDIOC_S_INPUT, &s->channel) < 0) {

            res = AVERROR(errno);

            av_log(s1, AV_LOG_ERROR, "ioctl(VIDIOC_S_INPUT): %s\n", av_err2str(res));

            return res;

        }

    } else {

        /* get current video input */

        if (v4l2_ioctl(s->fd, VIDIOC_G_INPUT, &s->channel) < 0) {

            res = AVERROR(errno);

            av_log(s1, AV_LOG_ERROR, "ioctl(VIDIOC_G_INPUT): %s\n", av_err2str(res));

            return res;

        }

    }



    /* enum input */

    input.index = s->channel;

    if (v4l2_ioctl(s->fd, VIDIOC_ENUMINPUT, &input) < 0) {

        res = AVERROR(errno);

        av_log(s1, AV_LOG_ERROR, "ioctl(VIDIOC_ENUMINPUT): %s\n", av_err2str(res));

        return res;

    }

    s->std_id = input.std;

    av_log(s1, AV_LOG_DEBUG, "Current input_channel: %d, input_name: %s\n",

           s->channel, input.name);



    if (s->list_format) {

        list_formats(s1, s->fd, s->list_format);

        return AVERROR_EXIT;

    }



    if (s->list_standard) {

        list_standards(s1);

        return AVERROR_EXIT;

    }



    avpriv_set_pts_info(st, 64, 1, 1000000); /* 64 bits pts in us */



    if (s->pixel_format) {

        AVCodec *codec = avcodec_find_decoder_by_name(s->pixel_format);



        if (codec)

            s1->video_codec_id = codec->id;



        pix_fmt = av_get_pix_fmt(s->pixel_format);



        if (pix_fmt == AV_PIX_FMT_NONE && !codec) {

            av_log(s1, AV_LOG_ERROR, "No such input format: %s.\n",

                   s->pixel_format);



            return AVERROR(EINVAL);

        }

    }



    if (!s->width && !s->height) {

        struct v4l2_format fmt;



        av_log(s1, AV_LOG_VERBOSE,

               "Querying the device for the current frame size\n");

        fmt.type = V4L2_BUF_TYPE_VIDEO_CAPTURE;

        if (v4l2_ioctl(s->fd, VIDIOC_G_FMT, &fmt) < 0) {

            res = AVERROR(errno);

            av_log(s1, AV_LOG_ERROR, "ioctl(VIDIOC_G_FMT): %s\n", av_err2str(res));

            return res;

        }



        s->width  = fmt.fmt.pix.width;

        s->height = fmt.fmt.pix.height;

        av_log(s1, AV_LOG_VERBOSE,

               "Setting frame size to %dx%d\n", s->width, s->height);

    }



    res = device_try_init(s1, pix_fmt, &s->width, &s->height, &desired_format, &codec_id);

    if (res < 0) {

        v4l2_close(s->fd);

        return res;

    }



    /* If no pixel_format was specified, the codec_id was not known up

     * until now. Set video_codec_id in the context, as codec_id will

     * not be available outside this function

     */

    if (codec_id != AV_CODEC_ID_NONE && s1->video_codec_id == AV_CODEC_ID_NONE)

        s1->video_codec_id = codec_id;



    if ((res = av_image_check_size(s->width, s->height, 0, s1)) < 0)

        return res;



    s->frame_format = desired_format;



    if ((res = v4l2_set_parameters(s1)) < 0)

        return res;



    st->codec->pix_fmt = fmt_v4l2ff(desired_format, codec_id);

    s->frame_size =

        avpicture_get_size(st->codec->pix_fmt, s->width, s->height);



    if ((res = mmap_init(s1)) ||

        (res = mmap_start(s1)) < 0) {

        v4l2_close(s->fd);

        return res;

    }



    s->top_field_first = first_field(s->fd);



    st->codec->codec_type = AVMEDIA_TYPE_VIDEO;

    st->codec->codec_id = codec_id;

    if (codec_id == AV_CODEC_ID_RAWVIDEO)

        st->codec->codec_tag =

            avcodec_pix_fmt_to_codec_tag(st->codec->pix_fmt);

    if (desired_format == V4L2_PIX_FMT_YVU420)

        st->codec->codec_tag = MKTAG('Y', 'V', '1', '2');

    else if (desired_format == V4L2_PIX_FMT_YVU410)

        st->codec->codec_tag = MKTAG('Y', 'V', 'U', '9');

    st->codec->width = s->width;

    st->codec->height = s->height;

    st->codec->bit_rate = s->frame_size * av_q2d(st->avg_frame_rate) * 8;



    return 0;

}

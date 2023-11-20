/* format I/O context */
typedef struct AVFormatContext {
    const AVClass *av_class; /* set by av_alloc_format_context */
    /* can only be iformat or oformat, not both at the same time */
    struct AVInputFormat *iformat;
    struct AVOutputFormat *oformat;
    void *priv_data;
    ByteIOContext pb;
    int nb_streams;
    AVStream *streams[MAX_STREAMS];
    char filename[1024]; /* input or output filename */
    /* stream info */
    int64_t timestamp;
    char title[512];
    char author[512];
    char copyright[512];
    char comment[512];
    char album[512];
    int year;  /* ID3 year, 0 if none */
    int track; /* track number, 0 if none */
    char genre[32]; /* ID3 genre */

    int ctx_flags; /* format specific flags, see AVFMTCTX_xx */
    /* private data for pts handling (do not modify directly) */
    /* This buffer is only needed when packets were already buffered but
       not decoded, for example to get the codec parameters in mpeg
       streams */
    struct AVPacketList *packet_buffer;

    /* decoding: position of the first frame of the component, in
       AV_TIME_BASE fractional seconds. NEVER set this value directly:
       it is deduced from the AVStream values.  */
    int64_t start_time;
    /* decoding: duration of the stream, in AV_TIME_BASE fractional
       seconds. NEVER set this value directly: it is deduced from the
       AVStream values.  */
    int64_t duration;
    /* decoding: total file size. 0 if unknown */
    int64_t file_size;
    /* decoding: total stream bitrate in bit/s, 0 if not
       available. Never set it directly if the file_size and the
       duration are known as ffmpeg can compute it automatically. */
    int bit_rate;

    /* av_read_frame() support */
    AVStream *cur_st;
    const uint8_t *cur_ptr;
    int cur_len;
    AVPacket cur_pkt;

    /* av_seek_frame() support */
    int64_t data_offset; /* offset of the first packet */
    int index_built;

    int mux_rate;
    int packet_size;
    int preload;
    int max_delay;

#define AVFMT_NOOUTPUTLOOP -1
#define AVFMT_INFINITEOUTPUTLOOP 0
    /* number of times to loop output in formats that support it */
    int loop_output;

    int flags;
#define AVFMT_FLAG_GENPTS       0x0001 ///< generate pts if missing even if it requires parsing future frames
#define AVFMT_FLAG_IGNIDX       0x0002 ///< ignore index

    int loop_input;
    /* decoding: size of data to probe; encoding unused */
    unsigned int probesize;
} AVFormatContext;

static int dv_write_header(AVFormatContext *s)
{
    s->priv_data = dv_init_mux(s);
    if (!s->priv_data) {
        av_log(s, AV_LOG_ERROR, "Can't initialize DV format!\n"
                    "Make sure that you supply exactly two streams:\n"
                    "     video: 25fps or 29.97fps, audio: 2ch/48Khz/PCM\n"
                    "     (50Mbps allows an optional second audio stream)\n");
        return -1;
    }
    return 0;
}
DVMuxContext* dv_init_mux(AVFormatContext* s)

{

    DVMuxContext *c;

    AVStream *vst = NULL;

    int i;



    /* we support at most 1 video and 2 audio streams */

    if (s->nb_streams > 3)

        return NULL;



    c = av_mallocz(sizeof(DVMuxContext));

    if (!c)

        return NULL;



    c->n_ast = 0;

    c->ast[0] = c->ast[1] = NULL;



    /* We have to sort out where audio and where video stream is */

    for (i=0; i<s->nb_streams; i++) {

         switch (s->streams[i]->codec->codec_type) {

         case CODEC_TYPE_VIDEO:

               vst = s->streams[i];

               break;

         case CODEC_TYPE_AUDIO:

             c->ast[c->n_ast++] = s->streams[i];

             break;

         default:

               goto bail_out;

         }

    }



    /* Some checks -- DV format is very picky about its incoming streams */

    if (!vst || vst->codec->codec_id != CODEC_ID_DVVIDEO)

        goto bail_out;

    for (i=0; i<c->n_ast; i++) {

        if (c->ast[i] && (c->ast[i]->codec->codec_id != CODEC_ID_PCM_S16LE ||

                          c->ast[i]->codec->sample_rate != 48000 ||

                          c->ast[i]->codec->channels != 2))

            goto bail_out;

    }

    c->sys = dv_codec_profile(vst->codec);

    if (!c->sys)

        goto bail_out;



    if((c->n_ast > 1) && (c->sys->n_difchan < 2)) {

        /* only 1 stereo pair is allowed in 25Mbps mode */

        goto bail_out;

    }



    /* Ok, everything seems to be in working order */

    c->frames = 0;

    c->has_audio = 0;

    c->has_video = 0;

    c->start_time = (time_t)s->timestamp;



    for (i=0; i<c->n_ast; i++) {

        if (c->ast[i] && av_fifo_init(&c->audio_data[i], 100*AVCODEC_MAX_AUDIO_FRAME_SIZE) < 0) {

            while (i>0) {

                i--;

                av_fifo_free(&c->audio_data[i]);

            }

            goto bail_out;

        }

    }



    return c;



bail_out:

    av_free(c);

    return NULL;

}

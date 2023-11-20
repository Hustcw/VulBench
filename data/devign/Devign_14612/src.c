static int film_read_header(AVFormatContext *s,

                            AVFormatParameters *ap)

{

    FilmDemuxContext *film = s->priv_data;

    AVIOContext *pb = s->pb;

    AVStream *st;

    unsigned char scratch[256];

    int i;

    unsigned int data_offset;

    unsigned int audio_frame_counter;



    film->sample_table = NULL;

    film->stereo_buffer = NULL;

    film->stereo_buffer_size = 0;



    /* load the main FILM header */

    if (avio_read(pb, scratch, 16) != 16)

        return AVERROR(EIO);

    data_offset = AV_RB32(&scratch[4]);

    film->version = AV_RB32(&scratch[8]);



    /* load the FDSC chunk */

    if (film->version == 0) {

        /* special case for Lemmings .film files; 20-byte header */

        if (avio_read(pb, scratch, 20) != 20)

            return AVERROR(EIO);

        /* make some assumptions about the audio parameters */

        film->audio_type = CODEC_ID_PCM_S8;

        film->audio_samplerate = 22050;

        film->audio_channels = 1;

        film->audio_bits = 8;

    } else {

        /* normal Saturn .cpk files; 32-byte header */

        if (avio_read(pb, scratch, 32) != 32)

            return AVERROR(EIO);

        film->audio_samplerate = AV_RB16(&scratch[24]);

        film->audio_channels = scratch[21];

        film->audio_bits = scratch[22];

        if (scratch[23] == 2)

            film->audio_type = CODEC_ID_ADPCM_ADX;

        else if (film->audio_bits == 8)

            film->audio_type = CODEC_ID_PCM_S8;

        else if (film->audio_bits == 16)

            film->audio_type = CODEC_ID_PCM_S16BE;

        else

            film->audio_type = CODEC_ID_NONE;

    }



    if (AV_RB32(&scratch[0]) != FDSC_TAG)

        return AVERROR_INVALIDDATA;



    if (AV_RB32(&scratch[8]) == CVID_TAG) {

        film->video_type = CODEC_ID_CINEPAK;

    } else

        film->video_type = CODEC_ID_NONE;



    /* initialize the decoder streams */

    if (film->video_type) {

        st = av_new_stream(s, 0);

        if (!st)

            return AVERROR(ENOMEM);

        film->video_stream_index = st->index;

        st->codec->codec_type = AVMEDIA_TYPE_VIDEO;

        st->codec->codec_id = film->video_type;

        st->codec->codec_tag = 0;  /* no fourcc */

        st->codec->width = AV_RB32(&scratch[16]);

        st->codec->height = AV_RB32(&scratch[12]);

    }



    if (film->audio_type) {

        st = av_new_stream(s, 0);

        if (!st)

            return AVERROR(ENOMEM);

        film->audio_stream_index = st->index;

        st->codec->codec_type = AVMEDIA_TYPE_AUDIO;

        st->codec->codec_id = film->audio_type;

        st->codec->codec_tag = 1;

        st->codec->channels = film->audio_channels;

        st->codec->sample_rate = film->audio_samplerate;



        if (film->audio_type == CODEC_ID_ADPCM_ADX) {

            st->codec->bits_per_coded_sample = 18 * 8 / 32;

            st->codec->block_align = st->codec->channels * 18;

        } else {

            st->codec->bits_per_coded_sample = film->audio_bits;

            st->codec->block_align = st->codec->channels *

                st->codec->bits_per_coded_sample / 8;

        }



        st->codec->bit_rate = st->codec->channels * st->codec->sample_rate *

            st->codec->bits_per_coded_sample;

    }



    /* load the sample table */

    if (avio_read(pb, scratch, 16) != 16)

        return AVERROR(EIO);

    if (AV_RB32(&scratch[0]) != STAB_TAG)

        return AVERROR_INVALIDDATA;

    film->base_clock = AV_RB32(&scratch[8]);

    film->sample_count = AV_RB32(&scratch[12]);

    if(film->sample_count >= UINT_MAX / sizeof(film_sample))

        return -1;

    film->sample_table = av_malloc(film->sample_count * sizeof(film_sample));

    if (!film->sample_table)

        return AVERROR(ENOMEM);



    for(i=0; i<s->nb_streams; i++)

        av_set_pts_info(s->streams[i], 33, 1, film->base_clock);



    audio_frame_counter = 0;

    for (i = 0; i < film->sample_count; i++) {

        /* load the next sample record and transfer it to an internal struct */

        if (avio_read(pb, scratch, 16) != 16) {

            av_free(film->sample_table);

            return AVERROR(EIO);

        }

        film->sample_table[i].sample_offset =

            data_offset + AV_RB32(&scratch[0]);

        film->sample_table[i].sample_size = AV_RB32(&scratch[4]);

        if (AV_RB32(&scratch[8]) == 0xFFFFFFFF) {

            film->sample_table[i].stream = film->audio_stream_index;

            film->sample_table[i].pts = audio_frame_counter;

            film->sample_table[i].pts *= film->base_clock;

            film->sample_table[i].pts /= film->audio_samplerate;



            if (film->audio_type == CODEC_ID_ADPCM_ADX)

                audio_frame_counter += (film->sample_table[i].sample_size * 32 /

                    (18 * film->audio_channels));

            else

                audio_frame_counter += (film->sample_table[i].sample_size /

                    (film->audio_channels * film->audio_bits / 8));

        } else {

            film->sample_table[i].stream = film->video_stream_index;

            film->sample_table[i].pts = AV_RB32(&scratch[8]) & 0x7FFFFFFF;

            film->sample_table[i].keyframe = (scratch[8] & 0x80) ? 0 : 1;

        }

    }



    film->current_sample = 0;



    return 0;

}

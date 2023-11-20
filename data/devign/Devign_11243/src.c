static int decode_idat_chunk(AVCodecContext *avctx, PNGDecContext *s,

                             uint32_t length, AVFrame *p)

{

    int ret;

    size_t byte_depth = s->bit_depth > 8 ? 2 : 1;



    if (!(s->state & PNG_IHDR)) {

        av_log(avctx, AV_LOG_ERROR, "IDAT without IHDR\n");

        return AVERROR_INVALIDDATA;

    }

    if (!(s->state & PNG_IDAT)) {

        /* init image info */

        avctx->width  = s->width;

        avctx->height = s->height;



        s->channels       = ff_png_get_nb_channels(s->color_type);

        s->bits_per_pixel = s->bit_depth * s->channels;

        s->bpp            = (s->bits_per_pixel + 7) >> 3;

        s->row_size       = (s->cur_w * s->bits_per_pixel + 7) >> 3;



        if ((s->bit_depth == 2 || s->bit_depth == 4 || s->bit_depth == 8) &&

                s->color_type == PNG_COLOR_TYPE_RGB) {

            avctx->pix_fmt = AV_PIX_FMT_RGB24;

        } else if ((s->bit_depth == 2 || s->bit_depth == 4 || s->bit_depth == 8) &&

                s->color_type == PNG_COLOR_TYPE_RGB_ALPHA) {

            avctx->pix_fmt = AV_PIX_FMT_RGBA;

        } else if ((s->bit_depth == 2 || s->bit_depth == 4 || s->bit_depth == 8) &&

                s->color_type == PNG_COLOR_TYPE_GRAY) {

            avctx->pix_fmt = AV_PIX_FMT_GRAY8;

        } else if (s->bit_depth == 16 &&

                s->color_type == PNG_COLOR_TYPE_GRAY) {

            avctx->pix_fmt = AV_PIX_FMT_GRAY16BE;

        } else if (s->bit_depth == 16 &&

                s->color_type == PNG_COLOR_TYPE_RGB) {

            avctx->pix_fmt = AV_PIX_FMT_RGB48BE;

        } else if (s->bit_depth == 16 &&

                s->color_type == PNG_COLOR_TYPE_RGB_ALPHA) {

            avctx->pix_fmt = AV_PIX_FMT_RGBA64BE;

        } else if ((s->bits_per_pixel == 1 || s->bits_per_pixel == 2 || s->bits_per_pixel == 4 || s->bits_per_pixel == 8) &&

                s->color_type == PNG_COLOR_TYPE_PALETTE) {

            avctx->pix_fmt = AV_PIX_FMT_PAL8;

        } else if (s->bit_depth == 1 && s->bits_per_pixel == 1 && avctx->codec_id != AV_CODEC_ID_APNG) {

            avctx->pix_fmt = AV_PIX_FMT_MONOBLACK;

        } else if (s->bit_depth == 8 &&

                s->color_type == PNG_COLOR_TYPE_GRAY_ALPHA) {

            avctx->pix_fmt = AV_PIX_FMT_YA8;

        } else if (s->bit_depth == 16 &&

                s->color_type == PNG_COLOR_TYPE_GRAY_ALPHA) {

            avctx->pix_fmt = AV_PIX_FMT_YA16BE;

        } else {

            av_log(avctx, AV_LOG_ERROR, "unsupported bit depth %d "

                    "and color type %d\n",

                    s->bit_depth, s->color_type);

            return AVERROR_INVALIDDATA;

        }



        if (s->has_trns && s->color_type != PNG_COLOR_TYPE_PALETTE) {

            switch (avctx->pix_fmt) {

            case AV_PIX_FMT_RGB24:

                avctx->pix_fmt = AV_PIX_FMT_RGBA;

                break;



            case AV_PIX_FMT_RGB48BE:

                avctx->pix_fmt = AV_PIX_FMT_RGBA64BE;

                break;



            case AV_PIX_FMT_GRAY8:

                avctx->pix_fmt = AV_PIX_FMT_YA8;

                break;



            case AV_PIX_FMT_GRAY16BE:

                avctx->pix_fmt = AV_PIX_FMT_YA16BE;

                break;



            default:

                avpriv_request_sample(avctx, "bit depth %d "

                        "and color type %d with TRNS",

                        s->bit_depth, s->color_type);

                return AVERROR_INVALIDDATA;

            }



            s->bpp += byte_depth;

        }



        if ((ret = ff_thread_get_buffer(avctx, &s->picture, AV_GET_BUFFER_FLAG_REF)) < 0)

            return ret;

        if (avctx->codec_id == AV_CODEC_ID_APNG && s->last_dispose_op != APNG_DISPOSE_OP_PREVIOUS) {

            ff_thread_release_buffer(avctx, &s->previous_picture);

            if ((ret = ff_thread_get_buffer(avctx, &s->previous_picture, AV_GET_BUFFER_FLAG_REF)) < 0)

                return ret;

        }

        ff_thread_finish_setup(avctx);



        p->pict_type        = AV_PICTURE_TYPE_I;

        p->key_frame        = 1;

        p->interlaced_frame = !!s->interlace_type;



        /* compute the compressed row size */

        if (!s->interlace_type) {

            s->crow_size = s->row_size + 1;

        } else {

            s->pass          = 0;

            s->pass_row_size = ff_png_pass_row_size(s->pass,

                    s->bits_per_pixel,

                    s->cur_w);

            s->crow_size = s->pass_row_size + 1;

        }

        ff_dlog(avctx, "row_size=%d crow_size =%d\n",

                s->row_size, s->crow_size);

        s->image_buf      = p->data[0];

        s->image_linesize = p->linesize[0];

        /* copy the palette if needed */

        if (avctx->pix_fmt == AV_PIX_FMT_PAL8)

            memcpy(p->data[1], s->palette, 256 * sizeof(uint32_t));

        /* empty row is used if differencing to the first row */

        av_fast_padded_mallocz(&s->last_row, &s->last_row_size, s->row_size);

        if (!s->last_row)

            return AVERROR_INVALIDDATA;

        if (s->interlace_type ||

                s->color_type == PNG_COLOR_TYPE_RGB_ALPHA) {

            av_fast_padded_malloc(&s->tmp_row, &s->tmp_row_size, s->row_size);

            if (!s->tmp_row)

                return AVERROR_INVALIDDATA;

        }

        /* compressed row */

        av_fast_padded_malloc(&s->buffer, &s->buffer_size, s->row_size + 16);

        if (!s->buffer)

            return AVERROR(ENOMEM);



        /* we want crow_buf+1 to be 16-byte aligned */

        s->crow_buf          = s->buffer + 15;

        s->zstream.avail_out = s->crow_size;

        s->zstream.next_out  = s->crow_buf;

    }



    s->state |= PNG_IDAT;



    /* set image to non-transparent bpp while decompressing */

    if (s->has_trns && s->color_type != PNG_COLOR_TYPE_PALETTE)

        s->bpp -= byte_depth;



    ret = png_decode_idat(s, length);



    if (s->has_trns && s->color_type != PNG_COLOR_TYPE_PALETTE)

        s->bpp += byte_depth;



    if (ret < 0)

        return ret;



    bytestream2_skip(&s->gb, 4); /* crc */



    return 0;

}

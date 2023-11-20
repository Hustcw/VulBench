static int pcx_decode_frame(AVCodecContext *avctx, void *data, int *got_frame,

                            AVPacket *avpkt)

{

    const uint8_t *buf = avpkt->data;

    int buf_size       = avpkt->size;

    AVFrame *const p   = data;

    int compressed, xmin, ymin, xmax, ymax;

    unsigned int w, h, bits_per_pixel, bytes_per_line, nplanes, stride, y, x,

                 bytes_per_scanline;

    uint8_t *ptr;

    const uint8_t *buf_end = buf + buf_size;

    const uint8_t *bufstart = buf;

    uint8_t *scanline;

    int ret = -1;



    if (buf[0] != 0x0a || buf[1] > 5) {

        av_log(avctx, AV_LOG_ERROR, "this is not PCX encoded data\n");

        return AVERROR_INVALIDDATA;

    }



    compressed = buf[2];

    xmin       = AV_RL16(buf + 4);

    ymin       = AV_RL16(buf + 6);

    xmax       = AV_RL16(buf + 8);

    ymax       = AV_RL16(buf + 10);



    if (xmax < xmin || ymax < ymin) {

        av_log(avctx, AV_LOG_ERROR, "invalid image dimensions\n");

        return AVERROR_INVALIDDATA;

    }



    w = xmax - xmin + 1;

    h = ymax - ymin + 1;



    bits_per_pixel     = buf[3];

    bytes_per_line     = AV_RL16(buf + 66);

    nplanes            = buf[65];

    bytes_per_scanline = nplanes * bytes_per_line;



    if (bytes_per_scanline < (w * bits_per_pixel * nplanes + 7) / 8 ||

        (!compressed && bytes_per_scanline > buf_size / h)) {

        av_log(avctx, AV_LOG_ERROR, "PCX data is corrupted\n");

        return AVERROR_INVALIDDATA;

    }



    switch ((nplanes << 8) + bits_per_pixel) {

    case 0x0308:

        avctx->pix_fmt = AV_PIX_FMT_RGB24;

        break;

    case 0x0108:

    case 0x0104:

    case 0x0102:

    case 0x0101:

    case 0x0401:

    case 0x0301:

    case 0x0201:

        avctx->pix_fmt = AV_PIX_FMT_PAL8;

        break;

    default:

        av_log(avctx, AV_LOG_ERROR, "invalid PCX file\n");

        return AVERROR_INVALIDDATA;

    }



    buf += 128;



    if ((ret = ff_set_dimensions(avctx, w, h)) < 0)

        return ret;



    if ((ret = ff_get_buffer(avctx, p, 0)) < 0) {

        av_log(avctx, AV_LOG_ERROR, "get_buffer() failed\n");

        return ret;

    }



    p->pict_type = AV_PICTURE_TYPE_I;



    ptr    = p->data[0];

    stride = p->linesize[0];



    scanline = av_malloc(bytes_per_scanline);

    if (!scanline)

        return AVERROR(ENOMEM);



    if (nplanes == 3 && bits_per_pixel == 8) {

        for (y = 0; y < h; y++) {

            buf = pcx_rle_decode(buf, buf_end,

                                 scanline, bytes_per_scanline, compressed);



            for (x = 0; x < w; x++) {

                ptr[3 * x]     = scanline[x];

                ptr[3 * x + 1] = scanline[x + bytes_per_line];

                ptr[3 * x + 2] = scanline[x + (bytes_per_line << 1)];

            }



            ptr += stride;

        }

    } else if (nplanes == 1 && bits_per_pixel == 8) {

        const uint8_t *palstart = bufstart + buf_size - 769;



        if (buf_size < 769) {

            av_log(avctx, AV_LOG_ERROR, "File is too short\n");

            ret = avctx->err_recognition & AV_EF_EXPLODE ?

                  AVERROR_INVALIDDATA : buf_size;

            goto end;

        }



        for (y = 0; y < h; y++, ptr += stride) {

            buf = pcx_rle_decode(buf, buf_end,

                                 scanline, bytes_per_scanline, compressed);

            memcpy(ptr, scanline, w);

        }



        if (buf != palstart) {

            av_log(avctx, AV_LOG_WARNING, "image data possibly corrupted\n");

            buf = palstart;

        }

        if (*buf++ != 12) {

            av_log(avctx, AV_LOG_ERROR, "expected palette after image data\n");

            ret = avctx->err_recognition & AV_EF_EXPLODE ?

                  AVERROR_INVALIDDATA : buf_size;

            goto end;

        }

    } else if (nplanes == 1) {   /* all packed formats, max. 16 colors */

        GetBitContext s;



        for (y = 0; y < h; y++) {

            init_get_bits(&s, scanline, bytes_per_scanline << 3);



            buf = pcx_rle_decode(buf, buf_end,

                                 scanline, bytes_per_scanline, compressed);



            for (x = 0; x < w; x++)

                ptr[x] = get_bits(&s, bits_per_pixel);

            ptr += stride;

        }

    } else {    /* planar, 4, 8 or 16 colors */

        int i;



        for (y = 0; y < h; y++) {

            buf = pcx_rle_decode(buf, buf_end,

                                 scanline, bytes_per_scanline, compressed);



            for (x = 0; x < w; x++) {

                int m = 0x80 >> (x & 7), v = 0;

                for (i = nplanes - 1; i >= 0; i--) {

                    v <<= 1;

                    v  += !!(scanline[i * bytes_per_line + (x >> 3)] & m);

                }

                ptr[x] = v;

            }

            ptr += stride;

        }

    }



    if (nplanes == 1 && bits_per_pixel == 8) {

        pcx_palette(&buf, (uint32_t *)p->data[1], 256);

    } else if (bits_per_pixel < 8) {

        const uint8_t *palette = bufstart + 16;

        pcx_palette(&palette, (uint32_t *)p->data[1], 16);

    }



    *got_frame = 1;



    ret = buf - bufstart;

end:

    av_free(scanline);

    return ret;

}

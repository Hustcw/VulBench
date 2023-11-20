static void decode_plane(FFV1Context *s, uint8_t *src,

                         int w, int h, int stride, int plane_index,

                         int pixel_stride)

{

    int x, y;

    int16_t *sample[2];

    sample[0] = s->sample_buffer + 3;

    sample[1] = s->sample_buffer + w + 6 + 3;



    s->run_index = 0;



    memset(s->sample_buffer, 0, 2 * (w + 6) * sizeof(*s->sample_buffer));



    for (y = 0; y < h; y++) {

        int16_t *temp = sample[0]; // FIXME: try a normal buffer



        sample[0] = sample[1];

        sample[1] = temp;



        sample[1][-1] = sample[0][0];

        sample[0][w]  = sample[0][w - 1];



// { START_TIMER

        if (s->avctx->bits_per_raw_sample <= 8) {

            decode_line(s, w, sample, plane_index, 8);

            for (x = 0; x < w; x++)

                src[x*pixel_stride + stride * y] = sample[1][x];

        } else {

            decode_line(s, w, sample, plane_index, s->avctx->bits_per_raw_sample);

            if (s->packed_at_lsb) {

                for (x = 0; x < w; x++) {

                    ((uint16_t*)(src + stride*y))[x*pixel_stride] = sample[1][x];

                }

            } else {

                for (x = 0; x < w; x++) {

                    ((uint16_t*)(src + stride*y))[x*pixel_stride] = sample[1][x] << (16 - s->avctx->bits_per_raw_sample) | ((uint16_t **)sample)[1][x] >> (2 * s->avctx->bits_per_raw_sample - 16);

                }

            }

        }

// STOP_TIMER("decode-line") }

    }

}

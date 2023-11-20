static void wmv2_add_block(Wmv2Context *w, DCTELEM *block1, uint8_t *dst, int stride, int n){

    MpegEncContext * const s= &w->s;



    switch(w->abt_type_table[n]){

    case 0:

        if (s->block_last_index[n] >= 0) {

            s->dsp.idct_add (dst, stride, block1);

        }

        break;

    case 1:

        simple_idct84_add(dst           , stride, block1);

        simple_idct84_add(dst + 4*stride, stride, w->abt_block2[n]);

        memset(w->abt_block2[n], 0, 64*sizeof(DCTELEM));

        break;

    case 2:

        simple_idct48_add(dst           , stride, block1);

        simple_idct48_add(dst + 4       , stride, w->abt_block2[n]);

        memset(w->abt_block2[n], 0, 64*sizeof(DCTELEM));

        break;

    default:

        av_log(s->avctx, AV_LOG_ERROR, "internal error in WMV2 abt\n");

    }

}

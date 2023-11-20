void ff_mpeg4_encode_picture_header(MpegEncContext *s, int picture_number)

{

    int time_incr;

    int time_div, time_mod;



    if (s->pict_type == AV_PICTURE_TYPE_I) {

        if (!(s->avctx->flags & AV_CODEC_FLAG_GLOBAL_HEADER)) {

            if (s->strict_std_compliance < FF_COMPLIANCE_VERY_STRICT)  // HACK, the reference sw is buggy

                mpeg4_encode_visual_object_header(s);

            if (s->strict_std_compliance < FF_COMPLIANCE_VERY_STRICT || picture_number == 0)  // HACK, the reference sw is buggy

                mpeg4_encode_vol_header(s, 0, 0);

        }

        if (!(s->workaround_bugs & FF_BUG_MS))

            mpeg4_encode_gop_header(s);

    }



    s->partitioned_frame = s->data_partitioning && s->pict_type != AV_PICTURE_TYPE_B;



    put_bits(&s->pb, 16, 0);                /* vop header */

    put_bits(&s->pb, 16, VOP_STARTCODE);    /* vop header */

    put_bits(&s->pb, 2, s->pict_type - 1);  /* pict type: I = 0 , P = 1 */



    time_div  = FFUDIV(s->time, s->avctx->time_base.den);

    time_mod  = FFUMOD(s->time, s->avctx->time_base.den);

    time_incr = time_div - s->last_time_base;

    av_assert0(time_incr >= 0);

    while (time_incr--)

        put_bits(&s->pb, 1, 1);



    put_bits(&s->pb, 1, 0);



    put_bits(&s->pb, 1, 1);                             /* marker */

    put_bits(&s->pb, s->time_increment_bits, time_mod); /* time increment */

    put_bits(&s->pb, 1, 1);                             /* marker */

    put_bits(&s->pb, 1, 1);                             /* vop coded */

    if (s->pict_type == AV_PICTURE_TYPE_P) {

        put_bits(&s->pb, 1, s->no_rounding);    /* rounding type */

    }

    put_bits(&s->pb, 3, 0);     /* intra dc VLC threshold */

    if (!s->progressive_sequence) {

        put_bits(&s->pb, 1, s->current_picture_ptr->f->top_field_first);

        put_bits(&s->pb, 1, s->alternate_scan);

    }

    // FIXME sprite stuff



    put_bits(&s->pb, 5, s->qscale);



    if (s->pict_type != AV_PICTURE_TYPE_I)

        put_bits(&s->pb, 3, s->f_code);  /* fcode_for */

    if (s->pict_type == AV_PICTURE_TYPE_B)

        put_bits(&s->pb, 3, s->b_code);  /* fcode_back */

}

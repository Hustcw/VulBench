av_cold int swri_rematrix_init(SwrContext *s){

    int i, j;

    int nb_in  = av_get_channel_layout_nb_channels(s->in_ch_layout);

    int nb_out = av_get_channel_layout_nb_channels(s->out_ch_layout);



    s->mix_any_f = NULL;



    if (!s->rematrix_custom) {

        int r = auto_matrix(s);

        if (r)

            return r;

    }

    if (s->midbuf.fmt == AV_SAMPLE_FMT_S16P){

        s->native_matrix = av_calloc(nb_in * nb_out, sizeof(int));

        s->native_one    = av_mallocz(sizeof(int));

        if (!s->native_matrix || !s->native_one)

            return AVERROR(ENOMEM);

        for (i = 0; i < nb_out; i++) {

            double rem = 0;



            for (j = 0; j < nb_in; j++) {

                double target = s->matrix[i][j] * 32768 + rem;

                ((int*)s->native_matrix)[i * nb_in + j] = lrintf(target);

                rem += target - ((int*)s->native_matrix)[i * nb_in + j];

            }

        }

        *((int*)s->native_one) = 32768;

        s->mix_1_1_f = (mix_1_1_func_type*)copy_s16;

        s->mix_2_1_f = (mix_2_1_func_type*)sum2_s16;

        s->mix_any_f = (mix_any_func_type*)get_mix_any_func_s16(s);

    }else if(s->midbuf.fmt == AV_SAMPLE_FMT_FLTP){

        s->native_matrix = av_calloc(nb_in * nb_out, sizeof(float));

        s->native_one    = av_mallocz(sizeof(float));

        if (!s->native_matrix || !s->native_one)

            return AVERROR(ENOMEM);

        for (i = 0; i < nb_out; i++)

            for (j = 0; j < nb_in; j++)

                ((float*)s->native_matrix)[i * nb_in + j] = s->matrix[i][j];

        *((float*)s->native_one) = 1.0;

        s->mix_1_1_f = (mix_1_1_func_type*)copy_float;

        s->mix_2_1_f = (mix_2_1_func_type*)sum2_float;

        s->mix_any_f = (mix_any_func_type*)get_mix_any_func_float(s);

    }else if(s->midbuf.fmt == AV_SAMPLE_FMT_DBLP){

        s->native_matrix = av_calloc(nb_in * nb_out, sizeof(double));

        s->native_one    = av_mallocz(sizeof(double));

        if (!s->native_matrix || !s->native_one)

            return AVERROR(ENOMEM);

        for (i = 0; i < nb_out; i++)

            for (j = 0; j < nb_in; j++)

                ((double*)s->native_matrix)[i * nb_in + j] = s->matrix[i][j];

        *((double*)s->native_one) = 1.0;

        s->mix_1_1_f = (mix_1_1_func_type*)copy_double;

        s->mix_2_1_f = (mix_2_1_func_type*)sum2_double;

        s->mix_any_f = (mix_any_func_type*)get_mix_any_func_double(s);

    }else if(s->midbuf.fmt == AV_SAMPLE_FMT_S32P){

        // Only for dithering currently

//         s->native_matrix = av_calloc(nb_in * nb_out, sizeof(double));

        s->native_one    = av_mallocz(sizeof(int));

        if (!s->native_one)

            return AVERROR(ENOMEM);

//         for (i = 0; i < nb_out; i++)

//             for (j = 0; j < nb_in; j++)

//                 ((double*)s->native_matrix)[i * nb_in + j] = s->matrix[i][j];

        *((int*)s->native_one) = 32768;

        s->mix_1_1_f = (mix_1_1_func_type*)copy_s32;

        s->mix_2_1_f = (mix_2_1_func_type*)sum2_s32;

        s->mix_any_f = (mix_any_func_type*)get_mix_any_func_s32(s);

    }else

        av_assert0(0);

    //FIXME quantize for integeres

    for (i = 0; i < SWR_CH_MAX; i++) {

        int ch_in=0;

        for (j = 0; j < SWR_CH_MAX; j++) {

            s->matrix32[i][j]= lrintf(s->matrix[i][j] * 32768);

            if(s->matrix[i][j])

                s->matrix_ch[i][++ch_in]= j;

        }

        s->matrix_ch[i][0]= ch_in;

    }



    if(HAVE_YASM && HAVE_MMX)

        return swri_rematrix_init_x86(s);



    return 0;

}

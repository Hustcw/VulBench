av_cold static int auto_matrix(SwrContext *s)

{

    int i, j, out_i;

    double matrix[NUM_NAMED_CHANNELS][NUM_NAMED_CHANNELS]={{0}};

    int64_t unaccounted, in_ch_layout, out_ch_layout;

    double maxcoef=0;

    char buf[128];

    const int matrix_encoding = s->matrix_encoding;

    float maxval;



    in_ch_layout = clean_layout(s, s->in_ch_layout);

    out_ch_layout = clean_layout(s, s->out_ch_layout);



    if(   out_ch_layout == AV_CH_LAYOUT_STEREO_DOWNMIX

       && (in_ch_layout & AV_CH_LAYOUT_STEREO_DOWNMIX) == 0

    )

        out_ch_layout = AV_CH_LAYOUT_STEREO;



    if(    in_ch_layout == AV_CH_LAYOUT_STEREO_DOWNMIX

       && (out_ch_layout & AV_CH_LAYOUT_STEREO_DOWNMIX) == 0

    )

        in_ch_layout = AV_CH_LAYOUT_STEREO;



    if(!sane_layout(in_ch_layout)){

        av_get_channel_layout_string(buf, sizeof(buf), -1, s->in_ch_layout);

        av_log(s, AV_LOG_ERROR, "Input channel layout '%s' is not supported\n", buf);

        return AVERROR(EINVAL);

    }



    if(!sane_layout(out_ch_layout)){

        av_get_channel_layout_string(buf, sizeof(buf), -1, s->out_ch_layout);

        av_log(s, AV_LOG_ERROR, "Output channel layout '%s' is not supported\n", buf);

        return AVERROR(EINVAL);

    }



    memset(s->matrix, 0, sizeof(s->matrix));

    for(i=0; i<FF_ARRAY_ELEMS(matrix); i++){

        if(in_ch_layout & out_ch_layout & (1ULL<<i))

            matrix[i][i]= 1.0;

    }



    unaccounted= in_ch_layout & ~out_ch_layout;



//FIXME implement dolby surround

//FIXME implement full ac3





    if(unaccounted & AV_CH_FRONT_CENTER){

        if((out_ch_layout & AV_CH_LAYOUT_STEREO) == AV_CH_LAYOUT_STEREO){

            if(in_ch_layout & AV_CH_LAYOUT_STEREO) {

                matrix[ FRONT_LEFT][FRONT_CENTER]+= s->clev;

                matrix[FRONT_RIGHT][FRONT_CENTER]+= s->clev;

            } else {

                matrix[ FRONT_LEFT][FRONT_CENTER]+= M_SQRT1_2;

                matrix[FRONT_RIGHT][FRONT_CENTER]+= M_SQRT1_2;

            }

        }else

            av_assert0(0);

    }

    if(unaccounted & AV_CH_LAYOUT_STEREO){

        if(out_ch_layout & AV_CH_FRONT_CENTER){

            matrix[FRONT_CENTER][ FRONT_LEFT]+= M_SQRT1_2;

            matrix[FRONT_CENTER][FRONT_RIGHT]+= M_SQRT1_2;

            if(in_ch_layout & AV_CH_FRONT_CENTER)

                matrix[FRONT_CENTER][ FRONT_CENTER] = s->clev*sqrt(2);

        }else

            av_assert0(0);

    }



    if(unaccounted & AV_CH_BACK_CENTER){

        if(out_ch_layout & AV_CH_BACK_LEFT){

            matrix[ BACK_LEFT][BACK_CENTER]+= M_SQRT1_2;

            matrix[BACK_RIGHT][BACK_CENTER]+= M_SQRT1_2;

        }else if(out_ch_layout & AV_CH_SIDE_LEFT){

            matrix[ SIDE_LEFT][BACK_CENTER]+= M_SQRT1_2;

            matrix[SIDE_RIGHT][BACK_CENTER]+= M_SQRT1_2;

        }else if(out_ch_layout & AV_CH_FRONT_LEFT){

            if (matrix_encoding == AV_MATRIX_ENCODING_DOLBY ||

                matrix_encoding == AV_MATRIX_ENCODING_DPLII) {

                if (unaccounted & (AV_CH_BACK_LEFT | AV_CH_SIDE_LEFT)) {

                    matrix[FRONT_LEFT ][BACK_CENTER] -= s->slev * M_SQRT1_2;

                    matrix[FRONT_RIGHT][BACK_CENTER] += s->slev * M_SQRT1_2;

                } else {

                    matrix[FRONT_LEFT ][BACK_CENTER] -= s->slev;

                    matrix[FRONT_RIGHT][BACK_CENTER] += s->slev;

                }

            } else {

                matrix[ FRONT_LEFT][BACK_CENTER]+= s->slev*M_SQRT1_2;

                matrix[FRONT_RIGHT][BACK_CENTER]+= s->slev*M_SQRT1_2;

            }

        }else if(out_ch_layout & AV_CH_FRONT_CENTER){

            matrix[ FRONT_CENTER][BACK_CENTER]+= s->slev*M_SQRT1_2;

        }else

            av_assert0(0);

    }

    if(unaccounted & AV_CH_BACK_LEFT){

        if(out_ch_layout & AV_CH_BACK_CENTER){

            matrix[BACK_CENTER][ BACK_LEFT]+= M_SQRT1_2;

            matrix[BACK_CENTER][BACK_RIGHT]+= M_SQRT1_2;

        }else if(out_ch_layout & AV_CH_SIDE_LEFT){

            if(in_ch_layout & AV_CH_SIDE_LEFT){

                matrix[ SIDE_LEFT][ BACK_LEFT]+= M_SQRT1_2;

                matrix[SIDE_RIGHT][BACK_RIGHT]+= M_SQRT1_2;

            }else{

            matrix[ SIDE_LEFT][ BACK_LEFT]+= 1.0;

            matrix[SIDE_RIGHT][BACK_RIGHT]+= 1.0;

            }

        }else if(out_ch_layout & AV_CH_FRONT_LEFT){

            if (matrix_encoding == AV_MATRIX_ENCODING_DOLBY) {

                matrix[FRONT_LEFT ][BACK_LEFT ] -= s->slev * M_SQRT1_2;

                matrix[FRONT_LEFT ][BACK_RIGHT] -= s->slev * M_SQRT1_2;

                matrix[FRONT_RIGHT][BACK_LEFT ] += s->slev * M_SQRT1_2;

                matrix[FRONT_RIGHT][BACK_RIGHT] += s->slev * M_SQRT1_2;

            } else if (matrix_encoding == AV_MATRIX_ENCODING_DPLII) {

                matrix[FRONT_LEFT ][BACK_LEFT ] -= s->slev * SQRT3_2;

                matrix[FRONT_LEFT ][BACK_RIGHT] -= s->slev * M_SQRT1_2;

                matrix[FRONT_RIGHT][BACK_LEFT ] += s->slev * M_SQRT1_2;

                matrix[FRONT_RIGHT][BACK_RIGHT] += s->slev * SQRT3_2;

            } else {

                matrix[ FRONT_LEFT][ BACK_LEFT] += s->slev;

                matrix[FRONT_RIGHT][BACK_RIGHT] += s->slev;

            }

        }else if(out_ch_layout & AV_CH_FRONT_CENTER){

            matrix[ FRONT_CENTER][BACK_LEFT ]+= s->slev*M_SQRT1_2;

            matrix[ FRONT_CENTER][BACK_RIGHT]+= s->slev*M_SQRT1_2;

        }else

            av_assert0(0);

    }



    if(unaccounted & AV_CH_SIDE_LEFT){

        if(out_ch_layout & AV_CH_BACK_LEFT){

            /* if back channels do not exist in the input, just copy side

               channels to back channels, otherwise mix side into back */

            if (in_ch_layout & AV_CH_BACK_LEFT) {

                matrix[BACK_LEFT ][SIDE_LEFT ] += M_SQRT1_2;

                matrix[BACK_RIGHT][SIDE_RIGHT] += M_SQRT1_2;

            } else {

                matrix[BACK_LEFT ][SIDE_LEFT ] += 1.0;

                matrix[BACK_RIGHT][SIDE_RIGHT] += 1.0;

            }

        }else if(out_ch_layout & AV_CH_BACK_CENTER){

            matrix[BACK_CENTER][ SIDE_LEFT]+= M_SQRT1_2;

            matrix[BACK_CENTER][SIDE_RIGHT]+= M_SQRT1_2;

        }else if(out_ch_layout & AV_CH_FRONT_LEFT){

            if (matrix_encoding == AV_MATRIX_ENCODING_DOLBY) {

                matrix[FRONT_LEFT ][SIDE_LEFT ] -= s->slev * M_SQRT1_2;

                matrix[FRONT_LEFT ][SIDE_RIGHT] -= s->slev * M_SQRT1_2;

                matrix[FRONT_RIGHT][SIDE_LEFT ] += s->slev * M_SQRT1_2;

                matrix[FRONT_RIGHT][SIDE_RIGHT] += s->slev * M_SQRT1_2;

            } else if (matrix_encoding == AV_MATRIX_ENCODING_DPLII) {

                matrix[FRONT_LEFT ][SIDE_LEFT ] -= s->slev * SQRT3_2;

                matrix[FRONT_LEFT ][SIDE_RIGHT] -= s->slev * M_SQRT1_2;

                matrix[FRONT_RIGHT][SIDE_LEFT ] += s->slev * M_SQRT1_2;

                matrix[FRONT_RIGHT][SIDE_RIGHT] += s->slev * SQRT3_2;

            } else {

                matrix[ FRONT_LEFT][ SIDE_LEFT] += s->slev;

                matrix[FRONT_RIGHT][SIDE_RIGHT] += s->slev;

            }

        }else if(out_ch_layout & AV_CH_FRONT_CENTER){

            matrix[ FRONT_CENTER][SIDE_LEFT ]+= s->slev*M_SQRT1_2;

            matrix[ FRONT_CENTER][SIDE_RIGHT]+= s->slev*M_SQRT1_2;

        }else

            av_assert0(0);

    }



    if(unaccounted & AV_CH_FRONT_LEFT_OF_CENTER){

        if(out_ch_layout & AV_CH_FRONT_LEFT){

            matrix[ FRONT_LEFT][ FRONT_LEFT_OF_CENTER]+= 1.0;

            matrix[FRONT_RIGHT][FRONT_RIGHT_OF_CENTER]+= 1.0;

        }else if(out_ch_layout & AV_CH_FRONT_CENTER){

            matrix[ FRONT_CENTER][ FRONT_LEFT_OF_CENTER]+= M_SQRT1_2;

            matrix[ FRONT_CENTER][FRONT_RIGHT_OF_CENTER]+= M_SQRT1_2;

        }else

            av_assert0(0);

    }

    /* mix LFE into front left/right or center */

    if (unaccounted & AV_CH_LOW_FREQUENCY) {

        if (out_ch_layout & AV_CH_FRONT_CENTER) {

            matrix[FRONT_CENTER][LOW_FREQUENCY] += s->lfe_mix_level;

        } else if (out_ch_layout & AV_CH_FRONT_LEFT) {

            matrix[FRONT_LEFT ][LOW_FREQUENCY] += s->lfe_mix_level * M_SQRT1_2;

            matrix[FRONT_RIGHT][LOW_FREQUENCY] += s->lfe_mix_level * M_SQRT1_2;

        } else

            av_assert0(0);

    }



    for(out_i=i=0; i<64; i++){

        double sum=0;

        int in_i=0;

        for(j=0; j<64; j++){

            if (i < FF_ARRAY_ELEMS(matrix) && j < FF_ARRAY_ELEMS(matrix[0]))

                s->matrix[out_i][in_i]= matrix[i][j];

            else

                s->matrix[out_i][in_i]= i == j && (in_ch_layout & out_ch_layout & (1ULL<<i));

            sum += fabs(s->matrix[out_i][in_i]);

            if(in_ch_layout & (1ULL<<j))

                in_i++;

        }

        maxcoef= FFMAX(maxcoef, sum);

        if(out_ch_layout & (1ULL<<i))

            out_i++;

    }

    if(s->rematrix_volume  < 0)

        maxcoef = -s->rematrix_volume;



    if (s->rematrix_maxval > 0) {

        maxval = s->rematrix_maxval;

    } else if (   av_get_packed_sample_fmt(s->out_sample_fmt) < AV_SAMPLE_FMT_FLT

               || av_get_packed_sample_fmt(s->int_sample_fmt) < AV_SAMPLE_FMT_FLT) {

        maxval = 1.0;

    } else

        maxval = INT_MAX;



    if(maxcoef > maxval || s->rematrix_volume  < 0){

        maxcoef /= maxval;

        for(i=0; i<SWR_CH_MAX; i++)

            for(j=0; j<SWR_CH_MAX; j++){

                s->matrix[i][j] /= maxcoef;

            }

    }



    if(s->rematrix_volume > 0){

        for(i=0; i<SWR_CH_MAX; i++)

            for(j=0; j<SWR_CH_MAX; j++){

                s->matrix[i][j] *= s->rematrix_volume;

            }

    }



    for(i=0; i<av_get_channel_layout_nb_channels(out_ch_layout); i++){

        for(j=0; j<av_get_channel_layout_nb_channels(in_ch_layout); j++){

            av_log(NULL, AV_LOG_DEBUG, "%f ", s->matrix[i][j]);

        }

        av_log(NULL, AV_LOG_DEBUG, "\n");

    }

    return 0;

}

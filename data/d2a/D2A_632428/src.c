static int svq3_decode_mb(SVQ3Context *svq3, unsigned int mb_type)
{
    H264Context *h = &svq3->h;
    int i, j, k, m, dir, mode;
    int cbp = 0;
    uint32_t vlc;
    int8_t *top, *left;
    MpegEncContext *const s = (MpegEncContext *)h;
    const int mb_xy         = h->mb_xy;
    const int b_xy          = 4 * s->mb_x + 4 * s->mb_y * h->b_stride;

    h->top_samples_available      = (s->mb_y == 0) ? 0x33FF : 0xFFFF;
    h->left_samples_available     = (s->mb_x == 0) ? 0x5F5F : 0xFFFF;
    h->topright_samples_available = 0xFFFF;

    if (mb_type == 0) {           /* SKIP */
        if (s->pict_type == AV_PICTURE_TYPE_P ||
            s->next_picture.f.mb_type[mb_xy] == -1) {
            svq3_mc_dir_part(s, 16 * s->mb_x, 16 * s->mb_y, 16, 16,
                             0, 0, 0, 0, 0, 0);

            if (s->pict_type == AV_PICTURE_TYPE_B)
                svq3_mc_dir_part(s, 16 * s->mb_x, 16 * s->mb_y, 16, 16,
                                 0, 0, 0, 0, 1, 1);

            mb_type = MB_TYPE_SKIP;
        } else {
            mb_type = FFMIN(s->next_picture.f.mb_type[mb_xy], 6);
            if (svq3_mc_dir(h, mb_type, PREDICT_MODE, 0, 0) < 0)
                return -1;
            if (svq3_mc_dir(h, mb_type, PREDICT_MODE, 1, 1) < 0)
                return -1;

            mb_type = MB_TYPE_16x16;
        }
    } else if (mb_type < 8) {     /* INTER */
        if (svq3->thirdpel_flag && svq3->halfpel_flag == !get_bits1(&s->gb))
            mode = THIRDPEL_MODE;
        else if (svq3->halfpel_flag &&
                 svq3->thirdpel_flag == !get_bits1(&s->gb))
            mode = HALFPEL_MODE;
        else
            mode = FULLPEL_MODE;

        /* fill caches */
        /* note ref_cache should contain here:
         *  ????????
         *  ???11111
         *  N??11111
         *  N??11111
         *  N??11111
         */

        for (m = 0; m < 2; m++) {
            if (s->mb_x > 0 && h->intra4x4_pred_mode[h->mb2br_xy[mb_xy - 1] + 6] != -1) {
                for (i = 0; i < 4; i++)
                    AV_COPY32(h->mv_cache[m][scan8[0] - 1 + i * 8],
                              s->current_picture.f.motion_val[m][b_xy - 1 + i * h->b_stride]);
            } else {
                for (i = 0; i < 4; i++)
                    AV_ZERO32(h->mv_cache[m][scan8[0] - 1 + i * 8]);
            }
            if (s->mb_y > 0) {
                memcpy(h->mv_cache[m][scan8[0] - 1 * 8],
                       s->current_picture.f.motion_val[m][b_xy - h->b_stride],
                       4 * 2 * sizeof(int16_t));
                memset(&h->ref_cache[m][scan8[0] - 1 * 8],
                       (h->intra4x4_pred_mode[h->mb2br_xy[mb_xy - s->mb_stride]] == -1) ? PART_NOT_AVAILABLE : 1, 4);

                if (s->mb_x < s->mb_width - 1) {
                    AV_COPY32(h->mv_cache[m][scan8[0] + 4 - 1 * 8],
                              s->current_picture.f.motion_val[m][b_xy - h->b_stride + 4]);
                    h->ref_cache[m][scan8[0] + 4 - 1 * 8] =
                        (h->intra4x4_pred_mode[h->mb2br_xy[mb_xy - s->mb_stride + 1] + 6] == -1 ||
                         h->intra4x4_pred_mode[h->mb2br_xy[mb_xy - s->mb_stride]] == -1) ? PART_NOT_AVAILABLE : 1;
                } else
                    h->ref_cache[m][scan8[0] + 4 - 1 * 8] = PART_NOT_AVAILABLE;
                if (s->mb_x > 0) {
                    AV_COPY32(h->mv_cache[m][scan8[0] - 1 - 1 * 8],
                              s->current_picture.f.motion_val[m][b_xy - h->b_stride - 1]);
                    h->ref_cache[m][scan8[0] - 1 - 1 * 8] =
                        (h->intra4x4_pred_mode[h->mb2br_xy[mb_xy - s->mb_stride - 1] + 3] == -1) ? PART_NOT_AVAILABLE : 1;
                } else
                    h->ref_cache[m][scan8[0] - 1 - 1 * 8] = PART_NOT_AVAILABLE;
            } else
                memset(&h->ref_cache[m][scan8[0] - 1 * 8 - 1],
                       PART_NOT_AVAILABLE, 8);

            if (s->pict_type != AV_PICTURE_TYPE_B)
                break;
        }

        /* decode motion vector(s) and form prediction(s) */
        if (s->pict_type == AV_PICTURE_TYPE_P) {
            if (svq3_mc_dir(h, mb_type - 1, mode, 0, 0) < 0)
                return -1;
        } else {        /* AV_PICTURE_TYPE_B */
            if (mb_type != 2)
                if (svq3_mc_dir(h, 0, mode, 0, 0) < 0)
                    return -1;
            else
                for (i = 0; i < 4; i++)
                    memset(s->current_picture.f.motion_val[0][b_xy + i * h->b_stride],
                           0, 4 * 2 * sizeof(int16_t));
            if (mb_type != 1)
                if (svq3_mc_dir(h, 0, mode, 1, mb_type == 3) < 0)
                    return -1;
            else
                for (i = 0; i < 4; i++)
                    memset(s->current_picture.f.motion_val[1][b_xy + i * h->b_stride],
                           0, 4 * 2 * sizeof(int16_t));
        }

        mb_type = MB_TYPE_16x16;
    } else if (mb_type == 8 || mb_type == 33) {   /* INTRA4x4 */
        memset(h->intra4x4_pred_mode_cache, -1, 8 * 5 * sizeof(int8_t));

        if (mb_type == 8) {
            if (s->mb_x > 0) {
                for (i = 0; i < 4; i++)
                    h->intra4x4_pred_mode_cache[scan8[0] - 1 + i * 8] = h->intra4x4_pred_mode[h->mb2br_xy[mb_xy - 1] + 6 - i];
                if (h->intra4x4_pred_mode_cache[scan8[0] - 1] == -1)
                    h->left_samples_available = 0x5F5F;
            }
            if (s->mb_y > 0) {
                h->intra4x4_pred_mode_cache[4 + 8 * 0] = h->intra4x4_pred_mode[h->mb2br_xy[mb_xy - s->mb_stride] + 0];
                h->intra4x4_pred_mode_cache[5 + 8 * 0] = h->intra4x4_pred_mode[h->mb2br_xy[mb_xy - s->mb_stride] + 1];
                h->intra4x4_pred_mode_cache[6 + 8 * 0] = h->intra4x4_pred_mode[h->mb2br_xy[mb_xy - s->mb_stride] + 2];
                h->intra4x4_pred_mode_cache[7 + 8 * 0] = h->intra4x4_pred_mode[h->mb2br_xy[mb_xy - s->mb_stride] + 3];

                if (h->intra4x4_pred_mode_cache[4 + 8 * 0] == -1)
                    h->top_samples_available = 0x33FF;
            }

            /* decode prediction codes for luma blocks */
            for (i = 0; i < 16; i += 2) {
                vlc = svq3_get_ue_golomb(&s->gb);

                if (vlc >= 25) {
                    av_log(h->s.avctx, AV_LOG_ERROR, "luma prediction:%d\n", vlc);
                    return -1;
                }

                left = &h->intra4x4_pred_mode_cache[scan8[i] - 1];
                top  = &h->intra4x4_pred_mode_cache[scan8[i] - 8];

                left[1] = svq3_pred_1[top[0] + 1][left[0] + 1][svq3_pred_0[vlc][0]];
                left[2] = svq3_pred_1[top[1] + 1][left[1] + 1][svq3_pred_0[vlc][1]];

                if (left[1] == -1 || left[2] == -1) {
                    av_log(h->s.avctx, AV_LOG_ERROR, "weird prediction\n");
                    return -1;
                }
            }
        } else {    /* mb_type == 33, DC_128_PRED block type */
            for (i = 0; i < 4; i++)
                memset(&h->intra4x4_pred_mode_cache[scan8[0] + 8 * i], DC_PRED, 4);
        }

        write_back_intra_pred_mode(h);

        if (mb_type == 8) {
            ff_h264_check_intra4x4_pred_mode(h);

            h->top_samples_available  = (s->mb_y == 0) ? 0x33FF : 0xFFFF;
            h->left_samples_available = (s->mb_x == 0) ? 0x5F5F : 0xFFFF;
        } else {
            for (i = 0; i < 4; i++)
                memset(&h->intra4x4_pred_mode_cache[scan8[0] + 8 * i], DC_128_PRED, 4);

            h->top_samples_available  = 0x33FF;
            h->left_samples_available = 0x5F5F;
        }

        mb_type = MB_TYPE_INTRA4x4;
    } else {                      /* INTRA16x16 */
        dir = i_mb_type_info[mb_type - 8].pred_mode;
        dir = (dir >> 1) ^ 3 * (dir & 1) ^ 1;

        if ((h->intra16x16_pred_mode = ff_h264_check_intra_pred_mode(h, dir, 0)) == -1) {
            av_log(h->s.avctx, AV_LOG_ERROR, "check_intra_pred_mode = -1\n");
            return -1;
        }

        cbp     = i_mb_type_info[mb_type - 8].cbp;
        mb_type = MB_TYPE_INTRA16x16;
    }

    if (!IS_INTER(mb_type) && s->pict_type != AV_PICTURE_TYPE_I) {
        for (i = 0; i < 4; i++)
            memset(s->current_picture.f.motion_val[0][b_xy + i * h->b_stride],
                   0, 4 * 2 * sizeof(int16_t));
        if (s->pict_type == AV_PICTURE_TYPE_B) {
            for (i = 0; i < 4; i++)
                memset(s->current_picture.f.motion_val[1][b_xy + i * h->b_stride],
                       0, 4 * 2 * sizeof(int16_t));
        }
    }
    if (!IS_INTRA4x4(mb_type)) {
        memset(h->intra4x4_pred_mode + h->mb2br_xy[mb_xy], DC_PRED, 8);
    }
    if (!IS_SKIP(mb_type) || s->pict_type == AV_PICTURE_TYPE_B) {
        memset(h->non_zero_count_cache + 8, 0, 14 * 8 * sizeof(uint8_t));
        s->dsp.clear_blocks(h->mb +   0);
        s->dsp.clear_blocks(h->mb + 384);
    }

    if (!IS_INTRA16x16(mb_type) &&
        (!IS_SKIP(mb_type) || s->pict_type == AV_PICTURE_TYPE_B)) {
        if ((vlc = svq3_get_ue_golomb(&s->gb)) >= 48) {
            av_log(h->s.avctx, AV_LOG_ERROR, "cbp_vlc=%d\n", vlc);
            return -1;
        }

        cbp = IS_INTRA(mb_type) ? golomb_to_intra4x4_cbp[vlc]
                                : golomb_to_inter_cbp[vlc];
    }
    if (IS_INTRA16x16(mb_type) ||
        (s->pict_type != AV_PICTURE_TYPE_I && s->adaptive_quant && cbp)) {
        s->qscale += svq3_get_se_golomb(&s->gb);

        if (s->qscale > 31u) {
            av_log(h->s.avctx, AV_LOG_ERROR, "qscale:%d\n", s->qscale);
            return -1;
        }
    }
    if (IS_INTRA16x16(mb_type)) {
        AV_ZERO128(h->mb_luma_dc[0] + 0);
        AV_ZERO128(h->mb_luma_dc[0] + 8);
        if (svq3_decode_block(&s->gb, h->mb_luma_dc[0], 0, 1)) {
            av_log(h->s.avctx, AV_LOG_ERROR,
                   "error while decoding intra luma dc\n");
            return -1;
        }
    }

    if (cbp) {
        const int index = IS_INTRA16x16(mb_type) ? 1 : 0;
        const int type  = ((s->qscale < 24 && IS_INTRA4x4(mb_type)) ? 2 : 1);

        for (i = 0; i < 4; i++)
            if ((cbp & (1 << i))) {
                for (j = 0; j < 4; j++) {
                    k = index ? (1 * (j & 1) + 2 * (i & 1) +
                                 2 * (j & 2) + 4 * (i & 2))
                              : (4 * i + j);
                    h->non_zero_count_cache[scan8[k]] = 1;

                    if (svq3_decode_block(&s->gb, &h->mb[16 * k], index, type)) {
                        av_log(h->s.avctx, AV_LOG_ERROR,
                               "error while decoding block\n");
                        return -1;
                    }
                }
            }

        if ((cbp & 0x30)) {
            for (i = 1; i < 3; ++i)
                if (svq3_decode_block(&s->gb, &h->mb[16 * 16 * i], 0, 3)) {
                    av_log(h->s.avctx, AV_LOG_ERROR,
                           "error while decoding chroma dc block\n");
                    return -1;
                }

            if ((cbp & 0x20)) {
                for (i = 1; i < 3; i++) {
                    for (j = 0; j < 4; j++) {
                        k                                 = 16 * i + j;
                        h->non_zero_count_cache[scan8[k]] = 1;

                        if (svq3_decode_block(&s->gb, &h->mb[16 * k], 1, 1)) {
                            av_log(h->s.avctx, AV_LOG_ERROR,
                                   "error while decoding chroma ac block\n");
                            return -1;
                        }
                    }
                }
            }
        }
    }

    h->cbp                              = cbp;
    s->current_picture.f.mb_type[mb_xy] = mb_type;

    if (IS_INTRA(mb_type))
        h->chroma_pred_mode = ff_h264_check_intra_pred_mode(h, DC_PRED8x8, 1);

    return 0;
}
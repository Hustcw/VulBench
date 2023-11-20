void ff_h263_update_motion_val(MpegEncContext * s){
    const int mb_xy = s->mb_y * s->mb_stride + s->mb_x;
               //FIXME a lot of that is only needed for !low_delay
    const int wrap = s->b8_stride;
    const int xy = s->block_index[0];

    s->current_picture.f.mbskip_table[mb_xy] = s->mb_skipped;

    if(s->mv_type != MV_TYPE_8X8){
        int motion_x, motion_y;
        if (s->mb_intra) {
            motion_x = 0;
            motion_y = 0;
        } else if (s->mv_type == MV_TYPE_16X16) {
            motion_x = s->mv[0][0][0];
            motion_y = s->mv[0][0][1];
        } else /*if (s->mv_type == MV_TYPE_FIELD)*/ {
            int i;
            motion_x = s->mv[0][0][0] + s->mv[0][1][0];
            motion_y = s->mv[0][0][1] + s->mv[0][1][1];
            motion_x = (motion_x>>1) | (motion_x&1);
            for(i=0; i<2; i++){
                s->p_field_mv_table[i][0][mb_xy][0]= s->mv[0][i][0];
                s->p_field_mv_table[i][0][mb_xy][1]= s->mv[0][i][1];
            }
            s->current_picture.f.ref_index[0][4*mb_xy    ] =
            s->current_picture.f.ref_index[0][4*mb_xy + 1] = s->field_select[0][0];
            s->current_picture.f.ref_index[0][4*mb_xy + 2] =
            s->current_picture.f.ref_index[0][4*mb_xy + 3] = s->field_select[0][1];
        }

        /* no update if 8X8 because it has been done during parsing */
        s->current_picture.f.motion_val[0][xy][0]            = motion_x;
        s->current_picture.f.motion_val[0][xy][1]            = motion_y;
        s->current_picture.f.motion_val[0][xy + 1][0]        = motion_x;
        s->current_picture.f.motion_val[0][xy + 1][1]        = motion_y;
        s->current_picture.f.motion_val[0][xy + wrap][0]     = motion_x;
        s->current_picture.f.motion_val[0][xy + wrap][1]     = motion_y;
        s->current_picture.f.motion_val[0][xy + 1 + wrap][0] = motion_x;
        s->current_picture.f.motion_val[0][xy + 1 + wrap][1] = motion_y;
    }

    if(s->encoding){ //FIXME encoding MUST be cleaned up
        if (s->mv_type == MV_TYPE_8X8)
            s->current_picture.f.mb_type[mb_xy] = MB_TYPE_L0 | MB_TYPE_8x8;
        else if(s->mb_intra)
            s->current_picture.f.mb_type[mb_xy] = MB_TYPE_INTRA;
        else
            s->current_picture.f.mb_type[mb_xy] = MB_TYPE_L0 | MB_TYPE_16x16;
    }
}
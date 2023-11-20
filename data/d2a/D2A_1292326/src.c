static void blend_frame(AVFilterContext *ctx,
                        AVFrame *top_buf,
                        AVFrame *bottom_buf,
                        AVFrame *dst_buf)
{
    BlendContext *b = ctx->priv;
    AVFilterLink *inlink = ctx->inputs[0];
    FilterParams *param;
    int plane;

    for (plane = 0; dst_buf->data[plane]; plane++) {
        int hsub = plane == 1 || plane == 2 ? b->hsub : 0;
        int vsub = plane == 1 || plane == 2 ? b->vsub : 0;
        int outw = dst_buf->width  >> hsub;
        int outh = dst_buf->height >> vsub;
        uint8_t *dst    = dst_buf->data[plane];
        uint8_t *top    = top_buf->data[plane];
        uint8_t *bottom = bottom_buf->data[plane];

        param = &b->params[plane];
        param->values[VAR_N]  = inlink->frame_count;
        param->values[VAR_T]  = dst_buf->pts == AV_NOPTS_VALUE ? NAN : dst_buf->pts * av_q2d(inlink->time_base);
        param->values[VAR_W]  = outw;
        param->values[VAR_H]  = outh;
        param->values[VAR_SW] = outw / dst_buf->width;
        param->values[VAR_SH] = outh / dst_buf->height;
        param->blend(top, top_buf->linesize[plane],
                     bottom, bottom_buf->linesize[plane],
                     dst, dst_buf->linesize[plane], outw, outh, param);
    }
}
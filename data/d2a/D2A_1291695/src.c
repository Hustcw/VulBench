static int config_input(AVFilterLink *inlink)
{
    AVFilterContext *ctx = inlink->dst;
    FrameRateContext *s = ctx->priv;
    const AVPixFmtDescriptor *pix_desc = av_pix_fmt_desc_get(inlink->format);
    int plane;

    for (plane = 0; plane < 4; plane++) {
        s->line_size[plane] = av_image_get_linesize(inlink->format, inlink->w,
                                                    plane);
    }

    s->bitdepth = pix_desc->comp[0].depth;
    s->vsub = pix_desc->log2_chroma_h;
    s->interp_start = s->interp_start_param << (s->bitdepth - 8);
    s->interp_end = s->interp_end_param << (s->bitdepth - 8);

    s->sad = av_pixelutils_get_sad_fn(3, 3, 2, s); // 8x8 both sources aligned
    if (!s->sad)
        return AVERROR(EINVAL);

    s->srce_time_base = inlink->time_base;

    s->max = 1 << (s->bitdepth);
    if (s->bitdepth == 8)
        s->blend = blend_frames_c;
    else
        s->blend = blend_frames16_c;

    return 0;
}
static av_cold int ulti_decode_init(AVCodecContext *avctx)

{

    UltimotionDecodeContext *s = avctx->priv_data;



    s->avctx = avctx;

    s->width = avctx->width;

    s->height = avctx->height;

    s->blocks = (s->width / 8) * (s->height / 8);



    avctx->pix_fmt = AV_PIX_FMT_YUV410P;

    s->ulti_codebook = ulti_codebook;



    s->frame = av_frame_alloc();

    if (!s->frame)

        return AVERROR(ENOMEM);



    return 0;

}
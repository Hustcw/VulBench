static int mov_text_decode_close(AVCodecContext *avctx)

{

    MovTextContext *m = avctx->priv_data;

    mov_text_cleanup_ftab(m);


    return 0;

}
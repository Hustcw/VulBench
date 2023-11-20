int av_new_packet(AVPacket *pkt, int size)
{
    uint8_t *data= NULL;
    if((unsigned)size < (unsigned)size + FF_INPUT_BUFFER_PADDING_SIZE)
        data = av_malloc(size + FF_INPUT_BUFFER_PADDING_SIZE);
    if (data){
        memset(data + size, 0, FF_INPUT_BUFFER_PADDING_SIZE);
    }else
        size=0;

    av_init_packet(pkt);
    pkt->data = data;
    pkt->size = size;
    pkt->destruct = av_destruct_packet;
    if(!data)
        return AVERROR(ENOMEM);
    return 0;
}
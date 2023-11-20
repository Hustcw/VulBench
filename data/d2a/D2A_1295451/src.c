static inline void refill_32(BitstreamContext *bc)
{
    if (bc->ptr >= bc->buffer_end)
        return;

#ifdef BITSTREAM_READER_LE
    bc->bits       = (uint64_t)AV_RL32(bc->ptr) << bc->bits_left | bc->bits;
#else
    bc->bits       = bc->bits | (uint64_t)AV_RB32(bc->ptr) << (32 - bc->bits_left);
#endif
    bc->ptr       += 4;
    bc->bits_left += 32;
}
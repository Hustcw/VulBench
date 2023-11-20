static void planar_rgb16le_to_uv(uint8_t *_dstU, uint8_t *_dstV,
                                 const uint8_t *_src[4], int width)
{
    int i;
    const uint16_t **src = (const uint16_t **)_src;
    uint16_t *dstU       = (uint16_t *)_dstU;
    uint16_t *dstV       = (uint16_t *)_dstV;
    for (i = 0; i < width; i++) {
        int g = AV_RL16(src[0] + i);
        int b = AV_RL16(src[1] + i);
        int r = AV_RL16(src[2] + i);

        dstU[i] = (RU * r + GU * g + BU * b + (257 << RGB2YUV_SHIFT)) >> (RGB2YUV_SHIFT + 1);
        dstV[i] = (RV * r + GV * g + BV * b + (257 << RGB2YUV_SHIFT)) >> (RGB2YUV_SHIFT + 1);
    }
}
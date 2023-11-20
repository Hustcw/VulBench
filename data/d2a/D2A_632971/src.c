static void apply_rematrixing(AC3EncodeContext *s)
{
    int nb_coefs;
    int blk, bnd, i;
    int start, end;
    uint8_t *flags;

    if (!s->rematrixing_enabled)
        return;

    for (blk = 0; blk < AC3_MAX_BLOCKS; blk++) {
        AC3Block *block = &s->blocks[blk];
        if (block->new_rematrixing_strategy)
            flags = block->rematrixing_flags;
        nb_coefs = FFMIN(block->end_freq[1], block->end_freq[2]);
        for (bnd = 0; bnd < block->num_rematrixing_bands; bnd++) {
            if (flags[bnd]) {
                start = ff_ac3_rematrix_band_tab[bnd];
                end   = FFMIN(nb_coefs, ff_ac3_rematrix_band_tab[bnd+1]);
                for (i = start; i < end; i++) {
                    int32_t lt = block->fixed_coef[1][i];
                    int32_t rt = block->fixed_coef[2][i];
                    block->fixed_coef[1][i] = (lt + rt) >> 1;
                    block->fixed_coef[2][i] = (lt - rt) >> 1;
                }
            }
        }
    }
}
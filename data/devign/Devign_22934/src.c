static void inner_add_yblock_bw_16_obmc_32_sse2(const uint8_t *obmc, const long obmc_stride, uint8_t * * block, int b_w, long b_h,

                      int src_x, int src_y, long src_stride, slice_buffer * sb, int add, uint8_t * dst8){

snow_inner_add_yblock_sse2_header

snow_inner_add_yblock_sse2_start_16("xmm1", "xmm5", "3", "0")

snow_inner_add_yblock_sse2_accum_16("2", "16")

snow_inner_add_yblock_sse2_accum_16("1", "512")

snow_inner_add_yblock_sse2_accum_16("0", "528")



             "mov %0, %%"REG_d"              \n\t"

             "movdqa %%xmm1, %%xmm0          \n\t"

             "movdqa %%xmm5, %%xmm4          \n\t"

             "punpcklwd %%xmm7, %%xmm0       \n\t"

             "paddd (%%"REG_D"), %%xmm0      \n\t"

             "punpckhwd %%xmm7, %%xmm1       \n\t"

             "paddd 16(%%"REG_D"), %%xmm1    \n\t"

             "punpcklwd %%xmm7, %%xmm4       \n\t"

             "paddd 32(%%"REG_D"), %%xmm4    \n\t"

             "punpckhwd %%xmm7, %%xmm5       \n\t"

             "paddd 48(%%"REG_D"), %%xmm5    \n\t"

             "paddd %%xmm3, %%xmm0           \n\t"

             "paddd %%xmm3, %%xmm1           \n\t"

             "paddd %%xmm3, %%xmm4           \n\t"

             "paddd %%xmm3, %%xmm5           \n\t"

             "psrad $8, %%xmm0               \n\t" /* FRAC_BITS. */

             "psrad $8, %%xmm1               \n\t" /* FRAC_BITS. */

             "psrad $8, %%xmm4               \n\t" /* FRAC_BITS. */

             "psrad $8, %%xmm5               \n\t" /* FRAC_BITS. */



             "packssdw %%xmm1, %%xmm0        \n\t"

             "packssdw %%xmm5, %%xmm4        \n\t"

             "packuswb %%xmm4, %%xmm0        \n\t"



             "movdqu %%xmm0, (%%"REG_d")       \n\t"



snow_inner_add_yblock_sse2_end_16

}

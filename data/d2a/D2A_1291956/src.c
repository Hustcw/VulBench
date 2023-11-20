static av_always_inline int vc1_filter_line(uint8_t* src, int stride, int pq){
    uint8_t *cm = ff_cropTbl + MAX_NEG_CROP;

    int a0 = (2*(src[-2*stride] - src[ 1*stride]) - 5*(src[-1*stride] - src[ 0*stride]) + 4) >> 3;
    int a0_sign = a0 >> 31;        /* Store sign */
    a0 = (a0 ^ a0_sign) - a0_sign; /* a0 = FFABS(a0); */
    if(a0 < pq){
        int a1 = FFABS((2*(src[-4*stride] - src[-1*stride]) - 5*(src[-3*stride] - src[-2*stride]) + 4) >> 3);
        int a2 = FFABS((2*(src[ 0*stride] - src[ 3*stride]) - 5*(src[ 1*stride] - src[ 2*stride]) + 4) >> 3);
        if(a1 < a0 || a2 < a0){
            int clip = src[-1*stride] - src[ 0*stride];
            int clip_sign = clip >> 31;
            clip = ((clip ^ clip_sign) - clip_sign)>>1;
            if(clip){
                int a3 = FFMIN(a1, a2);
                int d = 5 * (a3 - a0);
                int d_sign = (d >> 31);
                d = ((d ^ d_sign) - d_sign) >> 3;
                d_sign ^= a0_sign;

                if( d_sign ^ clip_sign )
                    d = 0;
                else{
                    d = FFMIN(d, clip);
                    d = (d ^ d_sign) - d_sign;          /* Restore sign */
                    src[-1*stride] = cm[src[-1*stride] - d];
                    src[ 0*stride] = cm[src[ 0*stride] + d];
                }
                return 1;
            }
        }
    }
    return 0;
}
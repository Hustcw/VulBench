static int biquad_init_coeffs(void *avc, struct FFIIRFilterCoeffs *c,
                              enum IIRFilterMode filt_mode, int order,
                              float cutoff_ratio, float stopband)
{
    double cos_w0, sin_w0;
    double a0, x0, x1;

    if (filt_mode != FF_FILTER_MODE_HIGHPASS &&
        filt_mode != FF_FILTER_MODE_LOWPASS) {
        av_log(avc, AV_LOG_ERROR, "Biquad filter currently only supports "
               "high-pass and low-pass filter modes\n");
        return -1;
    }
    if (order != 2) {
        av_log(avc, AV_LOG_ERROR, "Biquad filter must have order of 2\n");
        return -1;
    }

    cos_w0 = cos(M_PI * cutoff_ratio);
    sin_w0 = sin(M_PI * cutoff_ratio);

    a0 = 1.0 + (sin_w0 / 2.0);

    if (filt_mode == FF_FILTER_MODE_HIGHPASS) {
        c->gain  =  ((1.0 + cos_w0) / 2.0)  / a0;
        x0       =  ((1.0 + cos_w0) / 2.0)  / a0;
        x1       = (-(1.0 + cos_w0))        / a0;
    } else { // FF_FILTER_MODE_LOWPASS
        c->gain  =  ((1.0 - cos_w0) / 2.0)  / a0;
        x0       =  ((1.0 - cos_w0) / 2.0)  / a0;
        x1       =   (1.0 - cos_w0)         / a0;
    }
    c->cy[0] = (-1.0 + (sin_w0 / 2.0)) / a0;
    c->cy[1] =  (2.0 *  cos_w0)        / a0;

    // divide by gain to make the x coeffs integers.
    // during filtering, the delay state will include the gain multiplication
    c->cx[0] = lrintf(x0 / c->gain);
    c->cx[1] = lrintf(x1 / c->gain);

    return 0;
}
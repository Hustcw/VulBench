static int encode_residual_ch(FlacEncodeContext *s, int ch)

{

    int i, n;

    int min_order, max_order, opt_order, omethod;

    FlacFrame *frame;

    FlacSubframe *sub;

    int32_t coefs[MAX_LPC_ORDER][MAX_LPC_ORDER];

    int shift[MAX_LPC_ORDER];

    int32_t *res, *smp;



    frame = &s->frame;

    sub   = &frame->subframes[ch];

    res   = sub->residual;

    smp   = sub->samples;

    n     = frame->blocksize;



    /* CONSTANT */

    for (i = 1; i < n; i++)

        if(smp[i] != smp[0])

            break;

    if (i == n) {

        sub->type = sub->type_code = FLAC_SUBFRAME_CONSTANT;

        res[0] = smp[0];

        return subframe_count_exact(s, sub, 0);

    }



    /* VERBATIM */

    if (frame->verbatim_only || n < 5) {

        sub->type = sub->type_code = FLAC_SUBFRAME_VERBATIM;

        memcpy(res, smp, n * sizeof(int32_t));

        return subframe_count_exact(s, sub, 0);

    }



    min_order  = s->options.min_prediction_order;

    max_order  = s->options.max_prediction_order;

    omethod    = s->options.prediction_order_method;



    /* FIXED */

    sub->type = FLAC_SUBFRAME_FIXED;

    if (s->options.lpc_type == FF_LPC_TYPE_NONE  ||

        s->options.lpc_type == FF_LPC_TYPE_FIXED || n <= max_order) {

        uint32_t bits[MAX_FIXED_ORDER+1];

        if (max_order > MAX_FIXED_ORDER)

            max_order = MAX_FIXED_ORDER;

        opt_order = 0;

        bits[0]   = UINT32_MAX;

        for (i = min_order; i <= max_order; i++) {

            encode_residual_fixed(res, smp, n, i);

            bits[i] = find_subframe_rice_params(s, sub, i);

            if (bits[i] < bits[opt_order])

                opt_order = i;

        }

        sub->order     = opt_order;

        sub->type_code = sub->type | sub->order;

        if (sub->order != max_order) {

            encode_residual_fixed(res, smp, n, sub->order);

            find_subframe_rice_params(s, sub, sub->order);

        }

        return subframe_count_exact(s, sub, sub->order);

    }



    /* LPC */

    sub->type = FLAC_SUBFRAME_LPC;

    opt_order = ff_lpc_calc_coefs(&s->lpc_ctx, smp, n, min_order, max_order,

                                  s->options.lpc_coeff_precision, coefs, shift, s->options.lpc_type,

                                  s->options.lpc_passes, omethod,

                                  MAX_LPC_SHIFT, 0);



    if (omethod == ORDER_METHOD_2LEVEL ||

        omethod == ORDER_METHOD_4LEVEL ||

        omethod == ORDER_METHOD_8LEVEL) {

        int levels = 1 << omethod;

        uint32_t bits[1 << ORDER_METHOD_8LEVEL];

        int order;

        int opt_index   = levels-1;

        opt_order       = max_order-1;

        bits[opt_index] = UINT32_MAX;

        for (i = levels-1; i >= 0; i--) {

            order = min_order + (((max_order-min_order+1) * (i+1)) / levels)-1;

            if (order < 0)

                order = 0;

            encode_residual_lpc(res, smp, n, order+1, coefs[order], shift[order]);

            bits[i] = find_subframe_rice_params(s, sub, order+1);

            if (bits[i] < bits[opt_index]) {

                opt_index = i;

                opt_order = order;

            }

        }

        opt_order++;

    } else if (omethod == ORDER_METHOD_SEARCH) {

        // brute-force optimal order search

        uint32_t bits[MAX_LPC_ORDER];

        opt_order = 0;

        bits[0]   = UINT32_MAX;

        for (i = min_order-1; i < max_order; i++) {

            encode_residual_lpc(res, smp, n, i+1, coefs[i], shift[i]);

            bits[i] = find_subframe_rice_params(s, sub, i+1);

            if (bits[i] < bits[opt_order])

                opt_order = i;

        }

        opt_order++;

    } else if (omethod == ORDER_METHOD_LOG) {

        uint32_t bits[MAX_LPC_ORDER];

        int step;



        opt_order = min_order - 1 + (max_order-min_order)/3;

        memset(bits, -1, sizeof(bits));



        for (step = 16; step; step >>= 1) {

            int last = opt_order;

            for (i = last-step; i <= last+step; i += step) {

                if (i < min_order-1 || i >= max_order || bits[i] < UINT32_MAX)

                    continue;

                encode_residual_lpc(res, smp, n, i+1, coefs[i], shift[i]);

                bits[i] = find_subframe_rice_params(s, sub, i+1);

                if (bits[i] < bits[opt_order])

                    opt_order = i;

            }

        }

        opt_order++;

    }



    sub->order     = opt_order;

    sub->type_code = sub->type | (sub->order-1);

    sub->shift     = shift[sub->order-1];

    for (i = 0; i < sub->order; i++)

        sub->coefs[i] = coefs[sub->order-1][i];



    encode_residual_lpc(res, smp, n, sub->order, sub->coefs, sub->shift);



    find_subframe_rice_params(s, sub, sub->order);



    return subframe_count_exact(s, sub, sub->order);

}

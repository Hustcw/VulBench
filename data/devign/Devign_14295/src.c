static void adpcm_compress_trellis(AVCodecContext *avctx,

                                   const int16_t *samples, uint8_t *dst,

                                   ADPCMChannelStatus *c, int n, int stride)

{

    //FIXME 6% faster if frontier is a compile-time constant

    ADPCMEncodeContext *s = avctx->priv_data;

    const int frontier = 1 << avctx->trellis;

    const int version  = avctx->codec->id;

    TrellisPath *paths       = s->paths, *p;

    TrellisNode *node_buf    = s->node_buf;

    TrellisNode **nodep_buf  = s->nodep_buf;

    TrellisNode **nodes      = nodep_buf; // nodes[] is always sorted by .ssd

    TrellisNode **nodes_next = nodep_buf + frontier;

    int pathn = 0, froze = -1, i, j, k, generation = 0;

    uint8_t *hash = s->trellis_hash;

    memset(hash, 0xff, 65536 * sizeof(*hash));



    memset(nodep_buf, 0, 2 * frontier * sizeof(*nodep_buf));

    nodes[0]          = node_buf + frontier;

    nodes[0]->ssd     = 0;

    nodes[0]->path    = 0;

    nodes[0]->step    = c->step_index;

    nodes[0]->sample1 = c->sample1;

    nodes[0]->sample2 = c->sample2;

    if (version == AV_CODEC_ID_ADPCM_IMA_WAV ||

        version == AV_CODEC_ID_ADPCM_IMA_QT  ||

        version == AV_CODEC_ID_ADPCM_SWF)

        nodes[0]->sample1 = c->prev_sample;

    if (version == AV_CODEC_ID_ADPCM_MS)

        nodes[0]->step = c->idelta;

    if (version == AV_CODEC_ID_ADPCM_YAMAHA) {

        if (c->step == 0) {

            nodes[0]->step    = 127;

            nodes[0]->sample1 = 0;

        } else {

            nodes[0]->step    = c->step;

            nodes[0]->sample1 = c->predictor;

        }

    }



    for (i = 0; i < n; i++) {

        TrellisNode *t = node_buf + frontier*(i&1);

        TrellisNode **u;

        int sample   = samples[i * stride];

        int heap_pos = 0;

        memset(nodes_next, 0, frontier * sizeof(TrellisNode*));

        for (j = 0; j < frontier && nodes[j]; j++) {

            // higher j have higher ssd already, so they're likely

            // to yield a suboptimal next sample too

            const int range = (j < frontier / 2) ? 1 : 0;

            const int step  = nodes[j]->step;

            int nidx;

            if (version == AV_CODEC_ID_ADPCM_MS) {

                const int predictor = ((nodes[j]->sample1 * c->coeff1) +

                                       (nodes[j]->sample2 * c->coeff2)) / 64;

                const int div  = (sample - predictor) / step;

                const int nmin = av_clip(div-range, -8, 6);

                const int nmax = av_clip(div+range, -7, 7);

                for (nidx = nmin; nidx <= nmax; nidx++) {

                    const int nibble = nidx & 0xf;

                    int dec_sample   = predictor + nidx * step;

#define STORE_NODE(NAME, STEP_INDEX)\

                    int d;\

                    uint32_t ssd;\

                    int pos;\

                    TrellisNode *u;\

                    uint8_t *h;\

                    dec_sample = av_clip_int16(dec_sample);\

                    d = sample - dec_sample;\

                    ssd = nodes[j]->ssd + d*d;\

                    /* Check for wraparound, skip such samples completely. \

                     * Note, changing ssd to a 64 bit variable would be \

                     * simpler, avoiding this check, but it's slower on \

                     * x86 32 bit at the moment. */\

                    if (ssd < nodes[j]->ssd)\

                        goto next_##NAME;\

                    /* Collapse any two states with the same previous sample value. \

                     * One could also distinguish states by step and by 2nd to last

                     * sample, but the effects of that are negligible.

                     * Since nodes in the previous generation are iterated

                     * through a heap, they're roughly ordered from better to

                     * worse, but not strictly ordered. Therefore, an earlier

                     * node with the same sample value is better in most cases

                     * (and thus the current is skipped), but not strictly

                     * in all cases. Only skipping samples where ssd >=

                     * ssd of the earlier node with the same sample gives

                     * slightly worse quality, though, for some reason. */ \

                    h = &hash[(uint16_t) dec_sample];\

                    if (*h == generation)\

                        goto next_##NAME;\

                    if (heap_pos < frontier) {\

                        pos = heap_pos++;\

                    } else {\

                        /* Try to replace one of the leaf nodes with the new \

                         * one, but try a different slot each time. */\

                        pos = (frontier >> 1) +\

                              (heap_pos & ((frontier >> 1) - 1));\

                        if (ssd > nodes_next[pos]->ssd)\

                            goto next_##NAME;\

                        heap_pos++;\

                    }\

                    *h = generation;\

                    u  = nodes_next[pos];\

                    if (!u) {\

                        av_assert1(pathn < FREEZE_INTERVAL << avctx->trellis);\

                        u = t++;\

                        nodes_next[pos] = u;\

                        u->path = pathn++;\

                    }\

                    u->ssd  = ssd;\

                    u->step = STEP_INDEX;\

                    u->sample2 = nodes[j]->sample1;\

                    u->sample1 = dec_sample;\

                    paths[u->path].nibble = nibble;\

                    paths[u->path].prev   = nodes[j]->path;\

                    /* Sift the newly inserted node up in the heap to \

                     * restore the heap property. */\

                    while (pos > 0) {\

                        int parent = (pos - 1) >> 1;\

                        if (nodes_next[parent]->ssd <= ssd)\

                            break;\

                        FFSWAP(TrellisNode*, nodes_next[parent], nodes_next[pos]);\

                        pos = parent;\

                    }\

                    next_##NAME:;

                    STORE_NODE(ms, FFMAX(16,

                               (ff_adpcm_AdaptationTable[nibble] * step) >> 8));

                }

            } else if (version == AV_CODEC_ID_ADPCM_IMA_WAV ||

                       version == AV_CODEC_ID_ADPCM_IMA_QT  ||

                       version == AV_CODEC_ID_ADPCM_SWF) {

#define LOOP_NODES(NAME, STEP_TABLE, STEP_INDEX)\

                const int predictor = nodes[j]->sample1;\

                const int div = (sample - predictor) * 4 / STEP_TABLE;\

                int nmin = av_clip(div - range, -7, 6);\

                int nmax = av_clip(div + range, -6, 7);\

                if (nmin <= 0)\

                    nmin--; /* distinguish -0 from +0 */\

                if (nmax < 0)\

                    nmax--;\

                for (nidx = nmin; nidx <= nmax; nidx++) {\

                    const int nibble = nidx < 0 ? 7 - nidx : nidx;\

                    int dec_sample = predictor +\

                                    (STEP_TABLE *\

                                     ff_adpcm_yamaha_difflookup[nibble]) / 8;\

                    STORE_NODE(NAME, STEP_INDEX);\

                }

                LOOP_NODES(ima, ff_adpcm_step_table[step],

                           av_clip(step + ff_adpcm_index_table[nibble], 0, 88));

            } else { //AV_CODEC_ID_ADPCM_YAMAHA

                LOOP_NODES(yamaha, step,

                           av_clip((step * ff_adpcm_yamaha_indexscale[nibble]) >> 8,

                                   127, 24567));

#undef LOOP_NODES

#undef STORE_NODE

            }

        }



        u = nodes;

        nodes = nodes_next;

        nodes_next = u;



        generation++;

        if (generation == 255) {

            memset(hash, 0xff, 65536 * sizeof(*hash));

            generation = 0;

        }



        // prevent overflow

        if (nodes[0]->ssd > (1 << 28)) {

            for (j = 1; j < frontier && nodes[j]; j++)

                nodes[j]->ssd -= nodes[0]->ssd;

            nodes[0]->ssd = 0;

        }



        // merge old paths to save memory

        if (i == froze + FREEZE_INTERVAL) {

            p = &paths[nodes[0]->path];

            for (k = i; k > froze; k--) {

                dst[k] = p->nibble;

                p = &paths[p->prev];

            }

            froze = i;

            pathn = 0;

            // other nodes might use paths that don't coincide with the frozen one.

            // checking which nodes do so is too slow, so just kill them all.

            // this also slightly improves quality, but I don't know why.

            memset(nodes + 1, 0, (frontier - 1) * sizeof(TrellisNode*));

        }

    }



    p = &paths[nodes[0]->path];

    for (i = n - 1; i > froze; i--) {

        dst[i] = p->nibble;

        p = &paths[p->prev];

    }



    c->predictor  = nodes[0]->sample1;

    c->sample1    = nodes[0]->sample1;

    c->sample2    = nodes[0]->sample2;

    c->step_index = nodes[0]->step;

    c->step       = nodes[0]->step;

    c->idelta     = nodes[0]->step;

}

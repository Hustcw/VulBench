typedef struct RangeCoder {
    int low;
    int range;
    int outstanding_count;
    int outstanding_byte;
    uint8_t zero_state[256];
    uint8_t one_state[256];
    uint8_t *bytestream_start;
    uint8_t *bytestream;
    uint8_t *bytestream_end;
    int overread;
} RangeCoder;

av_cold void ff_init_range_encoder(RangeCoder *c, uint8_t *buf, int buf_size)
{
    c->bytestream_start  =
    c->bytestream        = buf;
    c->bytestream_end    = buf + buf_size;
    c->low               = 0;
    c->range             = 0xFF00;
    c->outstanding_count = 0;
    c->outstanding_byte  = -1;
}

static int decode_q_branch(SnowContext *s, int level, int x, int y){
    const int w= s->b_width << s->block_max_depth;
    const int rem_depth= s->block_max_depth - level;
    const int index= (x + y*w) << rem_depth;
    int trx= (x+1)<<rem_depth;
    const BlockNode *left  = x ? &s->block[index-1] : &null_block;
    const BlockNode *top   = y ? &s->block[index-w] : &null_block;
    const BlockNode *tl    = y && x ? &s->block[index-w-1] : left;
    const BlockNode *tr    = y && trx<w && ((x&1)==0 || level==0) ? &s->block[index-w+(1<<rem_depth)] : tl; //FIXME use lt
    int s_context= 2*left->level + 2*top->level + tl->level + tr->level;
    int res;

    if(s->keyframe){
        set_blocks(s, level, x, y, null_block.color[0], null_block.color[1], null_block.color[2], null_block.mx, null_block.my, null_block.ref, BLOCK_INTRA);
        return 0;
    }

    if(level==s->block_max_depth || get_rac(&s->c, &s->block_state[4 + s_context])){
        int type, mx, my;
        int l = left->color[0];
        int cb= left->color[1];
        int cr= left->color[2];
        unsigned ref = 0;
        int ref_context= av_log2(2*left->ref) + av_log2(2*top->ref);
        int mx_context= av_log2(2*FFABS(left->mx - top->mx)) + 0*av_log2(2*FFABS(tr->mx - top->mx));
        int my_context= av_log2(2*FFABS(left->my - top->my)) + 0*av_log2(2*FFABS(tr->my - top->my));

        type= get_rac(&s->c, &s->block_state[1 + left->type + top->type]) ? BLOCK_INTRA : 0;
        if(type){
            int ld, cbd, crd;
            pred_mv(s, &mx, &my, 0, left, top, tr);
            ld = get_symbol(&s->c, &s->block_state[32], 1);
            if (ld < -255 || ld > 255) {
                return AVERROR_INVALIDDATA;
            }
            l += ld;
            if (s->nb_planes > 2) {
                cbd = get_symbol(&s->c, &s->block_state[64], 1);
                crd = get_symbol(&s->c, &s->block_state[96], 1);
                if (cbd < -255 || cbd > 255 || crd < -255 || crd > 255) {
                    return AVERROR_INVALIDDATA;
                }
                cb += cbd;
                cr += crd;
            }
        }else{
            if(s->ref_frames > 1)
                ref= get_symbol(&s->c, &s->block_state[128 + 1024 + 32*ref_context], 0);
            if (ref >= s->ref_frames) {
                av_log(s->avctx, AV_LOG_ERROR, "Invalid ref\n");
                return AVERROR_INVALIDDATA;
            }
            pred_mv(s, &mx, &my, ref, left, top, tr);
            mx+= get_symbol(&s->c, &s->block_state[128 + 32*(mx_context + 16*!!ref)], 1);
            my+= get_symbol(&s->c, &s->block_state[128 + 32*(my_context + 16*!!ref)], 1);
        }
        set_blocks(s, level, x, y, l, cb, cr, mx, my, ref, type);
    }else{
        if ((res = decode_q_branch(s, level+1, 2*x+0, 2*y+0)) < 0 ||
            (res = decode_q_branch(s, level+1, 2*x+1, 2*y+0)) < 0 ||
            (res = decode_q_branch(s, level+1, 2*x+0, 2*y+1)) < 0 ||
            (res = decode_q_branch(s, level+1, 2*x+1, 2*y+1)) < 0)
            return res;
    }
    return 0;
}

static inline int get_symbol(RangeCoder *c, uint8_t *state, int is_signed){
    if(get_rac(c, state+0))
        return 0;
    else{
        int i, e;
        unsigned a;
        e= 0;
        while(get_rac(c, state+1 + FFMIN(e,9))){ //1..10
            e++;
            if (e > 31)
                return AVERROR_INVALIDDATA;
        }

        a= 1;
        for(i=e-1; i>=0; i--){
            a += a + get_rac(c, state+22 + FFMIN(i,9)); //22..31
        }

        e= -(is_signed && get_rac(c, state+11 + FFMIN(e,10))); //11..21
        return (a^e)-e;
    }
}

static inline int get_rac(RangeCoder *c, uint8_t *const state)
{
    int range1 = (c->range * (*state)) >> 8;

    c->range -= range1;
    if (c->low < c->range) {
        *state = c->zero_state[*state];
        refill(c);
        return 0;
    } else {
        c->low  -= c->range;
        *state   = c->one_state[*state];
        c->range = range1;
        refill(c);
        return 1;
    }
}

static inline void refill(RangeCoder *c)
{
    if (c->range < 0x100) {
        c->range <<= 8;
        c->low   <<= 8;
        if (c->bytestream < c->bytestream_end) {
            c->low += c->bytestream[0];
            c->bytestream++;
        } else
            c->overread ++;
    }
}

static inline void pred_mv(SnowContext *s, int *mx, int *my, int ref,
                           const BlockNode *left, const BlockNode *top, const BlockNode *tr){
    if(s->ref_frames == 1){
        *mx = mid_pred(left->mx, top->mx, tr->mx);
        *my = mid_pred(left->my, top->my, tr->my);
    }else{
        const int *scale = ff_scale_mv_ref[ref];
        *mx = mid_pred((left->mx * scale[left->ref] + 128) >>8,
                       (top ->mx * scale[top ->ref] + 128) >>8,
                       (tr  ->mx * scale[tr  ->ref] + 128) >>8);
        *my = mid_pred((left->my * scale[left->ref] + 128) >>8,
                       (top ->my * scale[top ->ref] + 128) >>8,
                       (tr  ->my * scale[tr  ->ref] + 128) >>8);
    }
}

static inline av_const int mid_pred(int a, int b, int c)
{
    if(a>b){
        if(c>b){
            if(c>a) b=a;
            else    b=c;
        }
    }else{
        if(b>c){
            if(c>a) b=c;
            else    b=a;
        }
    }
    return b;
}
static int decode_blocks(SnowContext *s){

    int x, y;

    int w= s->b_width;

    int h= s->b_height;

    int res;



    for(y=0; y<h; y++){

        for(x=0; x<w; x++){



            if ((res = decode_q_branch(s, 0, x, y)) < 0)

                return res;

        }

    }

    return 0;

}
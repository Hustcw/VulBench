void BN_CTX_end(BN_CTX *ctx)
	{
	if (ctx == NULL) return;
	assert(ctx->depth > 0);
	if (ctx->depth == 0)
		/* should never happen, but we can tolerate it if not in
		 * debug mode (could be a 'goto err' in the calling function
		 * before BN_CTX_start was reached) */
		BN_CTX_start(ctx);

	ctx->too_many = 0;
	ctx->depth--;
	if (ctx->depth < BN_CTX_NUM_POS)
#ifndef BN_DEBUG
		ctx->tos = ctx->pos[ctx->depth];
#else
		while(ctx->tos > ctx->pos[ctx->depth])
			bn_check_top(&ctx->bn[--(ctx->tos)]);
#endif
	}
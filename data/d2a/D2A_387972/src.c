static BN_ULONG *bn_expand_internal(const BIGNUM *b, int words)
	{
	BN_ULONG *A,*a = NULL;
	const BN_ULONG *B;
	int i;

	bn_check_top(b);

	if (words > (INT_MAX/(4*BN_BITS2)))
		{
		BNerr(BN_F_BN_EXPAND_INTERNAL,BN_R_BIGNUM_TOO_LONG);
		return NULL;
		}
	if (BN_get_flags(b,BN_FLG_STATIC_DATA))
		{
		BNerr(BN_F_BN_EXPAND_INTERNAL,BN_R_EXPAND_ON_STATIC_BIGNUM_DATA);
		return(NULL);
		}
	a=A=(BN_ULONG *)OPENSSL_malloc(sizeof(BN_ULONG)*(words+1));
	if (A == NULL)
		{
		BNerr(BN_F_BN_EXPAND_INTERNAL,ERR_R_MALLOC_FAILURE);
		return(NULL);
		}
#if 1
	B=b->d;
	/* Check if the previous number needs to be copied */
	if (B != NULL)
		{
		for (i=b->top>>2; i>0; i--,A+=4,B+=4)
			{
			/*
			 * The fact that the loop is unrolled
			 * 4-wise is a tribute to Intel. It's
			 * the one that doesn't have enough
			 * registers to accomodate more data.
			 * I'd unroll it 8-wise otherwise:-)
			 *
			 *		<appro@fy.chalmers.se>
			 */
			BN_ULONG a0,a1,a2,a3;
			a0=B[0]; a1=B[1]; a2=B[2]; a3=B[3];
			A[0]=a0; A[1]=a1; A[2]=a2; A[3]=a3;
			}
		switch (b->top&3)
			{
		case 3:	A[2]=B[2];
		case 2:	A[1]=B[1];
		case 1:	A[0]=B[0];
		case 0: /* workaround for ultrix cc: without 'case 0', the optimizer does
		         * the switch table by doing a=top&3; a--; goto jump_table[a];
		         * which fails for top== 0 */
			;
			}
		}

#else
	memset(A,0,sizeof(BN_ULONG)*(words+1));
	memcpy(A,b->d,sizeof(b->d[0])*b->top);
#endif
		
	return(a);
	}
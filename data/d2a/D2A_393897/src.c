int BN_usub(BIGNUM *r, const BIGNUM *a, const BIGNUM *b)
	{
	int max,min,dif;
	register BN_ULONG t1,t2,*ap,*bp,*rp;
	int i,carry;
#if defined(IRIX_CC_BUG) && !defined(LINT)
	int dummy;
#endif

	bn_check_top(a);
	bn_check_top(b);

	max = a->top;
	min = b->top;
	dif = max - min;

	if (dif < 0)	/* hmm... should not be happening */
		{
		BNerr(BN_F_BN_USUB,BN_R_ARG2_LT_ARG3);
		return(0);
		}

	if (bn_wexpand(r,max) == NULL) return(0);

	ap=a->d;
	bp=b->d;
	rp=r->d;

#if 1
	carry=0;
	for (i = min; i != 0; i--)
		{
		t1= *(ap++);
		t2= *(bp++);
		if (carry)
			{
			carry=(t1 <= t2);
			t1=(t1-t2-1)&BN_MASK2;
			}
		else
			{
			carry=(t1 < t2);
			t1=(t1-t2)&BN_MASK2;
			}
#if defined(IRIX_CC_BUG) && !defined(LINT)
		dummy=t1;
#endif
		*(rp++)=t1&BN_MASK2;
		}
#else
	carry=bn_sub_words(rp,ap,bp,min);
	ap+=min;
	bp+=min;
	rp+=min;
#endif
	if (carry) /* subtracted */
		{
		if (!dif)
			/* error: a < b */
			return 0;
		while (dif)
			{
			dif--;
			t1 = *(ap++);
			t2 = (t1-1)&BN_MASK2;
			*(rp++) = t2;
			if (t1)
				break;
			}
		}
#if 0
	memcpy(rp,ap,sizeof(*rp)*(max-i));
#else
	if (rp != ap)
		{
		for (;;)
			{
			if (!dif--) break;
			rp[0]=ap[0];
			if (!dif--) break;
			rp[1]=ap[1];
			if (!dif--) break;
			rp[2]=ap[2];
			if (!dif--) break;
			rp[3]=ap[3];
			rp+=4;
			ap+=4;
			}
		}
#endif

	r->top=max;
	r->neg=0;
	bn_correct_top(r);
	return(1);
	}
BN_ULONG bn_sub_words(BN_ULONG *r, BN_ULONG *a, BN_ULONG *b, int n)
        {
	BN_ULONG t1,t2;
	int c=0;

	assert(n >= 0);
	if (n <= 0) return((BN_ULONG)0);

	for (;;)
		{
		t1=a[0]; t2=b[0];
		r[0]=(t1-t2-c)&BN_MASK2;
		if (t1 != t2) c=(t1 < t2);
		if (--n <= 0) break;

		t1=a[1]; t2=b[1];
		r[1]=(t1-t2-c)&BN_MASK2;
		if (t1 != t2) c=(t1 < t2);
		if (--n <= 0) break;

		t1=a[2]; t2=b[2];
		r[2]=(t1-t2-c)&BN_MASK2;
		if (t1 != t2) c=(t1 < t2);
		if (--n <= 0) break;

		t1=a[3]; t2=b[3];
		r[3]=(t1-t2-c)&BN_MASK2;
		if (t1 != t2) c=(t1 < t2);
		if (--n <= 0) break;

		a+=4;
		b+=4;
		r+=4;
		}
	return(c);
	}
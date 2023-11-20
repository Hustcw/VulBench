void CRYPTO_destroy_dynlockid(int i)
	{
	CRYPTO_dynlock *pointer = NULL;
	if (i)
		i = -i-1;
	if (dynlock_destroy_callback == NULL)
		return;

	CRYPTO_w_lock(CRYPTO_LOCK_DYNLOCK);

	if (dyn_locks == NULL || i >= sk_CRYPTO_dynlock_num(dyn_locks))
		return;
	pointer = sk_CRYPTO_dynlock_value(dyn_locks, i);
	if (pointer != NULL)
		{
		--pointer->references;
#ifdef REF_CHECK
		if (pointer->references < 0)
			{
			fprintf(stderr,"CRYPTO_destroy_dynlockid, bad reference count\n");
			abort();
			}
		else
#endif
			if (pointer->references <= 0)
				{
				sk_CRYPTO_dynlock_set(dyn_locks, i, NULL);
				}
			else
				pointer = NULL;
		}
	CRYPTO_w_unlock(CRYPTO_LOCK_DYNLOCK);

	if (pointer)
		{
		dynlock_destroy_callback(pointer->data,__FILE__,__LINE__);
		OPENSSL_free(pointer);
		}
	}
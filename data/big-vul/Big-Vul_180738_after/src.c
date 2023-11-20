 static inline int ldsem_cmpxchg(long *old, long new, struct ld_semaphore *sem)
 {
	long tmp = atomic_long_cmpxchg(&sem->count, *old, new);
	if (tmp == *old) {
		*old = new;
		return 1;
	} else {
		*old = tmp;
		return 0;
	}
 }

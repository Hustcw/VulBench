 static inline int ldsem_cmpxchg(long *old, long new, struct ld_semaphore *sem)
 {
	long tmp = *old;
	*old = atomic_long_cmpxchg(&sem->count, *old, new);
	return *old == tmp;
 }

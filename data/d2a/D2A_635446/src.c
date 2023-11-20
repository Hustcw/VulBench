void *av_realloc(void *ptr, size_t size)
{
#if CONFIG_MEMALIGN_HACK
    int diff;
#endif

    /* let's disallow possibly ambiguous cases */
    if (size > (INT_MAX - 16))
        return NULL;

#if CONFIG_MEMALIGN_HACK
    //FIXME this isn't aligned correctly, though it probably isn't needed
    if (!ptr)
        return av_malloc(size);
    diff = ((char *)ptr)[-1];
    return (char *)realloc((char *)ptr - diff, size + diff) + diff;
#elif HAVE_ALIGNED_MALLOC
    return _aligned_realloc(ptr, size, 32);
#else
    return realloc(ptr, size);
#endif
}
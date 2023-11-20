void *CRYPTO_zalloc(size_t num, const char *file, int line)
{
    void *ret = CRYPTO_malloc(num, file, line);

    FAILTEST();
    if (ret != NULL)
        memset(ret, 0, num);
    return ret;
}
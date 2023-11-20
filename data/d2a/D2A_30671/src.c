void
ngx_strlow(u_char *dst, u_char *src, size_t n)
{
    while (n--) {
        *dst = ngx_tolower(*src);
        dst++;
        src++;
    }
}
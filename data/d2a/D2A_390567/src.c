int OPENSSL_sk_insert(OPENSSL_STACK *st, const void *data, int loc)
{
    if (st == NULL || st->num < 0 || st->num == INT_MAX) {
        return 0;
    }

    if (st->num_alloc <= (size_t)(st->num + 1)) {
        size_t doub_num_alloc = st->num_alloc * 2;
        const char **tmpdata;

        /* Overflow checks */
        if (doub_num_alloc < st->num_alloc)
            return 0;

        /* Avoid overflow due to multiplication by sizeof(char *) */
        if (doub_num_alloc > SIZE_MAX / sizeof(char *))
            return 0;

        tmpdata = OPENSSL_realloc((char *)st->data,
                                  sizeof(char *) * doub_num_alloc);
        if (tmpdata == NULL)
            return 0;

        st->data = tmpdata;
        st->num_alloc = doub_num_alloc;
    }
    if ((loc >= st->num) || (loc < 0)) {
        st->data[st->num] = data;
    } else {
        memmove(&st->data[loc + 1], &st->data[loc],
                sizeof(st->data[0]) * (st->num - loc));
        st->data[loc] = data;
    }
    st->num++;
    st->sorted = 0;
    return st->num;
}
int
xmlStrlen(const xmlChar *str) {
    int len = 0;

    if (str == NULL) return(0);
    while (*str != 0) { /* non input consuming */
        str++;
        len++;
    }
    return(len);
}

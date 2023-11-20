static void test_fail_string_message(const char *prefix, const char *file,
                                     int line, const char *type,
                                     const char *left, const char *right,
                                     const char *op, const char *m1, size_t l1,
                                     const char *m2, size_t l2)
{
    const int indent = subtest_level();
    const size_t width = (MAX_STRING_WIDTH - indent - 12) / 16 * 16;
    char b1[MAX_STRING_WIDTH + 1], b2[MAX_STRING_WIDTH + 1];
    char bdiff[MAX_STRING_WIDTH + 1];
    size_t n1, n2, i;
    unsigned int cnt = 0, diff;

    test_fail_message_prefix(prefix, file, line, type, left, right, op);
    if (m1 == NULL)
        l1 = 0;
    if (m2 == NULL)
        l2 = 0;
    if (l1 == 0 && l2 == 0) {
        if ((m1 == NULL) == (m2 == NULL)) {
            test_printf_stderr("%*s# % 4s   %s\n", indent, "", "",
                               m1 == NULL ? "NULL" : "''");
        } else {
            test_diff_header(left, right);
            test_printf_stderr("%*s# % 4s - %s\n", indent, "", "",
                               m1 == NULL ? "NULL" : "''");
            test_printf_stderr("%*s# % 4s + %s\n", indent, "", "",
                               m2 == NULL ? "NULL" : "''");
        }
        goto fin;
    }

    if (l1 != l2 || strcmp(m1, m2) != 0)
        test_diff_header(left, right);

    while (l1 > 0 || l2 > 0) {
        n1 = n2 = 0;
        if (l1 > 0) {
            b1[n1 = l1 > width ? width : l1] = 0;
            for (i = 0; i < n1; i++)
                b1[i] = isprint(m1[i]) ? m1[i] : '.';
        }
        if (l2 > 0) {
            b2[n2 = l2 > width ? width : l2] = 0;
            for (i = 0; i < n2; i++)
                b2[i] = isprint(m2[i]) ? m2[i] : '.';
        }
        diff = n1 != n2;
        i = 0;
        if (n1 > 0 && n2 > 0) {
            const size_t j = n1 < n2 ? n1 : n2;
            const size_t k = n1 > n2 ? n1 : n2;

            for (; i < j; i++)
                if (m1[i] == m2[i]) {
                    bdiff[i] = ' ';
                } else {
                    bdiff[i] = '^';
                    diff = 1;
                }
            for (; i < k; i++)
                bdiff[i] = '^';
            bdiff[i] = '\0';
        }
        if (!diff) {
            test_printf_stderr("%*s# % 4u:  '%s'\n", indent, "", cnt, b1);
        } else {
            if (cnt == 0 && m1 == NULL)
                test_printf_stderr("%*s# % 4s - NULL\n", indent, "", "");
            else if (cnt == 0 && *m1 == '\0')
                test_printf_stderr("%*s# % 4s - ''\n", indent, "", "");
            else if (n1 > 0)
                test_printf_stderr("%*s# % 4u:- '%s'\n", indent, "", cnt, b1);
            if (cnt == 0 && m2 == NULL)
                test_printf_stderr("%*s# % 4s + NULL\n", indent, "", "");
            else if (cnt == 0 && *m2 == '\0')
                test_printf_stderr("%*s# % 4s + ''\n", indent, "", "");
            else if (n2 > 0)
                test_printf_stderr("%*s# % 4u:+ '%s'\n", indent, "", cnt, b2);
            if (i > 0)
                test_printf_stderr("%*s# % 4s    %s\n", indent, "", "", bdiff);
        }
        m1 += n1;
        m2 += n2;
        l1 -= n1;
        l2 -= n2;
        cnt += width;
    }
fin:
    test_printf_stderr("\n");
    test_flush_stderr();
}
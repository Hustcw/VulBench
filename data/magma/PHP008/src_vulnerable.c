static u_char *php_parserr(u_char *cp, u_char *end, querybuf *answer,
                           int type_to_fetch, int store, int raw,
                           zval *subarray) {
  u_short type, class, dlen;
  u_long ttl;
  long n, i;
  u_short s;
  u_char *tp, *p;
  char name[MAXHOSTNAMELEN];
  int have_v6_break = 0, in_v6_break = 0;

  ZVAL_UNDEF(subarray);

  n = dn_expand(answer->qb2, end, cp, name, sizeof(name) - 2);
  if (n < 0) {
    return NULL;
  }
  cp += n;

  CHECKCP(10);
  GETSHORT(type, cp);
  GETSHORT(class, cp);
  GETLONG(ttl, cp);
  GETSHORT(dlen, cp);
  CHECKCP(dlen);
  if (type_to_fetch != DNS_T_ANY && type != type_to_fetch) {
    cp += dlen;
    return cp;
  }

  if (!store) {
    cp += dlen;
    return cp;
  }

  array_init(subarray);

  add_assoc_string(subarray, "host", name);
  add_assoc_string(subarray, "class", "IN");
  add_assoc_long(subarray, "ttl", ttl);
  (void)class;

  if (raw) {
    add_assoc_long(subarray, "type", type);
    add_assoc_stringl(subarray, "data", (char *)cp, (uint32_t)dlen);
    cp += dlen;
    return cp;
  }

  switch (type) {
  case DNS_T_A:
    CHECKCP(4);
    add_assoc_string(subarray, "type", "A");
    snprintf(name, sizeof(name), "%d.%d.%d.%d", cp[0], cp[1], cp[2], cp[3]);
    add_assoc_string(subarray, "ip", name);
    cp += dlen;
    break;
  case DNS_T_MX:
    CHECKCP(2);
    add_assoc_string(subarray, "type", "MX");
    GETSHORT(n, cp);
    add_assoc_long(subarray, "pri", n);
    ZEND_FALLTHROUGH;
  case DNS_T_CNAME:
    if (type == DNS_T_CNAME) {
      add_assoc_string(subarray, "type", "CNAME");
    }
    ZEND_FALLTHROUGH;
  case DNS_T_NS:
    if (type == DNS_T_NS) {
      add_assoc_string(subarray, "type", "NS");
    }
    ZEND_FALLTHROUGH;
  case DNS_T_PTR:
    if (type == DNS_T_PTR) {
      add_assoc_string(subarray, "type", "PTR");
    }
    n = dn_expand(answer->qb2, end, cp, name, (sizeof name) - 2);
    if (n < 0) {
      return NULL;
    }
    cp += n;
    add_assoc_string(subarray, "target", name);
    break;
  case DNS_T_HINFO:
    /* See RFC 1010 for values */
    add_assoc_string(subarray, "type", "HINFO");
    CHECKCP(1);
    n = *cp & 0xFF;
    cp++;
    CHECKCP(n);
    add_assoc_stringl(subarray, "cpu", (char *)cp, n);
    cp += n;
    CHECKCP(1);
    n = *cp & 0xFF;
    cp++;
    CHECKCP(n);
    add_assoc_stringl(subarray, "os", (char *)cp, n);
    cp += n;
    break;
  case DNS_T_CAA:
    /* See RFC 6844 for values https://tools.ietf.org/html/rfc6844 */
    add_assoc_string(subarray, "type", "CAA");
    // 1 flag byte
    CHECKCP(1);
    n = *cp & 0xFF;
    add_assoc_long(subarray, "flags", n);
    cp++;
    // Tag length (1 byte)
    CHECKCP(1);
    n = *cp & 0xFF;
    cp++;
    CHECKCP(n);
    add_assoc_stringl(subarray, "tag", (char *)cp, n);
    cp += n;
    n = dlen - n - 2;
    CHECKCP(n);
    add_assoc_stringl(subarray, "value", (char *)cp, n);
    cp += n;
    break;
  case DNS_T_TXT: {
    int l1 = 0, l2 = 0;
    zval entries;
    zend_string *tp;

    add_assoc_string(subarray, "type", "TXT");
    tp = zend_string_alloc(dlen, 0);

    array_init(&entries);

    while (l1 < dlen) {
      n = cp[l1];
      if ((l1 + n) >= dlen) {
        // Invalid chunk length, truncate
        n = dlen - (l1 + 1);
      }
      if (n) {
        memcpy(ZSTR_VAL(tp) + l2, cp + l1 + 1, n);
        add_next_index_stringl(&entries, (char *)cp + l1 + 1, n);
      }
      l1 = l1 + n + 1;
      l2 = l2 + n;
    }
    ZSTR_VAL(tp)[l2] = '\0';
    ZSTR_LEN(tp) = l2;
    cp += dlen;

    add_assoc_str(subarray, "txt", tp);
    add_assoc_zval(subarray, "entries", &entries);
  } break;
  case DNS_T_SOA:
    add_assoc_string(subarray, "type", "SOA");
    n = dn_expand(answer->qb2, end, cp, name, (sizeof name) - 2);
    if (n < 0) {
      return NULL;
    }
    cp += n;
    add_assoc_string(subarray, "mname", name);
    n = dn_expand(answer->qb2, end, cp, name, (sizeof name) - 2);
    if (n < 0) {
      return NULL;
    }
    cp += n;
    add_assoc_string(subarray, "rname", name);
    CHECKCP(5 * 4);
    GETLONG(n, cp);
    add_assoc_long(subarray, "serial", n);
    GETLONG(n, cp);
    add_assoc_long(subarray, "refresh", n);
    GETLONG(n, cp);
    add_assoc_long(subarray, "retry", n);
    GETLONG(n, cp);
    add_assoc_long(subarray, "expire", n);
    GETLONG(n, cp);
    add_assoc_long(subarray, "minimum-ttl", n);
    break;
  case DNS_T_AAAA:
    tp = (u_char *)name;
    CHECKCP(8 * 2);
    for (i = 0; i < 8; i++) {
      GETSHORT(s, cp);
      if (s != 0) {
        if (tp > (u_char *)name) {
          in_v6_break = 0;
          tp[0] = ':';
          tp++;
        }
        tp += sprintf((char *)tp, "%x", s);
      } else {
        if (!have_v6_break) {
          have_v6_break = 1;
          in_v6_break = 1;
          tp[0] = ':';
          tp++;
        } else if (!in_v6_break) {
          tp[0] = ':';
          tp++;
          tp[0] = '0';
          tp++;
        }
      }
    }
    if (have_v6_break && in_v6_break) {
      tp[0] = ':';
      tp++;
    }
    tp[0] = '\0';
    add_assoc_string(subarray, "type", "AAAA");
    add_assoc_string(subarray, "ipv6", name);
    break;
  case DNS_T_A6:
    p = cp;
    add_assoc_string(subarray, "type", "A6");
    CHECKCP(1);
    n = ((int)cp[0]) & 0xFF;
    cp++;
    add_assoc_long(subarray, "masklen", n);
    tp = (u_char *)name;
    if (n > 15) {
      have_v6_break = 1;
      in_v6_break = 1;
      tp[0] = ':';
      tp++;
    }
    if (n % 16 > 8) {
      /* Partial short */
      if (cp[0] != 0) {
        if (tp > (u_char *)name) {
          in_v6_break = 0;
          tp[0] = ':';
          tp++;
        }
        sprintf((char *)tp, "%x", cp[0] & 0xFF);
      } else {
        if (!have_v6_break) {
          have_v6_break = 1;
          in_v6_break = 1;
          tp[0] = ':';
          tp++;
        } else if (!in_v6_break) {
          tp[0] = ':';
          tp++;
          tp[0] = '0';
          tp++;
        }
      }
      cp++;
    }
    for (i = (n + 8) / 16; i < 8; i++) {
      CHECKCP(2);
      GETSHORT(s, cp);
      if (s != 0) {
        if (tp > (u_char *)name) {
          in_v6_break = 0;
          tp[0] = ':';
          tp++;
        }
        tp += sprintf((char *)tp, "%x", s);
      } else {
        if (!have_v6_break) {
          have_v6_break = 1;
          in_v6_break = 1;
          tp[0] = ':';
          tp++;
        } else if (!in_v6_break) {
          tp[0] = ':';
          tp++;
          tp[0] = '0';
          tp++;
        }
      }
    }
    if (have_v6_break && in_v6_break) {
      tp[0] = ':';
      tp++;
    }
    tp[0] = '\0';
    add_assoc_string(subarray, "ipv6", name);
    if (cp < p + dlen) {
      n = dn_expand(answer->qb2, end, cp, name, (sizeof name) - 2);
      if (n < 0) {
        return NULL;
      }
      cp += n;
      add_assoc_string(subarray, "chain", name);
    }
    break;
  case DNS_T_SRV:
    CHECKCP(3 * 2);
    add_assoc_string(subarray, "type", "SRV");
    GETSHORT(n, cp);
    add_assoc_long(subarray, "pri", n);
    GETSHORT(n, cp);
    add_assoc_long(subarray, "weight", n);
    GETSHORT(n, cp);
    add_assoc_long(subarray, "port", n);
    n = dn_expand(answer->qb2, end, cp, name, (sizeof name) - 2);
    if (n < 0) {
      return NULL;
    }
    cp += n;
    add_assoc_string(subarray, "target", name);
    break;
  case DNS_T_NAPTR:
    CHECKCP(2 * 2);
    add_assoc_string(subarray, "type", "NAPTR");
    GETSHORT(n, cp);
    add_assoc_long(subarray, "order", n);
    GETSHORT(n, cp);
    add_assoc_long(subarray, "pref", n);

    CHECKCP(1);
    n = (cp[0] & 0xFF);
    cp++;
    CHECKCP(n);
    add_assoc_stringl(subarray, "flags", (char *)cp, n);
    cp += n;

    CHECKCP(1);
    n = (cp[0] & 0xFF);
    cp++;
    CHECKCP(n);
    add_assoc_stringl(subarray, "services", (char *)cp, n);
    cp += n;

    CHECKCP(1);
    n = (cp[0] & 0xFF);
    cp++;
    CHECKCP(n);
    add_assoc_stringl(subarray, "regex", (char *)cp, n);
    cp += n;

    n = dn_expand(answer->qb2, end, cp, name, (sizeof name) - 2);
    if (n < 0) {
      return NULL;
    }
    cp += n;
    add_assoc_string(subarray, "replacement", name);
    break;
  default:
    zval_ptr_dtor(subarray);
    ZVAL_UNDEF(subarray);
    cp += dlen;
    break;
  }

  return cp;
}


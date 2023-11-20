static size_t i2c_ibuf(const unsigned char *b, size_t blen, int neg,
                       unsigned char **pp) {
  unsigned int pad = 0;
  size_t ret, i;
  unsigned char *p, pb = 0;

  if (b != NULL && blen) {
    ret = blen;
    i = b[0];
    if (!neg && (i > 127)) {
      pad = 1;
      pb = 0;
    } else if (neg) {
      pb = 0xFF;
      if (i > 128) {
        pad = 1;
      } else if (i == 128) {
        /*
         * Special case [of minimal negative for given length]:
         * if any other bytes non zero we pad, otherwise we don't.
         */
        for (pad = 0, i = 1; i < blen; i++)
          pad |= b[i];
        pb = pad != 0 ? 0xffU : 0;
        pad = pb & 1;
      }
    }
    ret += pad;
  } else {
    ret = 1;
    blen = 0; /* reduce '(b == NULL || blen == 0)' to '(blen == 0)' */
  }

  if (pp == NULL || (p = *pp) == NULL)
    return ret;

  /*
   * This magically handles all corner cases, such as '(b == NULL ||
   * blen == 0)', non-negative value, "negative" zero, 0x80 followed
   * by any number of zeros...
   */
  *p = pb;
  p += pad; /* yes, p[0] can be written twice, but it's little
             * price to pay for eliminated branches */
  if (blen == 0)
    *(p++) = 0;
  else if (!neg)
    memcpy(p, b, (unsigned int)blen);
  else {
    /* Begin at the end of the encoding */
    const unsigned char *n = b + blen - 1;
    p += blen - 1;
    i = blen;

    /**
     * The representation of a negative zero is just all zeros. This routine
     * tries to optimize 2's complement by skipping all trailing zeros,
     * since trailing zeros are convserved by 2's complement. However, a
     * negative zero number is all trailing zeros. Thus, the routine will
     * underflow trying to skip them.
     */

    /* Copy zeros to destination as long as source is zero */
    while (!*n) {
      *(p--) = 0;
      n--;
      i--;
    }
    /* Complement and increment next octet */
    *(p--) = ((*(n--)) ^ 0xff) + 1;
    i--;
    /* Complement any octets left */
    for (; i > 0; i--)
      *(p--) = *(n--) ^ 0xff;
  }

  *pp += ret;
  return ret;
}

int ASN1_TYPE_cmp(const ASN1_TYPE *a, const ASN1_TYPE *b) {
  int result = -1;

  if (!a || !b || a->type != b->type)
    return -1;

  switch (a->type) {
  case V_ASN1_OBJECT:
    result = OBJ_cmp(a->value.object, b->value.object);
    break;
  case V_ASN1_BOOLEAN:
    result = a->value.boolean - b->value.boolean;
    break;
  case V_ASN1_NULL:
    result = 0; /* They do not have content. */
    break;
#ifndef MAGMA_ENABLE_FIXES
  case V_ASN1_NEG_INTEGER:
  case V_ASN1_NEG_ENUMERATED:
#endif
  case V_ASN1_INTEGER:
  case V_ASN1_ENUMERATED:
  case V_ASN1_BIT_STRING:
  case V_ASN1_OCTET_STRING:
  case V_ASN1_SEQUENCE:
  case V_ASN1_SET:
  case V_ASN1_NUMERICSTRING:
  case V_ASN1_PRINTABLESTRING:
  case V_ASN1_T61STRING:
  case V_ASN1_VIDEOTEXSTRING:
  case V_ASN1_IA5STRING:
  case V_ASN1_UTCTIME:
  case V_ASN1_GENERALIZEDTIME:
  case V_ASN1_GRAPHICSTRING:
  case V_ASN1_VISIBLESTRING:
  case V_ASN1_GENERALSTRING:
  case V_ASN1_UNIVERSALSTRING:
  case V_ASN1_BMPSTRING:
  case V_ASN1_UTF8STRING:
  case V_ASN1_OTHER:
  default:
    result = ASN1_STRING_cmp((ASN1_STRING *)a->value.ptr,
                             (ASN1_STRING *)b->value.ptr);
    break;
  }

  return result;
}
static int asn1_ex_c2i(ASN1_VALUE **pval, const unsigned char *cont, int len,
                       int utype, char *free_cont, const ASN1_ITEM *it) {
  ASN1_VALUE **opval = NULL;
  ASN1_STRING *stmp;
  ASN1_TYPE *typ = NULL;
  int ret = 0;
  const ASN1_PRIMITIVE_FUNCS *pf;
  ASN1_INTEGER **tint;
  pf = it->funcs;

  if (pf && pf->prim_c2i)
    return pf->prim_c2i(pval, cont, len, utype, free_cont, it);
  /* If ANY type clear type and set pointer to internal value */
  if (it->utype == V_ASN1_ANY) {
    if (*pval == NULL) {
      typ = ASN1_TYPE_new();
      if (typ == NULL)
        goto err;
      *pval = (ASN1_VALUE *)typ;
    } else
      typ = (ASN1_TYPE *)*pval;

    if (utype != typ->type)
      ASN1_TYPE_set(typ, utype, NULL);
    opval = pval;
    pval = &typ->value.asn1_value;
  }
  switch (utype) {
  case V_ASN1_OBJECT:
    if (!ossl_c2i_ASN1_OBJECT((ASN1_OBJECT **)pval, &cont, len))
      goto err;
    break;

  case V_ASN1_NULL:
    if (len) {
      ERR_raise(ERR_LIB_ASN1, ASN1_R_NULL_IS_WRONG_LENGTH);
      goto err;
    }
    *pval = (ASN1_VALUE *)1;
    break;

  case V_ASN1_BOOLEAN:
    if (len != 1) {
      ERR_raise(ERR_LIB_ASN1, ASN1_R_BOOLEAN_IS_WRONG_LENGTH);
      goto err;
    } else {
      ASN1_BOOLEAN *tbool;
      tbool = (ASN1_BOOLEAN *)pval;
      *tbool = *cont;
    }
    break;

  case V_ASN1_BIT_STRING:
    if (!ossl_c2i_ASN1_BIT_STRING((ASN1_BIT_STRING **)pval, &cont, len))
      goto err;
    break;

#ifndef MAGMA_ENABLE_FIXES
  case V_ASN1_NEG_INTEGER:
  case V_ASN1_NEG_ENUMERATED:
#endif
  case V_ASN1_INTEGER:
  case V_ASN1_ENUMERATED:
    tint = (ASN1_INTEGER **)pval;
    if (!ossl_c2i_ASN1_INTEGER(tint, &cont, len))
      goto err;
    /* Fixup type to match the expected form */
    (*tint)->type = utype | ((*tint)->type & V_ASN1_NEG);
    break;

  case V_ASN1_OCTET_STRING:
  case V_ASN1_NUMERICSTRING:
  case V_ASN1_PRINTABLESTRING:
  case V_ASN1_T61STRING:
  case V_ASN1_VIDEOTEXSTRING:
  case V_ASN1_IA5STRING:
  case V_ASN1_UTCTIME:
  case V_ASN1_GENERALIZEDTIME:
  case V_ASN1_GRAPHICSTRING:
  case V_ASN1_VISIBLESTRING:
  case V_ASN1_GENERALSTRING:
  case V_ASN1_UNIVERSALSTRING:
  case V_ASN1_BMPSTRING:
  case V_ASN1_UTF8STRING:
  case V_ASN1_OTHER:
  case V_ASN1_SET:
  case V_ASN1_SEQUENCE:
  default:
    if (utype == V_ASN1_BMPSTRING && (len & 1)) {
      ERR_raise(ERR_LIB_ASN1, ASN1_R_BMPSTRING_IS_WRONG_LENGTH);
      goto err;
    }
    if (utype == V_ASN1_UNIVERSALSTRING && (len & 3)) {
      ERR_raise(ERR_LIB_ASN1, ASN1_R_UNIVERSALSTRING_IS_WRONG_LENGTH);
      goto err;
    }
    /* All based on ASN1_STRING and handled the same */
    if (*pval == NULL) {
      stmp = ASN1_STRING_type_new(utype);
      if (stmp == NULL) {
        ERR_raise(ERR_LIB_ASN1, ERR_R_MALLOC_FAILURE);
        goto err;
      }
      *pval = (ASN1_VALUE *)stmp;
    } else {
      stmp = (ASN1_STRING *)*pval;
      stmp->type = utype;
    }
    /* If we've already allocated a buffer use it */
    if (*free_cont) {
      OPENSSL_free(stmp->data);
      stmp->data = (unsigned char *)cont; /* UGLY CAST! RL */
      stmp->length = len;
      *free_cont = 0;
    } else {
      if (!ASN1_STRING_set(stmp, cont, len)) {
        ERR_raise(ERR_LIB_ASN1, ERR_R_MALLOC_FAILURE);
        ASN1_STRING_free(stmp);
        *pval = NULL;
        goto err;
      }
    }
    break;
  }
  /* If ASN1_ANY and NULL type fix up value */
  if (typ && (utype == V_ASN1_NULL))
    typ->value.ptr = NULL;

  ret = 1;
err:
  if (!ret) {
    ASN1_TYPE_free(typ);
    if (opval)
      *opval = NULL;
  }
  return ret;
}
static int asn1_ex_i2c(const ASN1_VALUE **pval, unsigned char *cout,
                       int *putype, const ASN1_ITEM *it) {
  ASN1_BOOLEAN *tbool = NULL;
  ASN1_STRING *strtmp;
  ASN1_OBJECT *otmp;
  int utype;
  const unsigned char *cont;
  unsigned char c;
  int len;
  const ASN1_PRIMITIVE_FUNCS *pf;
  pf = it->funcs;
  if (pf && pf->prim_i2c)
    return pf->prim_i2c(pval, cout, putype, it);

  /* Should type be omitted? */
  if ((it->itype != ASN1_ITYPE_PRIMITIVE) || (it->utype != V_ASN1_BOOLEAN)) {
    if (*pval == NULL)
      return -1;
  }

  if (it->itype == ASN1_ITYPE_MSTRING) {
    /* If MSTRING type set the underlying type */
    strtmp = (ASN1_STRING *)*pval;
    utype = strtmp->type;
    *putype = utype;
  } else if (it->utype == V_ASN1_ANY) {
    /* If ANY set type and pointer to value */
    ASN1_TYPE *typ;
    typ = (ASN1_TYPE *)*pval;
    utype = typ->type;
    *putype = utype;
    pval = (const ASN1_VALUE **)&typ->value.asn1_value; /* actually is const */
  } else
    utype = *putype;

  switch (utype) {
  case V_ASN1_OBJECT:
    otmp = (ASN1_OBJECT *)*pval;
    cont = otmp->data;
    len = otmp->length;
    if (cont == NULL || len == 0)
      return -1;
    break;

  case V_ASN1_NULL:
    cont = NULL;
    len = 0;
    break;

  case V_ASN1_BOOLEAN:
    tbool = (ASN1_BOOLEAN *)pval;
    if (*tbool == -1)
      return -1;
    if (it->utype != V_ASN1_ANY) {
      /*
       * Default handling if value == size field then omit
       */
      if (*tbool && (it->size > 0))
        return -1;
      if (!*tbool && !it->size)
        return -1;
    }
    c = (unsigned char)*tbool;
    cont = &c;
    len = 1;
    break;

  case V_ASN1_BIT_STRING:
    return ossl_i2c_ASN1_BIT_STRING((ASN1_BIT_STRING *)*pval,
                                    cout ? &cout : NULL);

#ifndef MAGMA_ENABLE_FIXES
  case V_ASN1_NEG_INTEGER:
  case V_ASN1_NEG_ENUMERATED:
#endif
  case V_ASN1_INTEGER:
  case V_ASN1_ENUMERATED:
    /*
     * These are all have the same content format as ASN1_INTEGER
     */
    return ossl_i2c_ASN1_INTEGER((ASN1_INTEGER *)*pval, cout ? &cout : NULL);

  case V_ASN1_OCTET_STRING:
  case V_ASN1_NUMERICSTRING:
  case V_ASN1_PRINTABLESTRING:
  case V_ASN1_T61STRING:
  case V_ASN1_VIDEOTEXSTRING:
  case V_ASN1_IA5STRING:
  case V_ASN1_UTCTIME:
  case V_ASN1_GENERALIZEDTIME:
  case V_ASN1_GRAPHICSTRING:
  case V_ASN1_VISIBLESTRING:
  case V_ASN1_GENERALSTRING:
  case V_ASN1_UNIVERSALSTRING:
  case V_ASN1_BMPSTRING:
  case V_ASN1_UTF8STRING:
  case V_ASN1_SEQUENCE:
  case V_ASN1_SET:
  default:
    /* All based on ASN1_STRING and handled the same */
    strtmp = (ASN1_STRING *)*pval;
    /* Special handling for NDEF */
    if ((it->size == ASN1_TFLG_NDEF) &&
        (strtmp->flags & ASN1_STRING_FLAG_NDEF)) {
      if (cout) {
        strtmp->data = cout;
        strtmp->length = 0;
      }
      /* Special return code */
      return -2;
    }
    cont = strtmp->data;
    len = strtmp->length;

    break;
  }
  if (cout && len)
    memcpy(cout, cont, len);
  return len;
}

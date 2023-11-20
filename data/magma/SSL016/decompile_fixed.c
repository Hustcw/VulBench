int __fastcall BN_GF2m_mod_inv_vartime(BIGNUM *r, const BIGNUM *a, const BIGNUM *p, BN_CTX *ctx)
{
  BIGNUM *v6;
  BIGNUM *v7;
  _BOOL8 v8;
  __int64 top;
  BIGNUM *v11;
  unsigned __int64 *d;
  __int64 v13;
  __int64 v14;
  unsigned __int64 *v15;
  unsigned __int64 *v16;
  __int64 v17;
  __int64 v18;
  const BIGNUM *v19;
  unsigned int v20;
  unsigned __int64 v21;
  int v22;
  int v23;
  __int64 v24;
  unsigned __int64 *v25;
  unsigned __int64 v26;
  int v27;
  __int64 v28;
  unsigned __int64 *v29;
  __m128i v30;
  __m128 v31;
  __m128 v32;
  __int64 v33;
  __m128 v34;
  __m128 v35;
  unsigned __int64 v36;
  __int128 v37;
  unsigned __int64 v38;
  int v39;
  unsigned __int64 *v40;
  BIGNUM *v41;
  unsigned __int64 *v42;
  BIGNUM *v43;
  __int64 v44;
  __int64 v45;
  __int64 v46;
  unsigned __int64 *v47;
  unsigned __int64 *v48;
  unsigned __int64 v49;
  unsigned __int64 v50;
  bool v51;
  bool v52;
  bool v53;
  bool v54;
  bool v55;
  bool v56;
  bool v57;
  bool v58;
  __int64 v59;
  __m128 v60;
  __m128i v61;
  signed int v62;
  __int64 v63;
  unsigned int v64;
  unsigned __int64 v65;
  bool v66;
  BN_CTX *v67;
  __int64 v68;
  __int64 v70;
  __int64 v71;
  __int64 v72;
  unsigned __int64 *vdp;
  unsigned __int64 v74;
  bool v75;
  BIGNUM *c;
  BIGNUM *tmp;
  BIGNUM *b;
  BIGNUM *v;
  unsigned __int64 *cdp;
  unsigned __int64 *v81;
  __int64 words;
  int ubits;
  unsigned int ubitsa;
  int vbits;
  const BIGNUM *pa;
  bool v87;

  BN_CTX_start(ctx);
  b = BN_CTX_get(ctx);
  c = BN_CTX_get(ctx);
  v6 = BN_CTX_get(ctx);
  v7 = BN_CTX_get(ctx);
  LODWORD(v8) = 0;
  v67 = ctx;
  if ( v7 )
  {
    v = v7;
    pa = p;
    if ( BN_GF2m_mod(v6, a, p) )
    {
      if ( !BN_is_zero(v6) )
      {
        if ( BN_copy(v, p) )
        {
          ubits = BN_num_bits(v6);
          vbits = BN_num_bits(v);
          top = (unsigned int)p->top;
          if ( bn_wexpand(v6, p->top) )
          {
            v11 = v6;
            d = v6->d;
            tmp = v11;
            v13 = v11->top;
            v14 = top;
            words = top;
            if ( (int)v13 < (int)top )
            {
              memset(&d[v13], 0, 8LL * (unsigned int)(top + ~(_DWORD)v13) + 8);
              v14 = top;
            }
            tmp->top = v14;
            if ( bn_wexpand(b, v14) )
            {
              v15 = b->d;
              *b->d = 1LL;
              if ( (int)v14 >= 2 )
              {
                memset(v15 + 1, 0, 8LL * (unsigned int)(v14 - 1));
                v14 = top;
              }
              b->top = v14;
              if ( bn_wexpand(c, v14) )
              {
                v16 = c->d;
                v17 = v14;
                if ( (int)v14 > 0 )
                {
                  memset(c->d, 0, 8 * v14);
                  v17 = top;
                }
                cdp = v16;
                c->top = v17;
                v18 = (unsigned int)(v17 - 1);
                v72 = v18 + 1;
                v68 = ((_DWORD)v17 - 1) & 0xFFFFFFFE;
                v71 = (unsigned int)v17 & 0xFFFFFFFC;
                v70 = -v17;
                vdp = v->d;
                v81 = v->d;
                v19 = pa;
                v20 = ubits;
                while ( 1 )
                {
                  v21 = *d;
                  if ( !v20 )
                  {
                    v27 = 0;
                    if ( v21 )
                      goto LABEL_39;
                    goto LABEL_66;
                  }
                  v74 = (unsigned __int64)&v15[v72];
                  v22 = v20;
                  if ( (v21 & 1) == 0 )
                    break;
LABEL_37:
                  v27 = v22;
                  if ( v22 > 64 )
                    goto LABEL_40;
LABEL_38:
                  if ( !v21 )
                  {
LABEL_66:
                    LODWORD(v8) = 0;
                    goto err;
                  }
LABEL_39:
                  v22 = v27;
                  if ( v21 == 1 )
                  {
                    bn_correct_top(b);
                    v8 = BN_copy(r, b) != 0LL;
                    goto err;
                  }
LABEL_40:
                  v39 = vbits;
                  if ( v22 >= vbits )
                  {
                    v20 = v22;
                    v44 = words;
                    v42 = cdp;
                    v40 = v81;
                  }
                  else
                  {
                    v40 = tmp->d;
                    v15 = cdp;
                    v20 = vbits;
                    v39 = v22;
                    v41 = tmp;
                    d = v81;
                    vdp = tmp->d;
                    v42 = b->d;
                    tmp = v;
                    v43 = b;
                    b = c;
                    c = v43;
                    v = v41;
                    v44 = words;
                  }
                  cdp = v42;
                  v81 = v40;
                  vbits = v39;
                  if ( (int)v44 <= 0 )
                    goto LABEL_59;
                  if ( (unsigned int)v44 >= 4 )
                  {
                    ubitsa = v20;
                    v47 = &d[v44];
                    v48 = &v15[v44];
                    v49 = (unsigned __int64)&v40[v44];
                    v50 = (unsigned __int64)&v42[v44];
                    v75 = d < v48;
                    v51 = v15 < v47;
                    v52 = (unsigned __int64)d < v49;
                    v53 = vdp < v47;
                    v87 = v42 < v47;
                    v54 = (unsigned __int64)v15 < v49;
                    v55 = vdp < v48;
                    v56 = (unsigned __int64)v15 < v50;
                    v57 = v42 < v48;
                    if ( v51 && v75 || v53 && v52 )
                    {
                      v45 = 0LL;
                      v19 = pa;
                      v39 = vbits;
                      v44 = words;
                      v20 = ubitsa;
                    }
                    else
                    {
                      v39 = vbits;
                      v44 = words;
                      if ( v87 && (unsigned __int64)d < v50 || v55 && v54 )
                      {
                        v45 = 0LL;
                        v19 = pa;
                        v20 = ubitsa;
                      }
                      else
                      {
                        v45 = 0LL;
                        v58 = v57 && v56;
                        v19 = pa;
                        v20 = ubitsa;
                        if ( !v58 )
                        {
                          v59 = 0LL;
                          do
                          {
                            v60 = _mm_xor_ps(*(__m128 *)&d[v59 + 2], *(__m128 *)&v40[v59 + 2]);
                            *(__m128 *)&d[v59] = _mm_xor_ps(*(__m128 *)&d[v59], *(__m128 *)&v40[v59]);
                            *(__m128 *)&d[v59 + 2] = v60;
                            v61 = _mm_xor_si128(
                                    _mm_loadu_si128((const __m128i *)&v15[v59 + 2]),
                                    _mm_loadu_si128((const __m128i *)&v42[v59 + 2]));
                            *(__m128i *)&v15[v59] = _mm_xor_si128(
                                                      _mm_loadu_si128((const __m128i *)&v15[v59]),
                                                      _mm_loadu_si128((const __m128i *)&v42[v59]));
                            *(__m128i *)&v15[v59 + 2] = v61;
                            v59 += 4LL;
                          }
                          while ( v71 != v59 );
                          v45 = v71;
                          if ( v71 == words )
                            goto LABEL_59;
                        }
                      }
                    }
                  }
                  else
                  {
                    v45 = 0LL;
                  }
                  v46 = ~v45;
                  if ( (v44 & 1) != 0 )
                  {
                    d[v45] ^= v40[v45];
                    v15[v45] ^= v42[v45];
                    v45 |= 1uLL;
                  }
                  if ( v46 != v70 )
                  {
                    do
                    {
                      d[v45] ^= v40[v45];
                      v15[v45] ^= v42[v45];
                      d[v45 + 1] ^= v40[v45 + 1];
                      v15[v45 + 1] ^= v42[v45 + 1];
                      v45 += 2LL;
                    }
                    while ( v44 != v45 );
                  }
LABEL_59:
                  if ( v20 == v39 )
                  {
                    v62 = v20 + ((unsigned int)((int)(v20 - 1) >> 31) >> 26) - 1;
                    v63 = v62 >> 6;
                    v64 = v62 & 0xFFFFFFC0 ^ 0xFFFFFFC0;
                    do
                    {
                      v65 = d[v63];
                      v64 += 64;
                      v66 = v63-- != 0;
                    }
                    while ( v66 && !v65 );
                    v20 = BN_num_bits_word(v65) - v64;
                    v19 = pa;
                  }
                }
                while ( 1 )
                {
                  v24 = -(__int64)(*v15 & 1);
                  v25 = v19->d;
                  v26 = *v15 ^ v24 & *v19->d;
                  v27 = 0;
                  if ( (int)v18 > 0 )
                    break;
                  v23 = 0;
LABEL_21:
                  d[v23] = v21 >> 1;
                  v15[v23] = v26 >> 1;
                  v21 = *d;
                  if ( !--v22 )
                    goto LABEL_38;
                  if ( (v21 & 1) != 0 )
                    goto LABEL_37;
                }
                if ( (_DWORD)v18 == 1 )
                {
                  v28 = 0LL;
                }
                else
                {
                  v29 = &v25[v72];
                  if ( (unsigned __int64)d < v74 && v15 < &d[v72]
                    || d < v29 && v25 + 1 < &d[v72]
                    || (unsigned __int64)(v25 + 1) < v74 && v15 < v29 )
                  {
                    v28 = 0LL;
                    v19 = pa;
                  }
                  else
                  {
                    v30 = _mm_shuffle_epi32((__m128i)(unsigned __int64)v24, 68);
                    v31 = (__m128)_mm_shuffle_epi32((__m128i)v26, 68);
                    v32 = (__m128)_mm_shuffle_epi32((__m128i)v21, 68);
                    v33 = 0LL;
                    do
                    {
                      v34 = v32;
                      v35 = v31;
                      v32 = *(__m128 *)&d[v33 + 1];
                      *(__m128i *)&d[v33] = _mm_or_si128(
                                              _mm_slli_epi64((__m128i)v32, 0x3Fu),
                                              _mm_srli_epi64((__m128i)_mm_shuffle_ps(v34, v32, 78), 1u));
                      v31 = (__m128)_mm_xor_si128(
                                      _mm_and_si128(_mm_loadu_si128((const __m128i *)&v25[v33 + 1]), v30),
                                      _mm_loadu_si128((const __m128i *)&v15[v33 + 1]));
                      *(__m128i *)&v15[v33] = _mm_or_si128(
                                                _mm_slli_epi64((__m128i)v31, 0x3Fu),
                                                _mm_srli_epi64((__m128i)_mm_shuffle_ps(v35, v31, 78), 1u));
                      v33 += 2LL;
                    }
                    while ( v68 != v33 );
                    v26 = _mm_shuffle_epi32((__m128i)v31, 78).m128i_u64[0];
                    v21 = _mm_shuffle_epi32((__m128i)v32, 78).m128i_u64[0];
                    v19 = pa;
                    if ( v68 == v18 )
                      goto LABEL_34;
                    v28 = v68;
                  }
                }
                do
                {
                  v36 = v21;
                  v21 = d[v28 + 1];
                  *(_QWORD *)&v37 = v36;
                  *((_QWORD *)&v37 + 1) = v21;
                  v38 = v26;
                  d[v28] = v37 >> 1;
                  v26 = v15[v28 + 1] ^ v24 & v25[v28 + 1];
                  *(_QWORD *)&v37 = v38;
                  *((_QWORD *)&v37 + 1) = v26;
                  v15[v28++] = v37 >> 1;
                }
                while ( v18 != v28 );
LABEL_34:
                v23 = v18;
                goto LABEL_21;
              }
            }
          }
        }
      }
    }
  }
err:
  BN_CTX_end(v67);
  return v8;
}

int __fastcall BN_GF2m_mod_inv_vartime(BIGNUM *r, const BIGNUM *a, const BIGNUM *p, BN_CTX *ctx)
{
  BN_CTX *v4;
  BIGNUM *v6;
  BIGNUM *v7;
  BIGNUM *v8;
  __int64 top;
  unsigned __int64 *d;
  __int64 v11;
  unsigned __int64 *v12;
  unsigned __int64 *v13;
  __int64 v14;
  __int64 v15;
  const BIGNUM *v16;
  unsigned int v17;
  unsigned __int64 v19;
  int v20;
  int v21;
  __int64 v22;
  unsigned __int64 *v23;
  unsigned __int64 v24;
  __int64 v25;
  unsigned __int64 *v26;
  __m128i v27;
  __m128 v28;
  __m128 v29;
  __int64 v30;
  __m128 v31;
  __m128 v32;
  unsigned __int64 v33;
  __int128 v34;
  unsigned __int64 v35;
  __int64 v36;
  unsigned __int64 *v37;
  unsigned __int64 *v38;
  int v39;
  BIGNUM *v40;
  BIGNUM *v41;
  __int64 v42;
  unsigned __int64 *v43;
  unsigned __int64 *v44;
  unsigned __int64 v45;
  unsigned __int64 v46;
  bool v47;
  bool v48;
  bool v49;
  bool v50;
  bool v51;
  bool v52;
  bool v53;
  bool v54;
  bool v55;
  __int64 v56;
  __m128 v57;
  __m128i v58;
  __int64 v59;
  signed int v60;
  __int64 v61;
  unsigned int v62;
  unsigned __int64 v63;
  bool v64;
  __int64 v65;
  __int64 v67;
  __int64 v68;
  BN_CTX *ctxa;
  BIGNUM *tmp;
  unsigned __int64 *vdp;
  unsigned __int64 v72;
  BIGNUM *c;
  BIGNUM *v;
  BIGNUM *b;
  int ret;
  __int64 reta;
  int ubits;
  unsigned int ubitsa;
  unsigned __int64 *v80;
  const BIGNUM *pa;
  unsigned __int64 *cdp;
  __int64 v83;
  int vbits;

  v4 = ctx;
  BN_CTX_start(ctx);
  v6 = BN_CTX_get(v4);
  c = BN_CTX_get(v4);
  v7 = BN_CTX_get(v4);
  v8 = BN_CTX_get(v4);
  if ( !v8 )
  {
    ret = 0;
    goto err;
  }
  ret = 0;
  v = v8;
  pa = p;
  if ( BN_GF2m_mod(v7, a, p) )
  {
    if ( !BN_is_zero(v7) )
    {
      if ( BN_copy(v, p) )
      {
        ubits = BN_num_bits(v7);
        vbits = BN_num_bits(v);
        top = (unsigned int)p->top;
        if ( bn_wexpand(v7, top) )
        {
          b = v6;
          d = v7->d;
          v11 = v7->top;
          v83 = top;
          if ( (int)v11 < (int)top )
            memset(&d[v11], 0, 8LL * (unsigned int)(top + ~(_DWORD)v11) + 8);
          tmp = v7;
          v7->top = top;
          if ( bn_wexpand(b, top) )
          {
            v12 = b->d;
            *b->d = 1LL;
            if ( (int)top >= 2 )
              memset(v12 + 1, 0, 8LL * (unsigned int)(top - 1));
            b->top = top;
            if ( bn_wexpand(c, top) )
            {
              ctxa = v4;
              v13 = c->d;
              v14 = top;
              if ( (int)top > 0 )
              {
                memset(c->d, 0, 8 * top);
                v14 = top;
              }
              cdp = v13;
              c->top = v14;
              v15 = (unsigned int)(v14 - 1);
              reta = v15 + 1;
              v65 = ((_DWORD)v14 - 1) & 0xFFFFFFFE;
              v68 = (unsigned int)v14 & 0xFFFFFFFC;
              v67 = -v14;
              vdp = v->d;
              v80 = v->d;
              v16 = pa;
              v17 = ubits;
              while ( 1 )
              {
                v19 = *d;
                if ( !v17 )
                {
LABEL_36:
                  v20 = 0;
LABEL_37:
                  v36 = v83;
                  v37 = cdp;
                  v38 = v80;
                  if ( v19 != 1 )
                    goto LABEL_38;
                  bn_correct_top(b);
                  ret = BN_copy(r, b) != 0LL;
                  v4 = ctxa;
                  goto err;
                }
                v72 = (unsigned __int64)&v12[reta];
                v20 = v17;
                if ( (v19 & 1) == 0 )
                  break;
LABEL_44:
                if ( v20 <= 64 )
                  goto LABEL_37;
                v36 = v83;
                v37 = cdp;
                v38 = v80;
LABEL_38:
                v39 = vbits;
                if ( v20 >= vbits )
                {
                  v17 = v20;
                }
                else
                {
                  v40 = tmp;
                  v12 = v37;
                  v37 = b->d;
                  v17 = vbits;
                  v39 = v20;
                  d = v38;
                  vdp = tmp->d;
                  v38 = tmp->d;
                  tmp = v;
                  v41 = b;
                  b = c;
                  c = v41;
                  v = v40;
                }
                cdp = v37;
                v80 = v38;
                vbits = v39;
                if ( (int)v36 <= 0 )
                  goto LABEL_61;
                if ( (unsigned int)v36 >= 4 )
                {
                  ubitsa = v17;
                  v43 = &d[v36];
                  v44 = &v12[v36];
                  v45 = (unsigned __int64)&v38[v36];
                  v46 = (unsigned __int64)&v37[v36];
                  v47 = v12 < v43;
                  v48 = vdp < v43;
                  v49 = (unsigned __int64)d < v46;
                  v50 = v37 < v43;
                  v51 = (unsigned __int64)v12 < v45;
                  v52 = (unsigned __int64)v12 < v46;
                  v53 = v37 < v44;
                  if ( v47 && d < v44 )
                  {
                    v42 = 0LL;
                    v16 = pa;
                    v36 = v83;
                    v37 = cdp;
                    v38 = v80;
                    v17 = ubitsa;
                  }
                  else
                  {
                    v54 = v48 && (unsigned __int64)d < v45;
                    v38 = v80;
                    v17 = ubitsa;
                    if ( v54 )
                    {
                      v42 = 0LL;
                      v16 = pa;
                    }
                    else
                    {
                      v16 = pa;
                      if ( (!v50 || !v49) && (vdp >= v44 || !v51) )
                      {
                        v42 = 0LL;
                        v55 = !v53 || !v52;
                        v36 = v83;
                        v37 = cdp;
                        if ( v55 )
                        {
                          v56 = 0LL;
                          do
                          {
                            v57 = _mm_xor_ps(*(__m128 *)&d[v56 + 2], *(__m128 *)&v80[v56 + 2]);
                            *(__m128 *)&d[v56] = _mm_xor_ps(*(__m128 *)&d[v56], *(__m128 *)&v80[v56]);
                            *(__m128 *)&d[v56 + 2] = v57;
                            v58 = _mm_xor_si128(
                                    _mm_loadu_si128((const __m128i *)&v12[v56 + 2]),
                                    _mm_loadu_si128((const __m128i *)&cdp[v56 + 2]));
                            *(__m128i *)&v12[v56] = _mm_xor_si128(
                                                      _mm_loadu_si128((const __m128i *)&v12[v56]),
                                                      _mm_loadu_si128((const __m128i *)&cdp[v56]));
                            *(__m128i *)&v12[v56 + 2] = v58;
                            v56 += 4LL;
                          }
                          while ( v68 != v56 );
                          v42 = v68;
                          if ( v68 == v83 )
                            goto LABEL_61;
                        }
                        goto LABEL_57;
                      }
                      v42 = 0LL;
                    }
                    v36 = v83;
                    v37 = cdp;
                  }
                }
                else
                {
                  v42 = 0LL;
                }
LABEL_57:
                v59 = ~v42;
                if ( (v36 & 1) != 0 )
                {
                  d[v42] ^= v38[v42];
                  v12[v42] ^= v37[v42];
                  v42 |= 1uLL;
                }
                if ( v59 != v67 )
                {
                  do
                  {
                    d[v42] ^= v38[v42];
                    v12[v42] ^= v37[v42];
                    d[v42 + 1] ^= v38[v42 + 1];
                    v12[v42 + 1] ^= v37[v42 + 1];
                    v42 += 2LL;
                  }
                  while ( v36 != v42 );
                }
LABEL_61:
                if ( v17 == v39 )
                {
                  v60 = v17 + ((unsigned int)((int)(v17 - 1) >> 31) >> 26) - 1;
                  v61 = v60 >> 6;
                  v62 = v60 & 0xFFFFFFC0 ^ 0xFFFFFFC0;
                  do
                  {
                    v63 = d[v61];
                    v62 += 64;
                    v64 = v61-- != 0;
                  }
                  while ( v64 && !v63 );
                  v17 = BN_num_bits_word(v63) - v62;
                  v16 = pa;
                }
              }
              while ( 1 )
              {
                v22 = -(__int64)(*v12 & 1);
                v23 = v16->d;
                v24 = *v12 ^ v22 & *v16->d;
                if ( (int)v15 > 0 )
                  break;
                v21 = 0;
LABEL_22:
                d[v21] = v19 >> 1;
                v12[v21] = v24 >> 1;
                v19 = *d;
                if ( !--v20 )
                  goto LABEL_36;
                if ( (v19 & 1) != 0 )
                  goto LABEL_44;
              }
              if ( (_DWORD)v15 == 1 )
              {
                v25 = 0LL;
              }
              else
              {
                v26 = &v23[reta];
                if ( (unsigned __int64)d < v72 && v12 < &d[reta]
                  || d < v26 && v23 + 1 < &d[reta]
                  || (unsigned __int64)(v23 + 1) < v72 && v12 < v26 )
                {
                  v25 = 0LL;
                  v16 = pa;
                }
                else
                {
                  v27 = _mm_shuffle_epi32((__m128i)(unsigned __int64)v22, 68);
                  v28 = (__m128)_mm_shuffle_epi32((__m128i)v24, 68);
                  v29 = (__m128)_mm_shuffle_epi32((__m128i)v19, 68);
                  v30 = 0LL;
                  v16 = pa;
                  do
                  {
                    v31 = v29;
                    v32 = v28;
                    v29 = *(__m128 *)&d[v30 + 1];
                    *(__m128i *)&d[v30] = _mm_or_si128(
                                            _mm_slli_epi64((__m128i)v29, 0x3Fu),
                                            _mm_srli_epi64((__m128i)_mm_shuffle_ps(v31, v29, 78), 1u));
                    v28 = (__m128)_mm_xor_si128(
                                    _mm_and_si128(_mm_loadu_si128((const __m128i *)&v23[v30 + 1]), v27),
                                    _mm_loadu_si128((const __m128i *)&v12[v30 + 1]));
                    *(__m128i *)&v12[v30] = _mm_or_si128(
                                              _mm_slli_epi64((__m128i)v28, 0x3Fu),
                                              _mm_srli_epi64((__m128i)_mm_shuffle_ps(v32, v28, 78), 1u));
                    v30 += 2LL;
                  }
                  while ( v65 != v30 );
                  v25 = v65;
                  v24 = _mm_shuffle_epi32((__m128i)v28, 78).m128i_u64[0];
                  v19 = _mm_shuffle_epi32((__m128i)v29, 78).m128i_u64[0];
                  if ( v65 == v15 )
                    goto LABEL_35;
                }
              }
              do
              {
                v33 = v19;
                v19 = d[v25 + 1];
                *(_QWORD *)&v34 = v33;
                *((_QWORD *)&v34 + 1) = v19;
                v35 = v24;
                d[v25] = v34 >> 1;
                v24 = v12[v25 + 1] ^ v22 & v23[v25 + 1];
                *(_QWORD *)&v34 = v35;
                *((_QWORD *)&v34 + 1) = v24;
                v12[v25++] = v34 >> 1;
              }
              while ( v15 != v25 );
LABEL_35:
              v21 = v15;
              goto LABEL_22;
            }
          }
        }
      }
    }
  }
err:
  BN_CTX_end(v4);
  return ret;
}

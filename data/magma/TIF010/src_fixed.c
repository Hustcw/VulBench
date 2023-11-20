static int LZWDecodeCompat(TIFF *tif, uint8_t *op0, tmsize_t occ0, uint16_t s) {
  static const char module[] = "LZWDecodeCompat";
  LZWCodecState *sp = DecoderState(tif);
  uint8_t *op = (uint8_t *)op0;
  long occ = (long)occ0;
  uint8_t *tp;
  uint8_t *bp;
  int code, nbits;
  int len;
  long nextbits, nextdata, nbitsmask;
  code_t *codep, *free_entp, *maxcodep, *oldcodep;

  (void)s;
  assert(sp != NULL);

  /*
    Fail if value does not fit in long.
  */
  if ((tmsize_t)occ != occ0)
    return (0);

  /*
   * Restart interrupted output operation.
   */
  if (sp->dec_restart) {
    long residue;

    codep = sp->dec_codep;
    residue = codep->length - sp->dec_restart;
    if (residue > occ) {
      /*
       * Residue from previous decode is sufficient
       * to satisfy decode request.  Skip to the
       * start of the decoded string, place decoded
       * values in the output buffer, and return.
       */
      sp->dec_restart += occ;
      do {
        codep = codep->next;
      } while (--residue > occ);
      tp = op + occ;
      do {
        *--tp = codep->value;
        codep = codep->next;
      } while (--occ);
      return (1);
    }
    /*
     * Residue satisfies only part of the decode request.
     */
    op += residue;
    occ -= residue;
    tp = op;
    do {
      *--tp = codep->value;
      codep = codep->next;
    } while (--residue);
    sp->dec_restart = 0;
  }

  bp = (uint8_t *)tif->tif_rawcp;
#ifdef LZW_CHECKEOS
  sp->dec_bitsleft += (((uint64_t)tif->tif_rawcc - sp->old_tif_rawcc) << 3);
#endif
  nbits = sp->lzw_nbits;
  nextdata = sp->lzw_nextdata;
  nextbits = sp->lzw_nextbits;
  nbitsmask = sp->dec_nbitsmask;
  oldcodep = sp->dec_oldcodep;
  free_entp = sp->dec_free_entp;
  maxcodep = sp->dec_maxcodep;

  while (occ > 0) {
    NextCode(tif, sp, bp, code, GetNextCodeCompat);
    if (code == CODE_EOI)
      break;
    if (code == CODE_CLEAR) {
      do {
        free_entp = sp->dec_codetab + CODE_FIRST;
        _TIFFmemset(free_entp, 0, (CSIZE - CODE_FIRST) * sizeof(code_t));
        nbits = BITS_MIN;
        nbitsmask = MAXCODE(BITS_MIN);
        maxcodep = sp->dec_codetab + nbitsmask;
        NextCode(tif, sp, bp, code, GetNextCodeCompat);
      } while (code == CODE_CLEAR); /* consecutive CODE_CLEAR codes */
      if (code == CODE_EOI)
        break;
      if (code > CODE_CLEAR) {
        TIFFErrorExt(tif->tif_clientdata, tif->tif_name,
                     "LZWDecode: Corrupted LZW table at scanline %" PRIu32,
                     tif->tif_row);
        return (0);
      }
      *op++ = (uint8_t)code;
      occ--;
      oldcodep = sp->dec_codetab + code;
      continue;
    }
    codep = sp->dec_codetab + code;

    /*
     * Add the new entry to the code table.
     */
    if (free_entp < &sp->dec_codetab[0] ||
        free_entp >= &sp->dec_codetab[CSIZE]) {
      TIFFErrorExt(tif->tif_clientdata, module,
                   "Corrupted LZW table at scanline %" PRIu32, tif->tif_row);
      return (0);
    }

    free_entp->next = oldcodep;
    if (free_entp->next < &sp->dec_codetab[0] ||
        free_entp->next >= &sp->dec_codetab[CSIZE]) {
      TIFFErrorExt(tif->tif_clientdata, module,
                   "Corrupted LZW table at scanline %" PRIu32, tif->tif_row);
      return (0);
    }
    free_entp->firstchar = free_entp->next->firstchar;
    free_entp->length = free_entp->next->length + 1;
    free_entp->value =
        (codep < free_entp) ? codep->firstchar : free_entp->firstchar;
    if (++free_entp > maxcodep) {
      if (++nbits > BITS_MAX) /* should not happen */
        nbits = BITS_MAX;
      nbitsmask = MAXCODE(nbits);
      maxcodep = sp->dec_codetab + nbitsmask;
    }
    oldcodep = codep;
    if (code >= 256) {
      /*
       * Code maps to a string, copy string
       * value to output (written in reverse).
       */
      if (codep->length == 0) {
        TIFFErrorExt(tif->tif_clientdata, module,
                     "Wrong length of decoded "
                     "string: data probably corrupted at scanline %" PRIu32,
                     tif->tif_row);
        return (0);
      }
      if (codep->length > occ) {
        /*
         * String is too long for decode buffer,
         * locate portion that will fit, copy to
         * the decode buffer, and setup restart
         * logic for the next decoding call.
         */
        sp->dec_codep = codep;
        do {
          codep = codep->next;
        } while (codep->length > occ);
        sp->dec_restart = occ;
        tp = op + occ;
        do {
          *--tp = codep->value;
          codep = codep->next;
        } while (--occ);
        break;
      }
      len = codep->length;
      tp = op + len;
      do {
        *--tp = codep->value;
        codep = codep->next;
      } while (codep && tp > op);
      assert(occ >= len);
      op += len;
      occ -= len;
    } else {
      *op++ = (uint8_t)code;
      occ--;
    }
  }

  tif->tif_rawcc -= (tmsize_t)((uint8_t *)bp - tif->tif_rawcp);
  tif->tif_rawcp = (uint8_t *)bp;
#ifdef LZW_CHECKEOS
  sp->old_tif_rawcc = tif->tif_rawcc;
#endif
  sp->lzw_nbits = (unsigned short)nbits;
  sp->lzw_nextdata = nextdata;
  sp->lzw_nextbits = nextbits;
  sp->dec_nbitsmask = nbitsmask;
  sp->dec_oldcodep = oldcodep;
  sp->dec_free_entp = free_entp;
  sp->dec_maxcodep = maxcodep;

  if (occ > 0) {
    TIFFErrorExt(tif->tif_clientdata, module,
                 "Not enough data at scanline %" PRIu32 " (short %ld bytes)",
                 tif->tif_row, occ);
    return (0);
  }
  return (1);
}

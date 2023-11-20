void PNGAPI png_free_data(png_const_structrp png_ptr, png_inforp info_ptr,
                          png_uint_32 mask, int num) {
  png_debug(1, "in png_free_data");

  if (png_ptr == NULL || info_ptr == NULL)
    return;

#ifdef PNG_TEXT_SUPPORTED
  /* Free text item num or (if num == -1) all text items */
  if (info_ptr->text != NULL &&
      ((mask & PNG_FREE_TEXT) & info_ptr->free_me) != 0) {
    if (num != -1) {
      png_free(png_ptr, info_ptr->text[num].key);
      info_ptr->text[num].key = NULL;
    }

    else {
      int i;

      for (i = 0; i < info_ptr->num_text; i++)
        png_free(png_ptr, info_ptr->text[i].key);

      png_free(png_ptr, info_ptr->text);
      info_ptr->text = NULL;
      info_ptr->num_text = 0;
      info_ptr->max_text = 0;
    }
  }
#endif

#ifdef PNG_tRNS_SUPPORTED
  /* Free any tRNS entry */
  if (((mask & PNG_FREE_TRNS) & info_ptr->free_me) != 0) {
    info_ptr->valid &= ~PNG_INFO_tRNS;
    png_free(png_ptr, info_ptr->trans_alpha);
    info_ptr->trans_alpha = NULL;
    info_ptr->num_trans = 0;
  }
#endif

#ifdef PNG_sCAL_SUPPORTED
  /* Free any sCAL entry */
  if (((mask & PNG_FREE_SCAL) & info_ptr->free_me) != 0) {
    png_free(png_ptr, info_ptr->scal_s_width);
    png_free(png_ptr, info_ptr->scal_s_height);
    info_ptr->scal_s_width = NULL;
    info_ptr->scal_s_height = NULL;
    info_ptr->valid &= ~PNG_INFO_sCAL;
  }
#endif

#ifdef PNG_pCAL_SUPPORTED
  /* Free any pCAL entry */
  if (((mask & PNG_FREE_PCAL) & info_ptr->free_me) != 0) {
    png_free(png_ptr, info_ptr->pcal_purpose);
    png_free(png_ptr, info_ptr->pcal_units);
    info_ptr->pcal_purpose = NULL;
    info_ptr->pcal_units = NULL;

    if (info_ptr->pcal_params != NULL) {
      int i;

      for (i = 0; i < info_ptr->pcal_nparams; i++)
        png_free(png_ptr, info_ptr->pcal_params[i]);

      png_free(png_ptr, info_ptr->pcal_params);
      info_ptr->pcal_params = NULL;
    }
    info_ptr->valid &= ~PNG_INFO_pCAL;
  }
#endif

#ifdef PNG_iCCP_SUPPORTED
  /* Free any profile entry */
  if (((mask & PNG_FREE_ICCP) & info_ptr->free_me) != 0) {
    png_free(png_ptr, info_ptr->iccp_name);
    png_free(png_ptr, info_ptr->iccp_profile);
    info_ptr->iccp_name = NULL;
    info_ptr->iccp_profile = NULL;
    info_ptr->valid &= ~PNG_INFO_iCCP;
  }
#endif

#ifdef PNG_sPLT_SUPPORTED
  /* Free a given sPLT entry, or (if num == -1) all sPLT entries */
  if (info_ptr->splt_palettes != NULL &&
      ((mask & PNG_FREE_SPLT) & info_ptr->free_me) != 0) {
    if (num != -1) {
      png_free(png_ptr, info_ptr->splt_palettes[num].name);
      png_free(png_ptr, info_ptr->splt_palettes[num].entries);
      info_ptr->splt_palettes[num].name = NULL;
      info_ptr->splt_palettes[num].entries = NULL;
    }

    else {
      int i;

      for (i = 0; i < info_ptr->splt_palettes_num; i++) {
        png_free(png_ptr, info_ptr->splt_palettes[i].name);
        png_free(png_ptr, info_ptr->splt_palettes[i].entries);
      }

      png_free(png_ptr, info_ptr->splt_palettes);
      info_ptr->splt_palettes = NULL;
      info_ptr->splt_palettes_num = 0;
      info_ptr->valid &= ~PNG_INFO_sPLT;
    }
  }
#endif

#ifdef PNG_STORE_UNKNOWN_CHUNKS_SUPPORTED
  if (info_ptr->unknown_chunks != NULL &&
      ((mask & PNG_FREE_UNKN) & info_ptr->free_me) != 0) {
    if (num != -1) {
      png_free(png_ptr, info_ptr->unknown_chunks[num].data);
      info_ptr->unknown_chunks[num].data = NULL;
    }

    else {
      int i;

      for (i = 0; i < info_ptr->unknown_chunks_num; i++)
        png_free(png_ptr, info_ptr->unknown_chunks[i].data);

      png_free(png_ptr, info_ptr->unknown_chunks);
      info_ptr->unknown_chunks = NULL;
      info_ptr->unknown_chunks_num = 0;
    }
  }
#endif

#ifdef PNG_eXIf_SUPPORTED
  /* Free any eXIf entry */
  if (((mask & PNG_FREE_EXIF) & info_ptr->free_me) != 0) {
#ifdef PNG_READ_eXIf_SUPPORTED
    if (info_ptr->eXIf_buf) {
      png_free(png_ptr, info_ptr->eXIf_buf);
      info_ptr->eXIf_buf = NULL;
    }
#endif
    if (info_ptr->exif) {
      png_free(png_ptr, info_ptr->exif);
      info_ptr->exif = NULL;
    }
    info_ptr->valid &= ~PNG_INFO_eXIf;
  }
#endif

#ifdef PNG_hIST_SUPPORTED
  /* Free any hIST entry */
  if (((mask & PNG_FREE_HIST) & info_ptr->free_me) != 0) {
    png_free(png_ptr, info_ptr->hist);
    info_ptr->hist = NULL;
    info_ptr->valid &= ~PNG_INFO_hIST;
  }
#endif

  /* Free any PLTE entry that was internally allocated */
  if (((mask & PNG_FREE_PLTE) & info_ptr->free_me) != 0) {
    png_free(png_ptr, info_ptr->palette);
    info_ptr->palette = NULL;
    info_ptr->valid &= ~PNG_INFO_PLTE;
    info_ptr->num_palette = 0;
  }

#ifdef PNG_INFO_IMAGE_SUPPORTED
  /* Free any image bits attached to the info structure */
  if (((mask & PNG_FREE_ROWS) & info_ptr->free_me) != 0) {
    if (info_ptr->row_pointers != NULL) {
      png_uint_32 row;
      for (row = 0; row < info_ptr->height; row++)
        png_free(png_ptr, info_ptr->row_pointers[row]);

      png_free(png_ptr, info_ptr->row_pointers);
      info_ptr->row_pointers = NULL;
    }
    info_ptr->valid &= ~PNG_INFO_IDAT;
  }
#endif

  if (num != -1)
    mask &= ~PNG_FREE_MUL;

  info_ptr->free_me &= ~mask;
}
void /* PRIVATE */
png_handle_eXIf(png_structrp png_ptr, png_inforp info_ptr, png_uint_32 length) {
  unsigned int i;

  png_debug(1, "in png_handle_eXIf");

  if ((png_ptr->mode & PNG_HAVE_IHDR) == 0)
    png_chunk_error(png_ptr, "missing IHDR");

  if (length < 2) {
    png_crc_finish(png_ptr, length);
    png_chunk_benign_error(png_ptr, "too short");
    return;
  }

  else if (info_ptr == NULL || (info_ptr->valid & PNG_INFO_eXIf) != 0) {
    png_crc_finish(png_ptr, length);
    png_chunk_benign_error(png_ptr, "duplicate");
    return;
  }

  info_ptr->free_me |= PNG_FREE_EXIF;

  info_ptr->eXIf_buf =
      png_voidcast(png_bytep, png_malloc_warn(png_ptr, length));

  if (info_ptr->eXIf_buf == NULL) {
    png_crc_finish(png_ptr, length);
    png_chunk_benign_error(png_ptr, "out of memory");
    return;
  }

  for (i = 0; i < length; i++) {
    png_byte buf[1];
    png_crc_read(png_ptr, buf, 1);
    info_ptr->eXIf_buf[i] = buf[0];
    if (i == 1 && buf[0] != 'M' && buf[0] != 'I' &&
        info_ptr->eXIf_buf[0] != buf[0]) {
      png_crc_finish(png_ptr, length - i - 1);
      png_chunk_benign_error(png_ptr, "incorrect byte-order specifier");
      png_free(png_ptr, info_ptr->eXIf_buf);
      info_ptr->eXIf_buf = NULL;
      return;
    }
  }

  if (png_crc_finish(png_ptr, 0) == 0)
    png_set_eXIf_1(png_ptr, info_ptr, length, info_ptr->eXIf_buf);

  png_free(png_ptr, info_ptr->eXIf_buf);
  info_ptr->eXIf_buf = NULL;
}

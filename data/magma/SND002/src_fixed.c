static int sd2_parse_rsrc_fork(SF_PRIVATE *psf) {
  SD2_RSRC rsrc;
  int k, marker, error = 0;

  psf_use_rsrc(psf, SF_TRUE);

  memset(&rsrc, 0, sizeof(rsrc));

  rsrc.rsrc_len = psf_get_filelen(psf);
  psf_log_printf(psf, "Resource length : %d (0x%04X)\n", rsrc.rsrc_len,
                 rsrc.rsrc_len);

  if (rsrc.rsrc_len > psf->header.len) {
    rsrc.rsrc_data = calloc(1, rsrc.rsrc_len);
    rsrc.need_to_free_rsrc_data = SF_TRUE;
  } else {
    rsrc.rsrc_data = psf->header.ptr;
    // rsrc.rsrc_len > psf->header.len ;
    rsrc.need_to_free_rsrc_data = SF_FALSE;
  };

  /* Read in the whole lot. */
  psf_fread(rsrc.rsrc_data, rsrc.rsrc_len, 1, psf);

  /* Reset the header storage because we have changed to the rsrcdes. */
  psf->header.indx = psf->header.end = rsrc.rsrc_len;

  rsrc.data_offset = read_rsrc_int(&rsrc, 0);
  rsrc.map_offset = read_rsrc_int(&rsrc, 4);
  rsrc.data_length = read_rsrc_int(&rsrc, 8);
  rsrc.map_length = read_rsrc_int(&rsrc, 12);

  if (rsrc.data_offset == 0x51607 && rsrc.map_offset == 0x20000) {
    psf_log_printf(psf, "Trying offset of 0x52 bytes.\n");
    rsrc.data_offset = read_rsrc_int(&rsrc, 0x52 + 0) + 0x52;
    rsrc.map_offset = read_rsrc_int(&rsrc, 0x52 + 4) + 0x52;
    rsrc.data_length = read_rsrc_int(&rsrc, 0x52 + 8);
    rsrc.map_length = read_rsrc_int(&rsrc, 0x52 + 12);
  };

  psf_log_printf(psf,
                 "  data offset : 0x%04X\n  map  offset : 0x%04X\n"
                 "  data length : 0x%04X\n  map  length : 0x%04X\n",
                 rsrc.data_offset, rsrc.map_offset, rsrc.data_length,
                 rsrc.map_length);

  if (rsrc.data_offset > rsrc.rsrc_len) {
    psf_log_printf(psf, "Error : rsrc.data_offset (%d, 0x%x) > len\n",
                   rsrc.data_offset, rsrc.data_offset);
    error = SFE_SD2_BAD_DATA_OFFSET;
    goto parse_rsrc_fork_cleanup;
  };

  if (rsrc.map_offset > rsrc.rsrc_len) {
    psf_log_printf(psf, "Error : rsrc.map_offset > len\n");
    error = SFE_SD2_BAD_MAP_OFFSET;
    goto parse_rsrc_fork_cleanup;
  };

  if (rsrc.data_length > rsrc.rsrc_len) {
    psf_log_printf(psf, "Error : rsrc.data_length > len\n");
    error = SFE_SD2_BAD_DATA_LENGTH;
    goto parse_rsrc_fork_cleanup;
  };

  if (rsrc.map_length > rsrc.rsrc_len) {
    psf_log_printf(psf, "Error : rsrc.map_length > len\n");
    error = SFE_SD2_BAD_MAP_LENGTH;
    goto parse_rsrc_fork_cleanup;
  };

  if (rsrc.data_offset + rsrc.data_length != rsrc.map_offset ||
      rsrc.map_offset + rsrc.map_length != rsrc.rsrc_len) {
    psf_log_printf(psf,
                   "Error : This does not look like a MacOSX resource fork.\n");
    error = SFE_SD2_BAD_RSRC;
    goto parse_rsrc_fork_cleanup;
  };

  if (rsrc.map_offset + 28 >= rsrc.rsrc_len) {
    psf_log_printf(psf, "Bad map offset (%d + 28 > %d).\n", rsrc.map_offset,
                   rsrc.rsrc_len);
    error = SFE_SD2_BAD_RSRC;
    goto parse_rsrc_fork_cleanup;
  };

  rsrc.string_offset =
      rsrc.map_offset + read_rsrc_short(&rsrc, rsrc.map_offset + 26);
  if (rsrc.string_offset > rsrc.rsrc_len) {
    psf_log_printf(psf, "Bad string offset (%d).\n", rsrc.string_offset);
    error = SFE_SD2_BAD_RSRC;
    goto parse_rsrc_fork_cleanup;
  };

  rsrc.type_offset = rsrc.map_offset + 30;

  if (rsrc.map_offset + 28 > rsrc.rsrc_len) {
    psf_log_printf(psf, "Bad map offset.\n");
    goto parse_rsrc_fork_cleanup;
  };

  rsrc.type_count = read_rsrc_short(&rsrc, rsrc.map_offset + 28) + 1;
  if (rsrc.type_count < 1) {
    psf_log_printf(psf, "Bad type count.\n");
    error = SFE_SD2_BAD_RSRC;
    goto parse_rsrc_fork_cleanup;
  };

  rsrc.item_offset = rsrc.type_offset + rsrc.type_count * 8;
  if (rsrc.item_offset < 0 || rsrc.item_offset > rsrc.rsrc_len) {
    psf_log_printf(psf, "Bad item offset (%d).\n", rsrc.item_offset);
    error = SFE_SD2_BAD_RSRC;
    goto parse_rsrc_fork_cleanup;
  };

  rsrc.str_index = -1;
  for (k = 0; k < rsrc.type_count; k++) {
    if (rsrc.type_offset + k * 8 > rsrc.rsrc_len) {
      psf_log_printf(psf, "Bad rsrc marker.\n");
      goto parse_rsrc_fork_cleanup;
    };

    marker = read_rsrc_marker(&rsrc, rsrc.type_offset + k * 8);

    if (marker == STR_MARKER) {
      rsrc.str_index = k;
      rsrc.str_count = read_rsrc_short(&rsrc, rsrc.type_offset + k * 8 + 4) + 1;
      error = parse_str_rsrc(psf, &rsrc);
      goto parse_rsrc_fork_cleanup;
    };
  };

  psf_log_printf(psf, "No 'STR ' resource.\n");
  error = SFE_SD2_BAD_RSRC;

parse_rsrc_fork_cleanup:

  psf_use_rsrc(psf, SF_FALSE);

  if (rsrc.need_to_free_rsrc_data)
    free(rsrc.rsrc_data);

  return error;
} /* sd2_parse_rsrc_fork */

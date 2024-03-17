int __fastcall sd2_parse_rsrc_fork(SF_PRIVATE *psf)
{
  int v2;
  int filelen;
  unsigned __int8 *ptr;
  unsigned int v5;
  unsigned int v6;
  int v7;
  int v8;
  int v9;
  int v10;
  unsigned int v11;
  int v12;
  int v13;
  __int64 v14;
  int v15;
  int v16;
  int need_to_free_rsrc_data;
  int v19;
  SD2_RSRC prsrc;

  v2 = 1;
  psf_use_rsrc(psf, 1);
  memset(&prsrc, 0, sizeof(prsrc));
  filelen = psf_get_filelen(psf);
  prsrc.rsrc_len = filelen;
  psf_log_printf(psf, "Resource length : %d (0x%04X)\n", (unsigned int)filelen, (unsigned int)filelen);
  if ( psf->header.len >= filelen )
  {
    ptr = psf->header.ptr;
    prsrc.rsrc_data = psf->header.ptr;
    v2 = 0;
  }
  else
  {
    ptr = (unsigned __int8 *)calloc(1uLL, filelen);
    prsrc.rsrc_data = ptr;
  }
  v19 = v2;
  prsrc.need_to_free_rsrc_data = v2;
  psf_fread(ptr, filelen, 1LL, psf);
  psf->header.end = filelen;
  psf->header.indx = filelen;
  v5 = read_rsrc_int(&prsrc, 0);
  prsrc.data_offset = v5;
  v6 = read_rsrc_int(&prsrc, 4);
  prsrc.map_offset = v6;
  v7 = read_rsrc_int(&prsrc, 8);
  prsrc.data_length = v7;
  v8 = read_rsrc_int(&prsrc, 12);
  prsrc.map_length = v8;
  if ( v5 == 333319 && v6 == 0x20000 )
  {
    psf_log_printf(psf, "Trying offset of 0x52 bytes.\n");
    v5 = read_rsrc_int(&prsrc, 82) + 82;
    prsrc.data_offset = v5;
    v6 = read_rsrc_int(&prsrc, 86) + 82;
    prsrc.map_offset = v6;
    v7 = read_rsrc_int(&prsrc, 90);
    prsrc.data_length = v7;
    v8 = read_rsrc_int(&prsrc, 94);
    prsrc.map_length = v8;
  }
  psf_log_printf(
    psf,
    "  data offset : 0x%04X\n  map  offset : 0x%04X\n  data length : 0x%04X\n  map  length : 0x%04X\n",
    v5,
    v6,
    (unsigned int)v7,
    (unsigned int)v8);
  if ( (int)v5 > filelen )
  {
    psf_log_printf(psf, "Error : rsrc.data_offset (%d, 0x%x) > len\n", v5, v5);
    v9 = 149;
LABEL_34:
    need_to_free_rsrc_data = v19;
    goto parse_rsrc_fork_cleanup;
  }
  if ( (int)v6 > filelen )
  {
    psf_log_printf(psf, "Error : rsrc.map_offset > len\n");
    v9 = 150;
    goto LABEL_34;
  }
  if ( v7 > filelen )
  {
    psf_log_printf(psf, "Error : rsrc.data_length > len\n");
    v9 = 151;
    goto LABEL_34;
  }
  if ( v8 > filelen )
  {
    psf_log_printf(psf, "Error : rsrc.map_length > len\n");
    v9 = 152;
    goto LABEL_34;
  }
  if ( v5 + v7 != v6 || v6 + v8 != filelen )
  {
    psf_log_printf(psf, "Error : This does not look like a MacOSX resource fork.\n");
    goto LABEL_33;
  }
  if ( (int)(v6 + 28) >= filelen )
  {
    psf_log_printf(psf, "Bad map offset (%d + 28 > %d).\n", v6, (unsigned int)filelen);
    goto LABEL_33;
  }
  v10 = v6 + read_rsrc_short(&prsrc, v6 + 26);
  prsrc.string_offset = v10;
  if ( v10 > filelen )
  {
    psf_log_printf(psf, "Bad string offset (%d).\n", (unsigned int)v10);
LABEL_33:
    v9 = 153;
    goto LABEL_34;
  }
  v11 = v6 + 30;
  prsrc.type_offset = v6 + 30;
  v12 = read_rsrc_short(&prsrc, v6 + 28);
  v13 = v12 + 1;
  prsrc.type_count = v12 + 1;
  if ( v12 < 0 )
  {
    psf_log_printf(psf, "Bad type count.\n");
    goto LABEL_33;
  }
  v14 = v11 + 8 * v13;
  prsrc.item_offset = v11 + 8 * v13;
  if ( prsrc.item_offset < 0 || (int)v14 > filelen )
  {
    psf_log_printf(psf, "Bad item offset (%d).\n", v14);
    goto LABEL_33;
  }
  prsrc.str_index = -1;
  v15 = v6 + 34;
  v16 = 0;
  while ( 1 )
  {
    if ( v15 - 4 > filelen )
    {
      v9 = 0;
      psf_log_printf(psf, "Bad rsrc marker.\n");
      goto LABEL_34;
    }
    if ( read_rsrc_marker(&prsrc, v15 - 4) == 542266451 )
      break;
    ++v16;
    v15 += 8;
    if ( v13 == v16 )
    {
      psf_log_printf(psf, "No 'STR ' resource.\n");
      goto LABEL_33;
    }
  }
  prsrc.str_index = v16;
  prsrc.str_count = read_rsrc_short(&prsrc, v15) + 1;
  v9 = parse_str_rsrc(psf, &prsrc);
  need_to_free_rsrc_data = prsrc.need_to_free_rsrc_data;
parse_rsrc_fork_cleanup:
  psf_use_rsrc(psf, 0);
  if ( need_to_free_rsrc_data )
    free(prsrc.rsrc_data);
  return v9;
}
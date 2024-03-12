void __fastcall MAGMA_png_handle_eXIf(png_structrp png_ptr, png_inforp info_ptr, png_uint_32 length)
{
  __int64 v3;
  const char *v5;
  png_byte *v6;
  __int64 v7;
  char v8[49];

  v8[0] = HIBYTE(v3);
  if ( (png_ptr->mode & 1) == 0 )
    MAGMA_png_chunk_error(png_ptr, "missing IHDR");
  if ( length <= 1 )
  {
    MAGMA_png_crc_finish(png_ptr, length);
    v5 = "too short";
LABEL_14:
    MAGMA_png_chunk_benign_error(png_ptr, v5);
    return;
  }
  if ( !info_ptr || (info_ptr->valid & 0x10000) != 0 )
  {
    MAGMA_png_crc_finish(png_ptr, length);
    v5 = "duplicate";
    goto LABEL_14;
  }
  v6 = (png_byte *)MAGMA_png_malloc_warn(png_ptr, length);
  info_ptr->eXIf_buf = v6;
  if ( !v6 )
  {
    MAGMA_png_crc_finish(png_ptr, length);
    v5 = "png_image_read: out of memory" + 16;
    goto LABEL_14;
  }
  v7 = 0LL;
  do
  {
    MAGMA_png_crc_read(png_ptr, (png_bytep)v8, 1u);
    info_ptr->eXIf_buf[v7] = v8[0];
    if ( v7 == 1 && (v8[0] | 4) != 77 && *info_ptr->eXIf_buf != v8[0] )
    {
      MAGMA_png_crc_finish(png_ptr, length - 2);
      MAGMA_png_chunk_benign_error(png_ptr, "incorrect byte-order specifier");
      goto LABEL_17;
    }
    ++v7;
  }
  while ( length != v7 );
  if ( !MAGMA_png_crc_finish(png_ptr, 0) )
    MAGMA_png_set_eXIf_1(png_ptr, info_ptr, length, info_ptr->eXIf_buf);
LABEL_17:
  MAGMA_png_free(png_ptr, info_ptr->eXIf_buf);
  info_ptr->eXIf_buf = 0LL;
}

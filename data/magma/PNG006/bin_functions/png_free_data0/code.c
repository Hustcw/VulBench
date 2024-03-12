void __fastcall MAGMA_png_free_data(png_const_structrp png_ptr, png_inforp info_ptr, png_uint_32 mask, int num)
{
  png_textp text;
  __int64 v8;
  __int64 v9;
  __int64 v10;
  png_uint_32 free_me;
  png_charpp pcal_params;
  unsigned __int64 v13;
  png_sPLT_tp splt_palettes;
  unsigned __int64 v15;
  png_sPLT_tp v16;
  __int64 v17;
  __int64 v18;
  png_unknown_chunkp unknown_chunks;
  __int64 v20;
  __int64 v21;
  __int64 v22;
  png_uint_32 v23;
  png_bytep eXIf_buf;
  png_bytep exif;
  png_bytepp row_pointers;
  unsigned __int64 v27;
  png_uint_32 v28;

  if ( png_ptr && info_ptr )
  {
    text = info_ptr->text;
    if ( text && (mask & info_ptr->free_me & 0x4000) != 0 )
    {
      if ( num == -1 )
      {
        if ( info_ptr->num_text > 0 )
        {
          v9 = 8LL;
          v10 = 0LL;
          do
          {
            MAGMA_png_free(png_ptr, *(png_voidp *)((char *)&text->compression + v9));
            ++v10;
            text = info_ptr->text;
            v9 += 56LL;
          }
          while ( v10 < info_ptr->num_text );
        }
        MAGMA_png_free(png_ptr, text);
        info_ptr->text = 0LL;
        *(_QWORD *)&info_ptr->num_text = 0LL;
      }
      else
      {
        v8 = num;
        MAGMA_png_free(png_ptr, text[v8].key);
        info_ptr->text[v8].key = 0LL;
      }
    }
    free_me = info_ptr->free_me;
    if ( ((unsigned __int16)free_me & (unsigned __int16)mask & 0x2000) != 0 )
    {
      LOBYTE(info_ptr->valid) &= ~0x10u;
      MAGMA_png_free(png_ptr, info_ptr->trans_alpha);
      info_ptr->trans_alpha = 0LL;
      info_ptr->num_trans = 0;
      free_me = info_ptr->free_me;
    }
    if ( ((unsigned __int16)free_me & (unsigned __int16)mask & 0x100) != 0 )
    {
      MAGMA_png_free(png_ptr, info_ptr->scal_s_width);
      MAGMA_png_free(png_ptr, info_ptr->scal_s_height);
      *(_OWORD *)&info_ptr->scal_s_width = 0LL;
      BYTE1(info_ptr->valid) &= ~0x40u;
      free_me = info_ptr->free_me;
    }
    if ( (free_me & mask & 0x80u) != 0 )
    {
      MAGMA_png_free(png_ptr, info_ptr->pcal_purpose);
      MAGMA_png_free(png_ptr, info_ptr->pcal_units);
      info_ptr->pcal_purpose = 0LL;
      info_ptr->pcal_units = 0LL;
      pcal_params = info_ptr->pcal_params;
      if ( pcal_params )
      {
        if ( info_ptr->pcal_nparams )
        {
          v13 = 0LL;
          do
          {
            MAGMA_png_free(png_ptr, pcal_params[v13++]);
            pcal_params = info_ptr->pcal_params;
          }
          while ( v13 < info_ptr->pcal_nparams );
        }
        MAGMA_png_free(png_ptr, pcal_params);
        info_ptr->pcal_params = 0LL;
      }
      BYTE1(info_ptr->valid) &= ~4u;
      free_me = info_ptr->free_me;
    }
    if ( ((unsigned __int8)mask & (unsigned __int8)free_me & 0x10) != 0 )
    {
      MAGMA_png_free(png_ptr, info_ptr->iccp_name);
      MAGMA_png_free(png_ptr, info_ptr->iccp_profile);
      *(_OWORD *)&info_ptr->iccp_name = 0LL;
      BYTE1(info_ptr->valid) &= ~0x10u;
    }
    splt_palettes = info_ptr->splt_palettes;
    if ( splt_palettes && ((unsigned __int8)mask & info_ptr->free_me & 0x20) != 0 )
    {
      if ( num == -1 )
      {
        if ( info_ptr->splt_palettes_num > 0 )
        {
          v17 = 0LL;
          v18 = 0LL;
          do
          {
            MAGMA_png_free(png_ptr, splt_palettes[v17].name);
            MAGMA_png_free(png_ptr, info_ptr->splt_palettes[v17].entries);
            ++v18;
            splt_palettes = info_ptr->splt_palettes;
            ++v17;
          }
          while ( v18 < info_ptr->splt_palettes_num );
        }
        MAGMA_png_free(png_ptr, splt_palettes);
        info_ptr->splt_palettes = 0LL;
        info_ptr->splt_palettes_num = 0;
        BYTE1(info_ptr->valid) &= ~0x20u;
      }
      else
      {
        v15 = num;
        MAGMA_png_free(png_ptr, splt_palettes[v15].name);
        MAGMA_png_free(png_ptr, info_ptr->splt_palettes[v15].entries);
        v16 = info_ptr->splt_palettes;
        v16[v15].name = 0LL;
        v16[v15].entries = 0LL;
      }
    }
    unknown_chunks = info_ptr->unknown_chunks;
    if ( unknown_chunks && (mask & info_ptr->free_me & 0x200) != 0 )
    {
      if ( num == -1 )
      {
        if ( info_ptr->unknown_chunks_num > 0 )
        {
          v21 = 8LL;
          v22 = 0LL;
          do
          {
            MAGMA_png_free(png_ptr, *(png_voidp *)&unknown_chunks->name[v21]);
            ++v22;
            unknown_chunks = info_ptr->unknown_chunks;
            v21 += 32LL;
          }
          while ( v22 < info_ptr->unknown_chunks_num );
        }
        MAGMA_png_free(png_ptr, unknown_chunks);
        info_ptr->unknown_chunks = 0LL;
        info_ptr->unknown_chunks_num = 0;
      }
      else
      {
        v20 = num;
        MAGMA_png_free(png_ptr, unknown_chunks[v20].data);
        info_ptr->unknown_chunks[v20].data = 0LL;
      }
    }
    v23 = info_ptr->free_me;
    if ( ((unsigned __int16)v23 & (unsigned __int16)mask & 0x8000) != 0 )
    {
      eXIf_buf = info_ptr->eXIf_buf;
      if ( eXIf_buf )
      {
        MAGMA_png_free(png_ptr, eXIf_buf);
        info_ptr->eXIf_buf = 0LL;
      }
      exif = info_ptr->exif;
      if ( exif )
      {
        MAGMA_png_free(png_ptr, exif);
        info_ptr->exif = 0LL;
      }
      BYTE2(info_ptr->valid) &= ~1u;
      v23 = info_ptr->free_me;
    }
    if ( ((unsigned __int8)v23 & (unsigned __int8)mask & 8) != 0 )
    {
      MAGMA_png_free(png_ptr, info_ptr->hist);
      info_ptr->hist = 0LL;
      LOBYTE(info_ptr->valid) &= ~0x40u;
      v23 = info_ptr->free_me;
    }
    if ( ((unsigned __int16)v23 & (unsigned __int16)mask & 0x1000) != 0 )
    {
      MAGMA_png_free(png_ptr, info_ptr->palette);
      info_ptr->palette = 0LL;
      LOBYTE(info_ptr->valid) &= ~8u;
      info_ptr->num_palette = 0;
      v23 = info_ptr->free_me;
    }
    if ( ((unsigned __int8)v23 & (unsigned __int8)mask & 0x40) != 0 )
    {
      row_pointers = info_ptr->row_pointers;
      if ( row_pointers )
      {
        if ( info_ptr->height )
        {
          v27 = 0LL;
          do
          {
            MAGMA_png_free(png_ptr, row_pointers[v27++]);
            row_pointers = info_ptr->row_pointers;
          }
          while ( v27 < info_ptr->height );
        }
        MAGMA_png_free(png_ptr, row_pointers);
        info_ptr->row_pointers = 0LL;
        v23 = info_ptr->free_me;
      }
      BYTE1(info_ptr->valid) &= ~0x80u;
    }
    v28 = mask & 0xFFFFBDDF;
    if ( num == -1 )
      v28 = mask;
    info_ptr->free_me = v23 & ~v28;
  }
}

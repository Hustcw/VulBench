void __fastcall MAGMA_png_read_transform_info(png_structrp png_ptr, png_inforp info_ptr)
{
  png_uint_32 transformations;
  png_byte color_type;
  png_uint_16 num_trans;
  png_byte bit_depth;
  png_byte v6;
  char v7;
  png_byte user_transform_depth;
  png_byte user_transform_channels;
  png_byte v10;
  __int64 width;
  unsigned __int64 v12;

  transformations = png_ptr->transformations;
  if ( (transformations & 0x1000) != 0 )
  {
    color_type = info_ptr->color_type;
    num_trans = png_ptr->num_trans;
    if ( color_type == 3 )
    {
      info_ptr->color_type = (4 * (num_trans != 0)) | 2;
    }
    else
    {
      if ( (transformations & 0x2000000) != 0 && num_trans )
        info_ptr->color_type = color_type | 4;
      if ( info_ptr->bit_depth > 7u )
        goto LABEL_9;
    }
    info_ptr->bit_depth = 8;
LABEL_9:
    info_ptr->num_trans = 0;
  }
  if ( (transformations & 0x80u) != 0 )
    info_ptr->background = png_ptr->background;
  info_ptr->colorspace.gamma = png_ptr->colorspace.gamma;
  bit_depth = info_ptr->bit_depth;
  if ( (transformations & 0x4000400) != 0 && bit_depth == 16 )
  {
    info_ptr->bit_depth = 8;
    bit_depth = 8;
  }
  if ( (transformations & 0x4000) != 0 )
    info_ptr->color_type |= 2u;
  if ( (transformations & 0x600000) != 0 )
    info_ptr->color_type &= ~2u;
  if ( (transformations & 0x40) != 0 && (info_ptr->color_type | 4) == 6 && png_ptr->palette_lookup && bit_depth == 8 )
    info_ptr->color_type = 3;
  if ( (transformations & 0x200) != 0 && bit_depth == 8 )
  {
    bit_depth = 8;
    if ( info_ptr->color_type != 3 )
    {
      info_ptr->bit_depth = 16;
      bit_depth = 16;
    }
  }
  if ( (transformations & 4) != 0 && bit_depth <= 7u )
  {
    info_ptr->bit_depth = 8;
    bit_depth = 8;
  }
  v6 = info_ptr->color_type;
  if ( v6 == 3 || (v6 & 2) == 0 )
  {
    info_ptr->channels = 1;
    v7 = 1;
    if ( (transformations & 0x40000) == 0 )
      goto LABEL_35;
    goto LABEL_34;
  }
  info_ptr->channels = 3;
  v7 = 3;
  if ( (transformations & 0x40000) != 0 )
  {
LABEL_34:
    v6 &= ~4u;
    info_ptr->color_type = v6;
    info_ptr->num_trans = 0;
  }
LABEL_35:
  if ( (v6 & 4) != 0 )
  {
    info_ptr->channels = ++v7;
    if ( (transformations & 0x8000u) == 0 )
      goto LABEL_42;
  }
  else if ( (transformations & 0x8000u) == 0 )
  {
    goto LABEL_42;
  }
  if ( (v6 | 2) == 2 )
  {
    info_ptr->channels = ++v7;
    if ( (transformations & 0x1000000) != 0 )
      info_ptr->color_type = v6 | 4;
  }
  if ( (transformations & 0x100000) == 0 )
    goto LABEL_47;
LABEL_42:
  user_transform_depth = png_ptr->user_transform_depth;
  if ( user_transform_depth )
  {
    info_ptr->bit_depth = user_transform_depth;
    bit_depth = user_transform_depth;
  }
  user_transform_channels = png_ptr->user_transform_channels;
  if ( user_transform_channels )
    info_ptr->channels = user_transform_channels;
  else
LABEL_47:
    user_transform_channels = v7;
  v10 = user_transform_channels * bit_depth;
  info_ptr->pixel_depth = v10;
  width = info_ptr->width;
  if ( v10 < 8u )
    v12 = ((unsigned __int64)v10 * width + 7) >> 3;
  else
    v12 = width * ((unsigned __int64)v10 >> 3);
  info_ptr->rowbytes = v12;
  png_ptr->info_rowbytes = v12;
}


void __fastcall MAGMA_png_set_PLTE(
        png_structrp png_ptr,
        png_inforp info_ptr,
        png_const_colorp palette,
        int num_palette)
{
  png_color *v6;

  if ( png_ptr && info_ptr )
  {
    if ( (unsigned int)num_palette < 0x101 )
    {
      if ( (palette || !num_palette) && (num_palette || (png_ptr->mng_features_permitted & 1) != 0) )
      {
        MAGMA_png_free_data(png_ptr, info_ptr, 0x1000u, 0);
        v6 = (png_color *)MAGMA_png_calloc(png_ptr, 0x300uLL);
        png_ptr->palette = v6;
        if ( num_palette )
          memcpy(v6, palette, 3LL * (unsigned int)num_palette);
        info_ptr->palette = v6;
        info_ptr->num_palette = num_palette;
        BYTE1(info_ptr->free_me) |= 0x10u;
        png_ptr->num_palette = num_palette;
        LOBYTE(info_ptr->valid) |= 8u;
      }
      else
      {
        MAGMA_png_chunk_report(png_ptr, "Invalid palette", 2);
      }
    }
    else if ( info_ptr->color_type == 3 )
    {
      MAGMA_png_error(png_ptr, "Invalid palette length");
    }
  }
}

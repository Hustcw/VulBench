static inline char *exif_offset_info_try_get(const exif_offset_info *info,
                                             size_t offset, size_t length) {
  if ((offset + length) > (info->valid_end - info->valid_start)) {
    return NULL;
  }
  return info->offset_base + offset;
}


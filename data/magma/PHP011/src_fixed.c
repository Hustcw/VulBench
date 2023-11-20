static inline char *exif_offset_info_try_get(const exif_offset_info *info,
                                             size_t offset, size_t length) {
  char *start, *end;
  if (ptr_offset_overflows(info->offset_base, offset)) {
    return NULL;
  }

  start = info->offset_base + offset;
  if (ptr_offset_overflows(start, length)) {
    return NULL;
  }

  end = start + length;
  if (start < info->valid_start || end > info->valid_end) {
    return NULL;
  }

  return start;
}

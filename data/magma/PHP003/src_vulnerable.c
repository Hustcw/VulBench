static bool exif_scan_thumbnail(image_info_type *ImageInfo) {
  uchar c, *data = (uchar *)ImageInfo->Thumbnail.data;
  int n, marker;
  size_t length = 2, pos = 0;
  jpeg_sof_info sof_info;
  if (!data) {
    return false; /* nothing to do here */
  }
  if (memcmp(data, "\xFF\xD8\xFF", 3)) {
    if (!ImageInfo->Thumbnail.width && !ImageInfo->Thumbnail.height) {
      exif_error_docref(NULL EXIFERR_CC, ImageInfo, E_WARNING,
                        "Thumbnail is not a JPEG image");
    }
    return false;
  }
  for (;;) {
    pos += length;
    if (pos >= ImageInfo->Thumbnail.size)
      return false;
    c = data[pos++];
    if (pos >= ImageInfo->Thumbnail.size)
      return false;
    if (c != 0xFF) {
      return false;
    }
    n = 8;
    while ((c = data[pos++]) == 0xFF && n--) {
      if (pos + 3 >= ImageInfo->Thumbnail.size)
        return false;
      /* +3 = pos++ of next check when reaching marker + 2 bytes for length */
    }
    if (c == 0xFF)
      return false;
    marker = c;
    if (pos >= ImageInfo->Thumbnail.size)
      return false;
    length = php_jpg_get16(data + pos);
    if (length > ImageInfo->Thumbnail.size ||
        pos >= ImageInfo->Thumbnail.size - length) {
      return false;
    }
#ifdef EXIF_DEBUG
    exif_error_docref(NULL EXIFERR_CC, ImageInfo, E_NOTICE,
                      "Thumbnail: process section(x%02X=%s) @ x%04X + x%04X",
                      marker, exif_get_markername(marker), pos, length);
#endif
    switch (marker) {
    case M_SOF0:
    case M_SOF1:
    case M_SOF2:
    case M_SOF3:
    case M_SOF5:
    case M_SOF6:
    case M_SOF7:
    case M_SOF9:
    case M_SOF10:
    case M_SOF11:
    case M_SOF13:
    case M_SOF14:
    case M_SOF15:
      /* handle SOFn block */
      if (length < 8 || ImageInfo->Thumbnail.size - 8 < pos) {
        /* exif_process_SOFn needs 8 bytes */
        return false;
      }
      exif_process_SOFn(data + pos, marker, &sof_info);
      ImageInfo->Thumbnail.height = sof_info.height;
      ImageInfo->Thumbnail.width = sof_info.width;
#ifdef EXIF_DEBUG
      exif_error_docref(NULL EXIFERR_CC, ImageInfo, E_NOTICE,
                        "Thumbnail: size: %d * %d", sof_info.width,
                        sof_info.height);
#endif
      return true;

    case M_SOS:
    case M_EOI:
      exif_error_docref(NULL EXIFERR_CC, ImageInfo, E_WARNING,
                        "Could not compute size of thumbnail");
      return false;
      break;

    default:
      /* just skip */
      break;
    }
  }

  exif_error_docref(NULL EXIFERR_CC, ImageInfo, E_WARNING,
                    "Could not compute size of thumbnail");
  return false;
}


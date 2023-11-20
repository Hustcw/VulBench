static bool exif_process_IFD_in_MAKERNOTE(image_info_type *ImageInfo,
                                          char *value_ptr, int value_len,
                                          const exif_offset_info *info,
                                          size_t displacement) {
  size_t i;
  int de, section_index = SECTION_MAKERNOTE;
  int NumDirEntries, old_motorola_intel;
  const maker_note_type *maker_note;
  char *dir_start;
  exif_offset_info new_info;

  for (i = 0; i <= sizeof(maker_note_array) / sizeof(maker_note_type); i++) {
    if (i == sizeof(maker_note_array) / sizeof(maker_note_type)) {
#ifdef EXIF_DEBUG
      exif_error_docref(
          NULL EXIFERR_CC, ImageInfo, E_NOTICE,
          "No maker note data found. Detected maker: %s (length = %d)",
          ImageInfo->make, ImageInfo->make ? strlen(ImageInfo->make) : 0);
#endif
      /* unknown manufacturer, not an error, use it as a string */
      return true;
    }

    maker_note = maker_note_array + i;

    if (maker_note->make &&
        (!ImageInfo->make || strcmp(maker_note->make, ImageInfo->make)))
      continue;
    if (maker_note->id_string && value_len >= maker_note->id_string_len &&
        strncmp(maker_note->id_string, value_ptr, maker_note->id_string_len))
      continue;
    break;
  }

  if (value_len < 2 || maker_note->offset >= value_len - 1) {
    /* Do not go past the value end */
    exif_error_docref("exif_read_data#error_ifd" EXIFERR_CC, ImageInfo,
                      E_WARNING, "IFD data too short: 0x%04X offset 0x%04X",
                      value_len, maker_note->offset);
    return true;
  }

  dir_start = value_ptr + maker_note->offset;

#ifdef EXIF_DEBUG
  exif_error_docref(
      NULL EXIFERR_CC, ImageInfo, E_NOTICE, "Process %s @x%04X + 0x%04X=%d: %s",
      exif_get_sectionname(section_index),
      (intptr_t)dir_start - (intptr_t)info->offset_base + maker_note->offset +
          displacement,
      value_len, value_len,
      exif_char_dump(value_ptr, value_len,
                     (intptr_t)dir_start - (intptr_t)info->offset_base +
                         maker_note->offset + displacement));
#endif

  ImageInfo->sections_found |= FOUND_MAKERNOTE;

  old_motorola_intel = ImageInfo->motorola_intel;
  switch (maker_note->byte_order) {
  case MN_ORDER_INTEL:
    ImageInfo->motorola_intel = 0;
    break;
  case MN_ORDER_MOTOROLA:
    ImageInfo->motorola_intel = 1;
    break;
  default:
  case MN_ORDER_NORMAL:
    break;
  }

  NumDirEntries = php_ifd_get16u(dir_start, ImageInfo->motorola_intel);

  /* It can be that motorola_intel is wrongly mapped, let's try inverting it */
  if ((2 + NumDirEntries * 12) > value_len) {
    exif_error_docref(NULL EXIFERR_CC, ImageInfo, E_NOTICE,
                      "Potentially invalid endianess, trying again with "
                      "different endianness before imminent failure.");

    ImageInfo->motorola_intel = ImageInfo->motorola_intel == 0 ? 1 : 0;
    NumDirEntries = php_ifd_get16u(dir_start, ImageInfo->motorola_intel);
  }

  if ((2 + NumDirEntries * 12) > value_len) {
    exif_error_docref("exif_read_data#error_ifd" EXIFERR_CC, ImageInfo,
                      E_WARNING,
                      "Illegal IFD size: 2 + 0x%04X*12 = 0x%04X > 0x%04X",
                      NumDirEntries, 2 + NumDirEntries * 12, value_len);
    return false;
  }


  switch (maker_note->offset_mode) {
  case MN_OFFSET_MAKER:
    exif_offset_info_init(&new_info, value_ptr, value_ptr, value_len);
    info = &new_info;
    break;
  default:
  case MN_OFFSET_NORMAL:
    break;
  }

  for (de = 0; de < NumDirEntries; de++) {
    size_t offset = 2 + 12 * de;
    if (!exif_process_IFD_TAG(ImageInfo, dir_start + offset, info, displacement,
                              section_index, 0, maker_note->tag_table)) {
      return false;
    }
  }
  ImageInfo->motorola_intel = old_motorola_intel;
/*	NextDirOffset (must be NULL) = php_ifd_get32u(dir_start+2+12*de,
 * ImageInfo->motorola_intel);*/
#ifdef EXIF_DEBUG
  exif_error_docref(NULL EXIFERR_CC, ImageInfo, E_NOTICE, "Subsection %s done",
                    exif_get_sectionname(SECTION_MAKERNOTE));
#endif
  return true;
}


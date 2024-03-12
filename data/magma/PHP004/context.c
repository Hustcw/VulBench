/* {{{ exif_process_IFD_TAG
 * Process one of the nested IFDs directories. */
static bool exif_process_IFD_TAG_impl(image_info_type *ImageInfo, char *dir_entry, const exif_offset_info *info, size_t displacement, int section_index, int ReadNextIFD, tag_table_type tag_table)
{
	size_t length;
	unsigned int tag, format, components;
	char *value_ptr, tagname[64], cbuf[32], *outside=NULL;
	size_t byte_count, offset_val, fpos, fgot;
	int64_t byte_count_signed;
	xp_field_type *tmp_xp;
#ifdef EXIF_DEBUG
	char *dump_data;
	int dump_free;
#endif /* EXIF_DEBUG */

	tag = php_ifd_get16u(dir_entry, ImageInfo->motorola_intel);
	format = php_ifd_get16u(dir_entry+2, ImageInfo->motorola_intel);
	components = php_ifd_get32u(dir_entry+4, ImageInfo->motorola_intel);
}

static bool exif_process_IFD_TAG(image_info_type *ImageInfo, char *dir_entry, const exif_offset_info *info, size_t displacement, int section_index, int ReadNextIFD, tag_table_type tag_table)
{
	bool result;
	/* Protect against corrupt headers */
	if (ImageInfo->ifd_count++ > MAX_IFD_TAGS) {
		exif_error_docref("exif_read_data#error_ifd" EXIFERR_CC, ImageInfo, E_WARNING, "corrupt EXIF header: maximum IFD tag count reached");
		return false;
	}
	if (ImageInfo->ifd_nesting_level > MAX_IFD_NESTING_LEVEL) {
		exif_error_docref("exif_read_data#error_ifd" EXIFERR_CC, ImageInfo, E_WARNING, "corrupt EXIF header: maximum directory nesting level reached");
		return false;
	}
	ImageInfo->ifd_nesting_level++;
	result = exif_process_IFD_TAG_impl(ImageInfo, dir_entry, info, displacement, section_index, ReadNextIFD, tag_table);
	ImageInfo->ifd_nesting_level--;
	return result;
}

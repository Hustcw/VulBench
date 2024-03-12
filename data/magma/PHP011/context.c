/* Base address for offset references, together with valid memory range.
 * The valid range does not necessarily include the offset base. */
typedef struct {
	char *offset_base;
	char *valid_start; /* inclusive */
	char *valid_end;   /* exclusive */
} exif_offset_info;

/* {{{ exif_thumbnail_extract
 * Grab the thumbnail, corrected */
static void exif_thumbnail_extract(image_info_type *ImageInfo, const exif_offset_info *info) {
	if (ImageInfo->Thumbnail.data) {
		exif_error_docref("exif_read_data#error_mult_thumb" EXIFERR_CC, ImageInfo, E_WARNING, "Multiple possible thumbnails");
		return; /* Should not happen */
	}
	if (!ImageInfo->read_thumbnail)	{
		return; /* ignore this call */
	}
	/* according to exif2.1, the thumbnail is not supposed to be greater than 64K */
	if (ImageInfo->Thumbnail.size >= 65536
	 || ImageInfo->Thumbnail.size <= 0
	 || ImageInfo->Thumbnail.offset <= 0
	) {
		exif_error_docref(NULL EXIFERR_CC, ImageInfo, E_WARNING, "Illegal thumbnail size/offset");
		return;
	}
	/* Check to make sure we are not going to go past the ExifLength */
	char *thumbnail = exif_offset_info_try_get(
		info, ImageInfo->Thumbnail.offset, ImageInfo->Thumbnail.size);
	if (!thumbnail) {
		EXIF_ERRLOG_THUMBEOF(ImageInfo)
		return;
	}
	ImageInfo->Thumbnail.data = estrndup(thumbnail, ImageInfo->Thumbnail.size);
	exif_thumbnail_build(ImageInfo);
}
/* }}} */

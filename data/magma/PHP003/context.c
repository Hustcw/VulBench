typedef struct {
	image_filetype  filetype;
	size_t          width, height;
	size_t          size;
	size_t          offset;
	char 	        *data;
} thumbnail_data;

/* This structure is used to store a section of a Jpeg file. */
typedef struct {
	php_stream      *infile;
	char            *FileName;
	time_t          FileDateTime;
	size_t          FileSize;
	image_filetype  FileType;
	int             Height, Width;
	int             IsColor;

	char            *make;
	char            *model;

	float           ApertureFNumber;
	float           ExposureTime;
	double          FocalplaneUnits;
	float           CCDWidth;
	double          FocalplaneXRes;
	size_t          ExifImageWidth;
	float           FocalLength;
	float           Distance;

	int             motorola_intel; /* 1 Motorola; 0 Intel */

	char            *UserComment;
	int             UserCommentLength;
	char            *UserCommentEncoding;
	char            *encode_unicode;
	char            *decode_unicode_be;
	char            *decode_unicode_le;
	char            *encode_jis;
	char            *decode_jis_be;
	char            *decode_jis_le;
	char            *Copyright;/* EXIF standard defines Copyright as "<Photographer> [ '\0' <Editor> ] ['\0']" */
	char            *CopyrightPhotographer;
	char            *CopyrightEditor;

	xp_field_list   xp_fields;

	thumbnail_data  Thumbnail;
	/* other */
	int             sections_found; /* FOUND_<marker> */
	image_info_list info_list[SECTION_COUNT];
	/* for parsing */
	int             read_thumbnail;
	int             read_all;
	int             ifd_nesting_level;
	int             ifd_count;
	int             num_errors;
	/* internal */
	file_section_list 	file;
} image_info_type;

static jas_image_cmpt_t *jas_image_cmpt_create(int_fast32_t tlx,
  int_fast32_t tly, int_fast32_t hstep, int_fast32_t vstep,
  int_fast32_t width, int_fast32_t height, uint_fast16_t depth, bool sgnd,
  uint_fast32_t inmem)
{
 	jas_image_cmpt_t *cmpt;
 	size_t size;
 
 	cmpt = 0;
 	if (width < 0 || height < 0 || hstep <= 0 || vstep <= 0) {
 		goto error;
	}
	if (!jas_safe_intfast32_add(tlx, width, 0) ||
 	  !jas_safe_intfast32_add(tly, height, 0)) {
 		goto error;
 	}
 
 	if (!(cmpt = jas_malloc(sizeof(jas_image_cmpt_t)))) {
 		goto error;
	}

	cmpt->type_ = JAS_IMAGE_CT_UNKNOWN;
	cmpt->tlx_ = tlx;
	cmpt->tly_ = tly;
	cmpt->hstep_ = hstep;
	cmpt->vstep_ = vstep;
	cmpt->width_ = width;
	cmpt->height_ = height;
	cmpt->prec_ = depth;
	cmpt->sgnd_ = sgnd;
	cmpt->stream_ = 0;
	cmpt->cps_ = (depth + 7) / 8;

	if (!jas_safe_size_mul(cmpt->width_, cmpt->height_, &size) ||
	  !jas_safe_size_mul(size, cmpt->cps_, &size)) {
 		goto error;
 	}
 	cmpt->stream_ = (inmem) ? jas_stream_memopen2(0, size) :
	  jas_stream_tmpfile();
	if (!cmpt->stream_) {
		goto error;
	}

	/* Zero the component data.  This isn't necessary, but it is
	convenient for debugging purposes. */
	/* Note: conversion of size - 1 to long can overflow */
	if (size > 0) {
		if (size - 1 > LONG_MAX) {
			goto error;
		}
		if (jas_stream_seek(cmpt->stream_, size - 1, SEEK_SET) < 0 ||
		  jas_stream_putc(cmpt->stream_, 0) == EOF ||
		  jas_stream_seek(cmpt->stream_, 0, SEEK_SET) < 0) {
			goto error;
		}
	}

	return cmpt;

error:
	if (cmpt) {
		jas_image_cmpt_destroy(cmpt);
	}
	return 0;
}

static inline void
header_put_be_int (SF_PRIVATE *psf, int x)
{	psf->header.ptr [psf->header.indx++] = (x >> 24) ;
	psf->header.ptr [psf->header.indx++] = (x >> 16) ;
	psf->header.ptr [psf->header.indx++] = (x >> 8) ;
	psf->header.ptr [psf->header.indx++] = x ;
} /* header_put_be_int */

static inline void
header_put_le_int (SF_PRIVATE *psf, int x)
{	psf->header.ptr [psf->header.indx++] = x ;
	psf->header.ptr [psf->header.indx++] = (x >> 8) ;
	psf->header.ptr [psf->header.indx++] = (x >> 16) ;
	psf->header.ptr [psf->header.indx++] = (x >> 24) ;
} /* header_put_le_int */

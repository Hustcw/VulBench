sf_open_fd	(int fd, int mode, SF_INFO *sfinfo, int close_desc)
{	SF_PRIVATE 	*psf ;

	if ((SF_CONTAINER (sfinfo->format)) == SF_FORMAT_SD2)
	{	sf_errno = SFE_SD2_FD_DISALLOWED ;
 		return	NULL ;
 		} ;
 
	if ((psf = calloc (1, sizeof (SF_PRIVATE))) == NULL)
 	{	sf_errno = SFE_MALLOC_FAILED ;
 		return	NULL ;
 		} ;

	psf_init_files (psf) ;
	copy_filename (psf, "") ;

	psf->file.mode = mode ;
	psf_set_file (psf, fd) ;
	psf->is_pipe = psf_is_pipe (psf) ;
	psf->fileoffset = psf_ftell (psf) ;

	if (! close_desc)
		psf->file.do_not_close_descriptor = SF_TRUE ;

	return psf_open_file (psf, sfinfo) ;
} /* sf_open_fd */

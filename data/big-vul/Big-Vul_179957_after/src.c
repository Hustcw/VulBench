devzvol_readdir(struct vnode *dvp, struct uio *uiop, struct cred *cred,
    int *eofp, caller_context_t *ct_unused, int flags_unused)
{
	struct sdev_node *sdvp = VTOSDEV(dvp);
	char *ptr;

	sdcmn_err13(("zv readdir of '%s' %s'", sdvp->sdev_path,
	    sdvp->sdev_name));

	if (strcmp(sdvp->sdev_path, ZVOL_DIR) == 0) {
		struct vnode *vp;

		rw_exit(&sdvp->sdev_contents);
		(void) devname_lookup_func(sdvp, "dsk", &vp, cred,
		    devzvol_create_dir, SDEV_VATTR);
		VN_RELE(vp);
		(void) devname_lookup_func(sdvp, "rdsk", &vp, cred,
		    devzvol_create_dir, SDEV_VATTR);
		VN_RELE(vp);
		rw_enter(&sdvp->sdev_contents, RW_READER);
		return (devname_readdir_func(dvp, uiop, cred, eofp, 0));
	}
	if (uiop->uio_offset == 0)
		devzvol_prunedir(sdvp);
	ptr = sdvp->sdev_path + strlen(ZVOL_DIR);
	if ((strcmp(ptr, "/dsk") == 0) || (strcmp(ptr, "/rdsk") == 0)) {
		rw_exit(&sdvp->sdev_contents);
		devzvol_create_pool_dirs(dvp);
		rw_enter(&sdvp->sdev_contents, RW_READER);
 		return (devname_readdir_func(dvp, uiop, cred, eofp, 0));
 	}
 
	ptr = strchr(ptr + 1, '/');
	if (ptr == NULL)
		return (ENOENT);
	ptr++;
 	rw_exit(&sdvp->sdev_contents);
 	sdev_iter_datasets(dvp, ZFS_IOC_DATASET_LIST_NEXT, ptr);
 	rw_enter(&sdvp->sdev_contents, RW_READER);
	return (devname_readdir_func(dvp, uiop, cred, eofp, 0));
}

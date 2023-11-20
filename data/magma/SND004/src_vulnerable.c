sf_count_t psf_fwrite(const void *ptr, sf_count_t bytes, sf_count_t items,
                      SF_PRIVATE *psf) {
  sf_count_t total = 0;
  ssize_t count;


  if (psf->virtual_io)
    return psf->vio.write(ptr, bytes * items, psf->vio_user_data) / bytes;

  items *= bytes;

  /* Do this check after the multiplication above. */
  if (items <= 0)
    return 0;

  while (items > 0) { /* Break the writes down to a sensible size. */
    count = (items > SENSIBLE_SIZE) ? SENSIBLE_SIZE : items;

    count = write(psf->file.filedes, ((const char *)ptr) + total, count);

    if (count == -1) {
      if (errno == EINTR)
        continue;

      psf_log_syserr(psf, errno);
      break;
    };

    if (count == 0)
      break;

    total += count;
    items -= count;
  };

  if (psf->is_pipe)
    psf->pipeoffset += total;

  return total / bytes;
} /* psf_fwrite */


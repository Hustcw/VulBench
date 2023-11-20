static int png_image_free_function(png_voidp argument) {
  png_imagep image = png_voidcast(png_imagep, argument);
  png_controlp cp = image->opaque;
  png_control c;

  /* Double check that we have a png_ptr - it should be impossible to get here
   * without one.
   */
  if (cp->png_ptr == NULL)
    return 0;

    /* First free any data held in the control structure. */
#ifdef PNG_STDIO_SUPPORTED
  if (cp->owned_file != 0) {
    FILE *fp = png_voidcast(FILE *, cp->png_ptr->io_ptr);
    cp->owned_file = 0;

    /* Ignore errors here. */
    if (fp != NULL) {
      cp->png_ptr->io_ptr = NULL;
      (void)fclose(fp);
    }
  }
#endif

  /* Copy the control structure so that the original, allocated, version can be
   * safely freed.  Notice that a png_error here stops the remainder of the
   * cleanup, but this is probably fine because that would indicate bad memory
   * problems anyway.
   */
  c = *cp;
  image->opaque = &c;
  png_free(c.png_ptr, cp);

  /* Then the structures, calling the correct API. */
  if (c.for_write != 0) {
#ifdef PNG_SIMPLIFIED_WRITE_SUPPORTED
    png_destroy_write_struct(&c.png_ptr, &c.info_ptr);
#else
    png_error(c.png_ptr, "simplified write not supported");
#endif
  } else {
#ifdef PNG_SIMPLIFIED_READ_SUPPORTED
    png_destroy_read_struct(&c.png_ptr, &c.info_ptr, NULL);
#else
    png_error(c.png_ptr, "simplified read not supported");
#endif
  }


  /* Success. */
  return 1;
}
void PNGAPI png_image_free(png_imagep image) {
  /* Safely call the real function, but only if doing so is safe at this point
   * (if not inside an error handling context).  Otherwise assume
   * png_safe_execute will call this API after the return.
   */
  if (image != NULL && image->opaque != NULL &&
      image->opaque->error_buf == NULL) {
    png_image_free_function(image);
    image->opaque = NULL;
  }
}
int /* PRIVATE */
png_safe_execute(png_imagep image_in, int (*function)(png_voidp),
                 png_voidp arg) {
  volatile png_imagep image = image_in;
  volatile int result;
  volatile png_voidp saved_error_buf;
  jmp_buf safe_jmpbuf;

  /* Safely execute function(arg) with png_error returning to this function. */
  saved_error_buf = image->opaque->error_buf;
  result = setjmp(safe_jmpbuf) == 0;

  if (result != 0) {

    image->opaque->error_buf = safe_jmpbuf;
    result = function(arg);
  }


  image->opaque->error_buf = saved_error_buf;

  /* And do the cleanup prior to any failure return. */
  if (result == 0)
    png_image_free(image);

  return result;
}

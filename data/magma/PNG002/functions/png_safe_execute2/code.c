

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
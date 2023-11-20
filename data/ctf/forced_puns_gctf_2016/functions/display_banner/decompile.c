ssize_t display_banner()
{
  ssize_t result;

  result = write(1, banner, (unsigned int)banner_len);
  if ( result != banner_len )
    err(1, "writing banner");
  return result;
}

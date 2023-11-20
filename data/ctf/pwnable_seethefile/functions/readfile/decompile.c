size_t readfile()
{
  size_t result;

  memset(magicbuf, 0, 0x190u);
  if ( !fp )
    return puts("You need to open a file first");
  result = fread(magicbuf, 0x18Fu, 1u, fp);
  if ( result )
    return puts("Read Successful");
  return result;
}

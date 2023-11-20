int writefile()
{
  if ( strstr(filename, "flag") || strstr(magicbuf, "FLAG") || strchr(magicbuf, 125) )
  {
    puts("you can't see it");
    exit(1);
  }
  return puts(magicbuf);
}

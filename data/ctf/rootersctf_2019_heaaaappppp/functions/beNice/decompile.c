int beNice()
{
  return setvbuf(_bss_start, 0LL, 2, 0LL);
}

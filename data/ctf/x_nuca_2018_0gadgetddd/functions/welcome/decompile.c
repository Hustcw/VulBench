ssize_t welcome()
{
  ssize_t result;
  int i;

  setvbuf(stdin, 0LL, 2, 0LL);
  setvbuf(stdout, 0LL, 2, 0LL);
  fclose(stderr);
  alarm(0x3Cu);
  result = write(1, "Welcome!\n", 9uLL);
  for ( i = 0; i <= 15; ++i )
  {
    result = 160LL * i + 6299872;
    *((_DWORD *)&notebook + 40 * i) = 0;
  }
  return result;
}

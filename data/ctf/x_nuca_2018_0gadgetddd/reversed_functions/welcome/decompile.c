Notebook *welcome()
{
  Notebook *result;
  int i;

  setvbuf(stdin, 0LL, 2, 0LL);
  setvbuf(stdout, 0LL, 2, 0LL);
  fclose(stderr);
  alarm(0x3Cu);
  result = (Notebook *)write(1, "Welcome!\n", 9uLL);
  for ( i = 0; i <= 15; ++i )
  {
    result = &notebook[i];
    result->used = 0;
  }
  return result;
}
static inline void d2alaw_array(const double *ptr, int count,
                                unsigned char *buffer, double normfact) {
  for (int i = 0; i < count; i++)
  {
    if (ptr[i] >= 0)
      buffer[i] = alaw_encode[psf_lrint(normfact * ptr[i])];
    else
      buffer[i] = 0x7F & alaw_encode[-psf_lrint(normfact * ptr[i])];
  };
} /* d2alaw_array */


static inline void d2ulaw_array(const double *ptr, int count,
                                unsigned char *buffer, double normfact) {
  for (int i = 0; i < count; i++)
  {
    if (ptr[i] >= 0)
      buffer[i] = ulaw_encode[psf_lrint(normfact * ptr[i])];
    else
      buffer[i] = 0x7F & ulaw_encode[-psf_lrint(normfact * ptr[i])];
  };
} /* d2ulaw_array */


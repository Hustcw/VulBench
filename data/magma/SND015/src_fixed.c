static inline void i2alaw_array(const int *ptr, int count,
                                unsigned char *buffer) {
  for (int i = 0; i < count; i++)
  {
    if (ptr[i] == INT_MIN)
      buffer[i] = alaw_encode[INT_MAX >> (16 + 4)];
    else if (ptr[i] >= 0)
      buffer[i] = alaw_encode[ptr[i] >> (16 + 4)];
    else
      buffer[i] = 0x7F & alaw_encode[-ptr[i] >> (16 + 4)];
  };
} /* i2alaw_array */

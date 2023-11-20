static inline void i2ulaw_array(const int *ptr, int count,
                                unsigned char *buffer) {
  for (int i = 0; i < count; i++)
  {
    if (ptr[i] == INT_MIN)
      buffer[i] = ulaw_encode[INT_MAX >> (16 + 2)];
    else if (ptr[i] >= 0)
      buffer[i] = ulaw_encode[ptr[i] >> (16 + 2)];
    else
      buffer[i] = 0x7F & ulaw_encode[-ptr[i] >> (16 + 2)];
  };
} /* i2ulaw_array */

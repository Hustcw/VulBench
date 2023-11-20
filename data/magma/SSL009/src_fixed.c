unsigned int X509v3_addr_get_afi(const IPAddressFamily *f) {
  if (f == NULL || f->addressFamily == NULL || f->addressFamily->data == NULL ||
      f->addressFamily->length < 2)
    return 0;
  return (f->addressFamily->data[0] << 8) | f->addressFamily->data[1];
}

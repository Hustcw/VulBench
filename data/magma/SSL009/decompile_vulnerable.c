unsigned int __fastcall X509v3_addr_get_afi(const IPAddressFamily *f)
{
  unsigned int result;
  unsigned __int8 *data;

  result = 0;
  if ( f && f->addressFamily )
  {
    data = f->addressFamily->data;
    if ( data )
      return (*data << 8) | data[1];
  }
  return result;
}

unsigned int __fastcall X509v3_addr_get_afi(const IPAddressFamily *f)
{
  unsigned int result;
  ASN1_OCTET_STRING *addressFamily;
  unsigned __int8 *data;

  result = 0;
  if ( f )
  {
    addressFamily = f->addressFamily;
    if ( f->addressFamily )
    {
      data = addressFamily->data;
      if ( data )
      {
        if ( addressFamily->length >= 2 )
          return (*data << 8) | data[1];
      }
    }
  }
  return result;
}

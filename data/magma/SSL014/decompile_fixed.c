int __fastcall ASN1_TYPE_cmp(const ASN1_TYPE_0 *a, const ASN1_TYPE_0 *b)
{
  int result;
  int type;

  result = -1;
  if ( a )
  {
    if ( b )
    {
      type = a->type;
      if ( a->type == b->type )
      {
        switch ( type )
        {
          case 1:
            return a->value.boolean - b->value.boolean;
          case 5:
            return 0;
          case 6:
            return OBJ_cmp(a->value.object, b->value.object);
          default:
            return ASN1_STRING_cmp(a->value.asn1_string, b->value.asn1_string);
        }
      }
    }
  }
  return result;
}

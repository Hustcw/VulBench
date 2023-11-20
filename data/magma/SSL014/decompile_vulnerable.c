int __fastcall ASN1_TYPE_cmp(const ASN1_TYPE *a, const ASN1_TYPE *b)
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
        if ( type == 5 )
        {
          return 0;
        }
        else if ( type == 6 )
        {
          return OBJ_cmp(a->value.object, b->value.object);
        }
        else
        {
          return ASN1_STRING_cmp(a->value.asn1_string, b->value.asn1_string);
        }
      }
    }
  }
  return result;
}

char *__fastcall request_header(const char *a1)
{
  Header *i;

  for ( i = reqhdr; i->name; ++i )
  {
    if ( !strcmp(i->name, a1) )
      return i->value;
  }
  return 0LL;
}
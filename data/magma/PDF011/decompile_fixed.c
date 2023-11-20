XRefEntry *__fastcall XRef::getEntry(XRef *this, int i, bool complainIfMissing)
{
  __int64 v5;
  __int64 v6;
  __int64 v7;
  const char *v9;
  ErrorCategory v10;

  if ( i < 0 )
  {
    v9 = "Request for invalid XRef entry [{0:d}]";
    goto LABEL_18;
  }
  if ( *((_DWORD *)this + 7) > i )
  {
    v5 = *((_QWORD *)this + 2);
    v6 = i;
    if ( *(_DWORD *)(v5 + 40LL * i + 12) != 3 )
      return (XRefEntry *)(v5 + 40 * v6);
  }
  if ( !*((_BYTE *)this + 200) )
  {
    v7 = *((_QWORD *)this + 24);
    if ( v7 )
    {
      if ( *((_DWORD *)this + 6) > i )
      {
        v6 = i;
        if ( XRef::parseEntry(this, 20 * i + v7, (XRefEntry *)(*((_QWORD *)this + 2) + 40LL * i)) )
        {
          v5 = *((_QWORD *)this + 2);
          return (XRefEntry *)(v5 + 40 * v6);
        }
        v9 = "Failed to parse XRef entry [{0:d}].";
        v10 = ErrorCategory::errSyntaxError;
        goto LABEL_16;
      }
      v9 = "Request for out-of-bounds XRef entry [{0:d}]";
LABEL_18:
      v10 = ErrorCategory::errInternal;
LABEL_16:
      error(v10, -1LL, v9, (unsigned int)i);
      return &`anonymous namespace'::dummyXRefEntry;
    }
  }
  XRef::readXRefUntil(this, i, 0LL);
  if ( *((_DWORD *)this + 7) > i )
  {
    v6 = i;
    v5 = *((_QWORD *)this + 2);
    if ( *(_DWORD *)(v5 + 40LL * i + 12) == 3 )
    {
      if ( complainIfMissing )
      {
        error(ErrorCategory::errSyntaxError, -1LL, "Invalid XRef entry {0:d}", (unsigned int)i);
        v5 = *((_QWORD *)this + 2);
      }
      *(_DWORD *)(v5 + 40LL * i + 12) = 0;
    }
    return (XRefEntry *)(v5 + 40 * v6);
  }
  return &`anonymous namespace'::dummyXRefEntry;
}

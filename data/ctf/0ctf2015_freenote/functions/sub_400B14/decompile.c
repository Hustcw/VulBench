int sub_400B14()
{
  __int64 v0;
  unsigned int i;

  if ( *(__int64 *)(qword_6020A8 + 8) <= 0 )
  {
    LODWORD(v0) = puts("You need to create some new notes first.");
  }
  else
  {
    for ( i = 0; ; ++i )
    {
      v0 = *(_QWORD *)qword_6020A8;
      if ( (int)i >= *(_QWORD *)qword_6020A8 )
        break;
      if ( *(_QWORD *)(qword_6020A8 + 24LL * (int)i + 16) == 1LL )
        printf("%d. %s\n", i, *(const char **)(qword_6020A8 + 24LL * (int)i + 32));
    }
  }
  return v0;
}

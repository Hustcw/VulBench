int __fastcall sub_4018CA(__int64 a1)
{
  int result;
  int i;

  if ( a1 )
  {
    result = *(_DWORD *)(a1 + 12);
    if ( result != -1 )
    {
      for ( i = 0; i < *(_DWORD *)(a1 + 12); ++i )
        printf("%d ", *(_QWORD *)(8LL * i + *(_QWORD *)a1));
      return printf("%d\n", *(_QWORD *)(*(_QWORD *)a1 + 8LL * *(int *)(a1 + 12)));
    }
  }
  return result;
}

int __fastcall sub_40184C(__int64 a1)
{
  __int64 v1;

  v1 = *(_QWORD *)(a1 + 24);
  if ( v1 <= 0 )
  {
    if ( *(__int64 *)(a1 + 16) > 2 )
    {
      sub_4018D4(a1);
      exit(-1);
    }
    puts("You Win! Boss is upgrading..");
    sub_4013A0((_QWORD *)(a1 + 16), *(_QWORD *)(a1 + 16) + 1);
    LODWORD(v1) = printf("level:%d\n", *(_QWORD *)(a1 + 16) + 1LL);
  }
  return v1;
}

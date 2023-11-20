unsigned int __fastcall sub_40117C(__int64 a1)
{
  if ( !strcmp((const char *)a1, s2) )
  {
    sub_400CEC((_QWORD *)(a1 + 40));
    return sleep(1u);
  }
  else if ( !strcmp((const char *)a1, aIceball) )
  {
    sleep(0);
    return (unsigned int)sub_400D58((_QWORD *)(a1 + 40));
  }
  else if ( !strcmp((const char *)a1, aMagicball) )
  {
    sleep(0);
    return (unsigned int)sub_400DA0((_QWORD *)(a1 + 40));
  }
  else if ( !strcmp((const char *)a1, aLightning) )
  {
    sub_400E40((_QWORD *)(a1 + 40));
    return sleep(0);
  }
  else if ( !strcmp((const char *)a1, aHellfire) )
  {
    sub_400EC8((__int64 *)(a1 + 40));
    return sleep(0);
  }
  else if ( !strcmp((const char *)a1, aIcesword) )
  {
    sub_400F46((_QWORD *)(a1 + 40));
    return sleep(1u);
  }
  else if ( !strcmp((const char *)a1, aMagicsword) )
  {
    sub_400FA6((__int64 *)(a1 + 40));
    return sleep(0);
  }
  else if ( !strcmp((const char *)a1, aHollylight) )
  {
    sub_40105E((_QWORD *)(a1 + 40));
    return sleep(0);
  }
  else
  {
    return sub_4010EE(a1);
  }
}

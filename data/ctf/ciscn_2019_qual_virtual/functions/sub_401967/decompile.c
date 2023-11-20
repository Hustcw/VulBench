__int64 __fastcall sub_401967(__int64 a1, __int64 a2, __int64 a3)
{
  unsigned int v5;
  __int64 v6;

  v5 = 1;
  while ( v5 && (unsigned int)sub_4014B4(a1, &v6) )
  {
    switch ( v6 )
    {
      case 17LL:
        v5 = sub_401AAC(a3, a2);
        break;
      case 18LL:
        v5 = sub_401AF8(a3, a2);
        break;
      case 33LL:
        v5 = sub_401B44(a3, a2);
        break;
      case 34LL:
        v5 = sub_401BA5(a3, a2);
        break;
      case 35LL:
        v5 = sub_401C06(a3, a2);
        break;
      case 36LL:
        v5 = sub_401C68(a3, a2);
        break;
      case 49LL:
        v5 = sub_401CCE(a3, a2);
        break;
      case 50LL:
        v5 = sub_401D37(a3, a2);
        break;
      default:
        v5 = 0;
        break;
    }
  }
  return v5;
}

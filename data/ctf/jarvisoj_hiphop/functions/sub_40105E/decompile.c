_QWORD *__fastcall sub_40105E(_QWORD *a1)
{
  _QWORD *result;
  unsigned int v2;

  v2 = rand() % 5;
  result = (_QWORD *)v2;
  switch ( v2 )
  {
    case 0u:
      *a1 = 10LL;
      goto LABEL_3;
    case 1u:
LABEL_3:
      *a1 = 0xFFFFLL;
      goto LABEL_4;
    case 2u:
LABEL_4:
      *a1 = 0xFFFFFFFLL;
      goto LABEL_5;
    case 3u:
LABEL_5:
      *a1 = 0xFFFFFFFFLL;
      goto LABEL_6;
    case 4u:
LABEL_6:
      result = a1;
      *a1 = 0xFFFFFFFFFLL;
      break;
    default:
      return result;
  }
  return result;
}

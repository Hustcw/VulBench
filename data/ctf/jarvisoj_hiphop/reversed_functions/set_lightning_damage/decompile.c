void __fastcall set_lightning_damage(_QWORD *a1)
{
  switch ( rand() % 5 )
  {
    case 0:
      *a1 = 1LL;
      goto LABEL_3;
    case 1:
LABEL_3:
      *a1 = 10LL;
      goto LABEL_4;
    case 2:
LABEL_4:
      *a1 = 20LL;
      goto LABEL_5;
    case 3:
LABEL_5:
      *a1 = 100LL;
      goto LABEL_6;
    case 4:
LABEL_6:
      *a1 = 200LL;
      break;
    default:
      return;
  }
}
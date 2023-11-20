unsigned __int64 __fastcall sub_4019A4(_BYTE *a1)
{
  int v1;
  __int64 v2;
  __int64 v3;
  __int64 v4;
  int v6;
  int v7;
  int v8;
  unsigned __int64 v9;

  v9 = __readfsqword(0x28u);
  puts("\n========================================Boss' Attack");
  puts("Boss is Attacking you!");
  sub_401476();
  printf("choice:");
  scanf("%d", &v6);
  switch ( v6 )
  {
    case 2:
      a1[13] = 1;
      break;
    case 3:
      a1[14] = 1;
      break;
    case 1:
      a1[12] = 1;
      break;
  }
  v7 = rand();
  v8 = v7 % 4;
  v1 = v7 % 4;
  if ( v7 % 4 == 1 )
  {
    if ( a1[14] )
      goto LABEL_16;
    v3 = *(_QWORD *)a1;
    *(_QWORD *)a1 = v3 - sub_4013E2(a1 + 16);
  }
  else
  {
    if ( v1 == 2 )
    {
      if ( !a1[13] )
      {
        v4 = *(_QWORD *)a1;
        *(_QWORD *)a1 = v4 - sub_4013F2(a1 + 16);
        goto LABEL_18;
      }
      goto LABEL_16;
    }
    if ( !v1 )
    {
      if ( a1[12] )
      {
LABEL_16:
        puts("You succeed in defense");
        goto LABEL_18;
      }
      v2 = *(_QWORD *)a1;
      *(_QWORD *)a1 = v2 - sub_4013D2(a1 + 16);
    }
  }
LABEL_18:
  sub_40137C(a1);
  sub_40132E(a1);
  puts("========================================");
  return __readfsqword(0x28u) ^ v9;
}

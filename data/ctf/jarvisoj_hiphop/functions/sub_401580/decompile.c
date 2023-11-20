int __fastcall sub_401580(__int64 a1)
{
  int i;

  puts("\n========================================Skill Activation");
  printf("\rYou use %s\n", (const char *)(a1 + 32));
  for ( i = 0; i <= 8 && strcmp((const char *)(a1 + 32), &aAttack[32 * i]); ++i )
    ;
  sub_40117C(a1 + 32);
  if ( !byte_603380 )
  {
    byte_603380 = 1;
    if ( i <= 4 )
    {
      if ( *(__int64 *)(a1 + 72) >= 0 )
      {
        *(_QWORD *)(a1 + 24) -= (int)*(_QWORD *)(a1 + 72);
        printf("Boss's hp is %ld\n", *(_QWORD *)(a1 + 24));
        goto LABEL_14;
      }
    }
    else if ( *(__int64 *)(a1 + 72) >= 0 )
    {
      *(_QWORD *)(a1 + 24) -= *(_QWORD *)(a1 + 72);
      printf("Boss's hp is %ld\n", *(_QWORD *)(a1 + 24));
LABEL_14:
      sub_40184C(&unk_6033A0);
      byte_603380 = 0;
      goto LABEL_15;
    }
    puts("Damage can't be negative number!");
    goto LABEL_14;
  }
  printf("You are already using the skill. Skill failed to use:%s\n", (const char *)(a1 + 32));
LABEL_15:
  *(_QWORD *)(a1 + 72) = 0LL;
  return puts("\n=======================================");
}

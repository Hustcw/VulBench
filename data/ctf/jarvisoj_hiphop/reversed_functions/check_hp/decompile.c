void __fastcall check_hp(Data *a1)
{
  printf("Your HP is %d\n", a1->hp);
  if ( a1->hp <= 0 )
  {
    printf("game over");
    exit(-1);
  }
}
void __fastcall set_default_damage(Data2 *a1)
{
  int i;

  strcpy(a1->skill, "attack");
  set_50(&a1->damage);
  a1->b[0] = 0;
  for ( i = 1; i <= 7; ++i )
    a1->b[i] = 0;
}
void __fastcall update_damage(Data2 *a1)
{
  if ( !strcmp(a1->skill, s2) )
  {
    set_fireball_damage(&a1->damage);
    sleep(1u);
  }
  else if ( !strcmp(a1->skill, aIceball) )
  {
    sleep(0);
    set_iceball_damage(&a1->damage);
  }
  else if ( !strcmp(a1->skill, aMagicball) )
  {
    sleep(0);
    set_magicball_damage(&a1->damage);
  }
  else if ( !strcmp(a1->skill, aLightning) )
  {
    set_lightning_damage(&a1->damage);
    sleep(0);
  }
  else if ( !strcmp(a1->skill, aHellfire) )
  {
    set_hellfire_damage(&a1->damage);
    sleep(0);
  }
  else if ( !strcmp(a1->skill, aIcesword) )
  {
    set_icesword_damage(&a1->damage);
    sleep(1u);
  }
  else if ( !strcmp(a1->skill, aMagicsword) )
  {
    set_magicsword_damage(&a1->damage);
    sleep(0);
  }
  else if ( !strcmp(a1->skill, aHollylight) )
  {
    set_hollylight_damage(&a1->damage);
    sleep(0);
  }
  else
  {
    set_default_damage(a1);
  }
}
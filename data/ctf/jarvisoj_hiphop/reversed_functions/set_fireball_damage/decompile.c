void __fastcall set_fireball_damage(_QWORD *a1)
{
  *a1 = ((rand() % 1000) << 16) % 100;
}
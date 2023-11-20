void __fastcall set_hellfire_damage(__int64 *a1)
{
  *a1 = ((__int64)(rand() % 100000) << 16) % 1610612736;
}
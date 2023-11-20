void __fastcall set_magicsword_damage(__int64 *a1)
{
  __int64 v1;

  v1 = rand() % 100000;
  *a1 = (v1 << (rand() % 5)) % 0xFFFFFFFFFLL;
}
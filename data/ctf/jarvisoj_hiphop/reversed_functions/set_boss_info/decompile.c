void __fastcall set_boss_info(BossInfo *a1, int a2)
{
  a1->level = a2;
  a1->hp = level_hp_mapping[a1->level];
}
void __fastcall set_iceball_damage(_QWORD *a1)
{
  int v1;

  v1 = (unsigned __int16)rand();
  *a1 = v1 - 1000 * ((int)((unsigned __int64)(0x10624DD3LL * v1) >> 32) >> 6);
}
void __fastcall sub_CB6(unsigned __int8 *a1, __int64 a2)
{
  char v2;
  char v3;
  int a1a;
  int a1b;

  a1a = hash_str(a1);
  v3 = sub_AC7(a1);
  v2 = sub_B38(a1);
  a1b = (int)abs32(a1a) % 62;
  sub_B9A(a1b, (char *)a1, a2);
  sub_C14(a1b, v3, v2);
}
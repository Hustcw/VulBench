__int64 __fastcall do_unique(int *a1)
{
  std::unique<int *>(a1, &a1[n]);
  return show_num(a1);
}

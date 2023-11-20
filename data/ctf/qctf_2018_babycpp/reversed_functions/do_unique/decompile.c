void __fastcall do_unique(__gnu_cxx::__ops *a1)
{
  std::unique<int *>(a1, (_DWORD *)a1 + n);
  show_num((int *)a1);
}
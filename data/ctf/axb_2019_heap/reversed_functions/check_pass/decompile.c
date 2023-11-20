_BOOL8 __fastcall check_pass(_QWORD *a1)
{
  return *a1 - (_QWORD)a1 > 4096LL;
}
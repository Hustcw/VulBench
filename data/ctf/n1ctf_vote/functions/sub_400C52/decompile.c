int __fastcall sub_400C52(const char *a1)
{
  size_t v1;

  v1 = strlen(a1);
  write(1, a1, v1);
  return fflush(stdout);
}

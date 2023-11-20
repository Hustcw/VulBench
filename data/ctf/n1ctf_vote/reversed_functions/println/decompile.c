int __fastcall println(const char *a1)
{
  size_t v1;

  v1 = strlen(a1);
  write(1, a1, v1);
  write(1, &unk_401398, 1uLL);
  return fflush(stdout);
}
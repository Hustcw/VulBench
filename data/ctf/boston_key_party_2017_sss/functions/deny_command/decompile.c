int __fastcall deny_command(const char *a1)
{
  return printf("wrong signature for %s - it wasn't signed by me\n", a1);
}

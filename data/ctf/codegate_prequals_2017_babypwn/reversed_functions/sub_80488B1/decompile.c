ssize_t __cdecl sub_80488B1(const char *a1)
{
  size_t v1;

  v1 = strlen(a1);
  return send(fd, a1, v1, 0);
}
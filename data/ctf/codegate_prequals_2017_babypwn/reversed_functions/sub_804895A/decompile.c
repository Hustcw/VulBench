int sub_804895A()
{
  ssize_t v1;
  char nptr[120];

  sub_80488B1("Select menu > ");
  v1 = sub_8048907(nptr, 0x78u);
  nptr[v1 - 1] = 0;
  return atoi(nptr);
}
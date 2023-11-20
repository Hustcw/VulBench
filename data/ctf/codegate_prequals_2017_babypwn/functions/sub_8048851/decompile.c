unsigned int sub_8048851()
{
  unsigned int v1;

  v1 = __readgsdword(0x14u);
  sub_80488B1(&unk_804B0A0);
  return __readgsdword(0x14u) ^ v1;
}

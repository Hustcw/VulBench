unsigned int sub_8048881()
{
  unsigned int v1;

  v1 = __readgsdword(0x14u);
  sub_80488B1(&unk_8048F2C);
  return __readgsdword(0x14u) ^ v1;
}

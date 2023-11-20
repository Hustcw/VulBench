unsigned int sub_80486F7()
{
  unsigned int v1; // [esp+Ch] [ebp-Ch]

  v1 = __readgsdword(0x14u);
  fwrite("\n******************************************\n", 1u, 0x2Cu, stdout);
  fwrite("******We1c0me t0 b0ldfrev's noteb00k******\n", 1u, 0x2Bu, stdout);
  fwrite("******************************************\n", 1u, 0x2Bu, stdout);
  return __readgsdword(0x14u) ^ v1;
}
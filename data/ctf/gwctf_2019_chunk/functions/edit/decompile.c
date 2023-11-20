int edit()
{
  int v1;
  unsigned __int64 v2;

  v2 = __readfsqword(0x28u);
  printf("Which book to write?");
  _isoc99_scanf(&unk_1108, &v1);
  printf("Content: ");
  read_0(chunk[v1], size[v1]);
  return puts("Done!\n");
}

unsigned __int64 shownest()
{
  unsigned int v1; // [rsp+Ch] [rbp-14h]
  char buf[8]; // [rsp+10h] [rbp-10h] BYREF
  unsigned __int64 v3; // [rsp+18h] [rbp-8h]

  v3 = __readfsqword(0x28u);
  printf("Index :");
  read(0, buf, 4uLL);
  v1 = atoi(buf);
  if ( v1 >= 0xA )
  {
    puts("OOB!My Boy!");
    _exit(0);
  }
  if ( nests[v1] )
  {
    printf("Size : %ld\nDecorations : %s\n", nests[v1]->size, nests[v1]->content);
    puts("Done !");
  }
  else
  {
    puts("No such nest !");
  }
  return __readfsqword(0x28u) ^ v3;
}
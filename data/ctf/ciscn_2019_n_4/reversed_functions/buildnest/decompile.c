unsigned __int64 buildnest()
{
  Nest *v0; // rbx
  int i; // [rsp+4h] [rbp-2Ch]
  size_t size; // [rsp+8h] [rbp-28h]
  char buf[8]; // [rsp+10h] [rbp-20h] BYREF
  unsigned __int64 v5; // [rsp+18h] [rbp-18h]

  v5 = __readfsqword(0x28u);
  for ( i = 0; i <= 9; ++i )
  {
    if ( !nests[i] )
    {
      nests[i] = (Nest *)malloc(0x10uLL);
      if ( !nests[i] )
      {
        puts("Nope.something wrong..");
        exit(1);
      }
      printf("how big is the nest ?");
      read(0, buf, 8uLL);
      size = atoi(buf);
      v0 = nests[i];
      v0->content = (char *)malloc(size);
      if ( !nests[i]->content )
      {
        puts("Nope.something wrong..");
        exit(2);
      }
      nests[i]->size = size;
      printf("what stuff you wanna put in the nest?");
      myread(nests[i]->content, size);
      puts("Thx buddy.");
      return __readfsqword(0x28u) ^ v5;
    }
  }
  return __readfsqword(0x28u) ^ v5;
}
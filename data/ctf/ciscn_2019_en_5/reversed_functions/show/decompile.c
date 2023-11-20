unsigned __int64 show()
{
  unsigned int v1; // [rsp+4h] [rbp-Ch]
  unsigned __int64 v2; // [rsp+8h] [rbp-8h]

  v2 = __readfsqword(0x28u);
  printf("index> ");
  v1 = read_int();
  if ( v1 <= 0x13 && content[v1] )
    puts(content[v1]);
  else
    puts("invalid index");
  return __readfsqword(0x28u) ^ v2;
}
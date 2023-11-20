unsigned __int64 print_mem()
{
  unsigned int v1; // [rsp+4h] [rbp-Ch]
  unsigned __int64 v2; // [rsp+8h] [rbp-8h]

  v2 = __readfsqword(0x28u);
  printf("idx:");
  v1 = read_int();
  if ( v1 <= 0x13 && qword_4060[v1] )
    puts((const char *)qword_4060[v1]);
  else
    puts("invalid");
  return __readfsqword(0x28u) ^ v2;
}
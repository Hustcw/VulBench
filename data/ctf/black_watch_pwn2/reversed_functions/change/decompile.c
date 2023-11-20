int __fastcall change(RedPacket *a1)
{
  int v2;
  unsigned int v3;

  if ( qword_4010 <= 0 )
    exit_();
  --qword_4010;
  printf("Please input the red packet idx: ");
  v3 = read_int();
  if ( v3 > 0x10 || !a1[v3].content )
    exit_();
  printf("Please input content: ");
  v2 = read(0, a1[v3].content, a1[v3].size);
  if ( v2 <= 0 )
    exit_();
  a1[v3].content[v2 - 1] = 0;
  return puts("Done!");
}
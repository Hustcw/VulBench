void __fastcall watch(RedPacket *a1)
{
  unsigned int v1;

  printf("Please input the red packet idx: ");
  v1 = read_int();
  if ( v1 > 0x10 || !a1[v1].content )
    exit_();
  puts(a1[v1].content);
  puts("Done!");
}
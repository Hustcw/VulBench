unsigned __int64 sub_400A22()
{
  char buf[264];
  unsigned __int64 v2;

  v2 = __readfsqword(0x28u);
  puts("Oh,man.Play with the stack is really dangerous,so u can only play once..");
  if ( !dword_602060 )
  {
    dword_602060 = 1;
    read(0, buf, 0x1000uLL);
    puts(buf);
  }
  return __readfsqword(0x28u) ^ v2;
}

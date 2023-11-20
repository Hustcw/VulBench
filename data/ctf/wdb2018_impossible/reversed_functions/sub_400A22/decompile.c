void sub_400A22()
{
  char buf[264];

  puts("Oh,man.Play with the stack is really dangerous,so u can only play once..");
  if ( !dword_602060 )
  {
    dword_602060 = 1;
    read(0, buf, 0x1000uLL);
    puts(buf);
  }
}
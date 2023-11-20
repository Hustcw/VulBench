int read_int()
{
  char buf[16]; // [esp+Ch] [ebp-1Ch] BYREF
  unsigned int v2; // [esp+1Ch] [ebp-Ch]

  v2 = __readgsdword(0x14u);
  if ( read(0, buf, 0xFu) <= 0 )
  {
    puts("read error");
    exit(1);
  }
  return atoi(buf);
}
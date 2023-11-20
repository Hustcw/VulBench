ssize_t sub_13E3()
{
  char buf[128];

  if ( *(__int64 *)(qword_4058 + 2048) <= 0x7F0000000000LL
    || *(_QWORD *)(qword_4058 + 2040)
    || *(_QWORD *)(qword_4058 + 2056) )
  {
    sub_1521();
  }
  puts("You get red packet!");
  printf("What do you want to say?");
  return read(0, buf, 0x90uLL);
}

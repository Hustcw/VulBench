void backdoor()
{
  char buf[128];

  if ( *(__int64 *)(qword_4058 + 2048) <= 0x7F0000000000LL
    || *(_QWORD *)(qword_4058 + 2040)
    || *(_QWORD *)(qword_4058 + 2056) )
  {
    exit_();
  }
  puts("You get red packet!");
  printf("What do you want to say?");
  read(0, buf, 0x90uLL);
}
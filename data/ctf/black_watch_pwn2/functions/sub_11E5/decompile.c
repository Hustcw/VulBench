unsigned int sub_11E5()
{
  setbuf(stdin, 0LL);
  setbuf(stdout, 0LL);
  setbuf(stderr, 0LL);
  qword_4058 = (__int64)malloc(0x1000uLL);
  if ( !qword_4058 )
  {
    puts("What?");
    exit(-1);
  }
  qword_4050 = qword_4058 & 0xFFFFFFFFFFFFF000LL;
  memset(&unk_4060, 0, 0x100uLL);
  return alarm(0x1Eu);
}

void __cdecl initProc()
{
  sock_fprog sfp;
  sock_filter sfi[8];

  setvbuf(stdin, 0LL, 2, 0LL);
  setvbuf(stdout, 0LL, 2, 0LL);
  signal(14, (__sighandler_t)alarmHandler);
  alarm(0x1Eu);
  prctl(38, 1LL, 0LL, 0LL, 0LL);
  sfi[0].code = 32;
  sfi[0].jt = 0;
  sfi[0].jf = 0;
  sfi[0].k = 4;
  sfi[1].code = 21;
  sfi[1].jt = 0;
  sfi[1].jf = 5;
  sfi[1].k = -1073741762;
  sfi[2].code = 32;
  sfi[2].jt = 0;
  sfi[2].jf = 0;
  sfi[2].k = 0;
  sfi[3].code = 53;
  sfi[3].jt = 0;
  sfi[3].jf = 1;
  sfi[3].k = 0x40000000;
  sfi[4].code = 21;
  sfi[4].jt = 0;
  sfi[4].jf = 2;
  sfi[4].k = -1;
  sfi[5].code = 21;
  sfi[5].jt = 1;
  sfi[5].jf = 0;
  sfi[5].k = 59;
  sfi[6].code = 6;
  sfi[6].jt = 0;
  sfi[6].jf = 0;
  sfi[6].k = 2147418112;
  sfi[7].code = 6;
  sfi[7].jt = 0;
  sfi[7].jf = 0;
  sfi[7].k = 0;
  sfp.len = 8;
  sfp.filter = sfi;
  prctl(22, 2LL, &sfp);
}

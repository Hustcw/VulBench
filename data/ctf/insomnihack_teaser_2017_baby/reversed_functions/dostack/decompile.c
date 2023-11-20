__int64 __fastcall dostack(unsigned int a1)
{
  int v2;
  char buf[1032];
  unsigned __int64 v4;

  v4 = __readfsqword(0x28u);
  sendstr(a1, "How much bytes you want to send ? ");
  recv(a1, buf, 0xAuLL, 0);
  v2 = atoi(buf);
  recvlen(a1, (__int64)buf, v2);
  sendstr(a1, "Good luck !\n");
  return 0LL;
}
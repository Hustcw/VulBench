unsigned int sub_400A00()
{
  setvbuf((FILE *)stdout, 0, 2, 0);
  setvbuf((FILE *)stdin, 0, 2, 0);
  signal(14, (__sighandler_t)sub_4009E0);
  return alarm(0);
}

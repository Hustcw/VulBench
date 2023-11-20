__int64 __fastcall main(int a1, char **a2, char **a3)
{
  pthread_t newthread[2];

  newthread[1] = __readfsqword(0x28u);
  setbuf(stdin, 0LL);
  setbuf(stdout, 0LL);
  puts(byte_400C96);
  puts(" #   #    ####    #####  ######");
  puts("  # #    #    #     #    #");
  puts("### ###  #          #    #####");
  puts("  # #    #          #    #");
  puts(" #   #   #    #     #    #");
  puts("          ####      #    #");
  puts(byte_400C96);
  pthread_create(newthread, 0LL, start_routine, 0LL);
  if ( pthread_join(newthread[0], 0LL) )
  {
    puts("exit failure");
    return 1LL;
  }
  else
  {
    puts("Bye bye");
    return 0LL;
  }
}

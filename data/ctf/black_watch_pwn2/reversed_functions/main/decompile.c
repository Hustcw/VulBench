void __fastcall __noreturn main(__int64 a1, char **a2, char **a3)
{
  int v3;

  sub_128F();
  while ( 1 )
  {
    while ( 1 )
    {
      while ( 1 )
      {
        menu();
        v3 = read_int();
        if ( v3 != 3 )
          break;
        change(red_packet_list);
      }
      if ( v3 > 3 )
        break;
      if ( v3 == 1 )
      {
        if ( get_tries <= 0 )
          exit_();
        get(red_packet_list);
        --get_tries;
      }
      else
      {
        if ( v3 != 2 )
          goto LABEL_19;
        throw(red_packet_list);
      }
    }
    if ( v3 == 5 )
      exit_();
    if ( v3 < 5 )
    {
      watch(red_packet_list);
    }
    else
    {
      if ( v3 != 666 )
LABEL_19:
        exit_();
      backdoor();
    }
  }
}
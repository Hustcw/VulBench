int check_pos()
{
  int result;

  result = abs32(dword_8057F88 - dword_8058150);
  if ( result > 2 )
  {
    if ( result <= 9 )
    {
      puts("So hot!!");
      result = dword_8057F90 - 1;
      dword_8057F90 = result;
      if ( result <= 0 )
        do_die("*Burned to death*");
    }
  }
  else
  {
    puts("TttsSSSss ... lava is good for you.");
    result = dword_8057F90 - 40;
    dword_8057F90 = result;
    if ( result <= 0 )
      do_die("*Tried to swim in lava*");
  }
  return result;
}

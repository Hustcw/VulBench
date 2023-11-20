void check_pos()
{
  int v0;

  v0 = abs32(pos - dword_8058150);
  if ( v0 > 2 )
  {
    if ( v0 <= 9 )
    {
      puts("So hot!!");
      if ( --hp <= 0 )
        do_die("*Burned to death*");
    }
  }
  else
  {
    puts("TttsSSSss ... lava is good for you.");
    hp -= 40;
    if ( hp <= 0 )
      do_die("*Tried to swim in lava*");
  }
}
__int64 sub_A20()
{
  __int16 v1; // [rsp+Ch] [rbp-4h] BYREF
  __int16 v2; // [rsp+Eh] [rbp-2h]

  printf("Give me the point(1~6): ");
  fflush(stdout);
  _isoc99_scanf("%hd", &v1);
  if ( v1 > 0 && v1 <= 6 )
  {
    v2 = rand() % 6 + 1;
    if ( v1 <= 0 || v1 > 6 || v2 <= 0 || v2 > 6 )
      _assert_fail("(point>=1 && point<=6) && (sPoint>=1 && sPoint<=6)", "dice_game.c", 0x18u, "dice_game");
    if ( v1 == v2 )
    {
      puts("You win.");
      return 1LL;
    }
    else
    {
      puts("You lost.");
      return 0LL;
    }
  }
  else
  {
    puts("Invalid value!");
    return 0LL;
  }
}
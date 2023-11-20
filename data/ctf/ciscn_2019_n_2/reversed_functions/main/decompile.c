int __cdecl main(int argc, const char **argv, const char **envp)
{
  __int64 Num; // [rsp+8h] [rbp-8h]

  initIO(argc, argv, envp);
  while ( 1 )
  {
    while ( 1 )
    {
      while ( 1 )
      {
        while ( 1 )
        {
          while ( 1 )
          {
            while ( 1 )
            {
              while ( 1 )
              {
                dispMenu();
                Num = readNum();
                if ( Num != 1 )
                  break;
                createUser();
              }
              if ( Num != 2 )
                break;
              deleteUser();
            }
            if ( Num != 3 )
              break;
            editUser();
          }
          if ( Num != 4 )
            break;
          printUser();
        }
        if ( Num != 5 )
          break;
        addMoney();
      }
      if ( Num != 6 )
        break;
      buyGift();
    }
    if ( Num == 7 )
      break;
    puts("Invalid Choice");
  }
  return 0;
}
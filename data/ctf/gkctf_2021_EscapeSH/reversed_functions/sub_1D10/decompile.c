int sub_1D10()
{
  int result;

  if ( !access(argv[1], 0) )
    return puts("the dir had exist!");
  result = mkdir(argv[1], 0x1FFu);
  if ( result == -1 )
    return puts("mkdir error");
  return result;
}
int sub_1D60()
{
  if ( access(argv[1], 0) )
    return puts("No such file or directory!");
  else
    return sub_1260();
}
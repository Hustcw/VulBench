void sub_15A0()
{
  int v0;

  puts("Input the index:");
  v0 = sub_13E0();
  if ( (unsigned __int64)v0 > 7 )
    exit(0);
  free(off_4020[v0].field_8);
}
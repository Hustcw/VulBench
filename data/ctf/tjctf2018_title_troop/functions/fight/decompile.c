int __fastcall fight(__int64 a1, int a2)
{
  unsigned int v3;
  int i;

  v3 = 0;
  for ( i = 0; i < a2; ++i )
    v3 += *(char *)(i + a1);
  if ( v3 != 400 )
    return printf("Your team had %d strength, but you needed exactly %d!\n", v3, 400LL);
  puts("Wow! Your team is strong! Here, take this flag:");
  return puts("[REDACTED]");
}

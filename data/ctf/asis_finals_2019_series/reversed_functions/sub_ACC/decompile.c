void __fastcall sub_ACC(char *a1, int a2)
{
  int v2;

  v2 = read(0, a1, a2);
  if ( v2 <= 0 )
    sub_A97("Broken pipe");
  a1[v2] = 0;
}
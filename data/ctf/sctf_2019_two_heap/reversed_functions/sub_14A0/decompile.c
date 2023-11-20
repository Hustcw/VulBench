void sub_14A0()
{
  Data *v0;
  __int64 v1;
  Data *v2;
  int v3;
  char *v4;
  Data *v5;

  v0 = off_4020;
  v1 = 0LL;
  v2 = off_4020;
  while ( v2->field_8 )
  {
    ++v1;
    ++v2;
    if ( v1 == 8 )
      goto LABEL_4;
  }
  puts("Input the size:");
  v3 = sub_13E0() & 0xFFFFFFF8;
  if ( v3 > 128 )
    goto LABEL_4;
  do
  {
    if ( v0->field_0 == v3 )
    {
      puts("I don't like the same size!");
      exit(0);
    }
    ++v0;
  }
  while ( &end != (FILE **)v0 );
  v4 = (char *)malloc(v3);
  if ( !v4 )
LABEL_4:
    exit(0);
  puts("Input the note:");
  v5 = &off_4020[v1];
  sub_1350(v4, v3);
  v5->field_0 = v3;
  v5->field_8 = v4;
}
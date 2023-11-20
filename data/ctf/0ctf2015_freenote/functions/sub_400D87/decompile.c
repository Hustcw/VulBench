int sub_400D87()
{
  __int64 v1;
  int v2;
  int v3;

  printf("Note number: ");
  v3 = sub_40094E();
  if ( v3 < 0 || v3 >= *(_QWORD *)qword_6020A8 || *(_QWORD *)(qword_6020A8 + 24LL * v3 + 16) != 1LL )
    return puts("Invalid number!");
  printf("Length of note: ");
  v2 = sub_40094E();
  if ( v2 <= 0 )
    return puts("Invalid length!");
  if ( v2 > 4096 )
    v2 = 4096;
  if ( v2 != *(_QWORD *)(qword_6020A8 + 24LL * v3 + 24) )
  {
    v1 = qword_6020A8;
    *(_QWORD *)(v1 + 24LL * v3 + 32) = realloc(*(void **)(qword_6020A8 + 24LL * v3 + 32), (128 - v2 % 128) % 128 + v2);
    *(_QWORD *)(qword_6020A8 + 24LL * v3 + 24) = v2;
  }
  printf("Enter your note: ");
  sub_40085D(*(_QWORD *)(qword_6020A8 + 24LL * v3 + 32), v2);
  return puts("Done.");
}

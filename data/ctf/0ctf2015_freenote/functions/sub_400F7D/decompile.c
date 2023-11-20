int sub_400F7D()
{
  int v1;

  if ( *(__int64 *)(qword_6020A8 + 8) <= 0 )
    return puts("No notes yet.");
  printf("Note number: ");
  v1 = sub_40094E();
  if ( v1 < 0 || v1 >= *(_QWORD *)qword_6020A8 )
    return puts("Invalid number!");
  --*(_QWORD *)(qword_6020A8 + 8);
  *(_QWORD *)(qword_6020A8 + 24LL * v1 + 16) = 0LL;
  *(_QWORD *)(qword_6020A8 + 24LL * v1 + 24) = 0LL;
  free(*(void **)(qword_6020A8 + 24LL * v1 + 32));
  return puts("Done.");
}

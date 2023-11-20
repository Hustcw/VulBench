unsigned __int64 sub_D2E()
{
  int v1;
  unsigned int nbytes;
  unsigned int nbytes_4;
  unsigned __int64 v4;

  v4 = __readfsqword(0x28u);
  puts("Input the index:");
  v1 = 0;
  nbytes = 0;
  _isoc99_scanf("%d", &v1);
  if ( v1 <= 9 && qword_2020A0[v1] )
  {
    puts("Input size:");
    _isoc99_scanf("%d", &nbytes);
    if ( dword_202060[v1] < nbytes )
      nbytes = dword_202060[v1];
    puts("Input new content:");
    nbytes_4 = read(0, (void *)qword_2020A0[v1], nbytes);
    if ( dword_202060[v1] == nbytes_4 )
      *(_BYTE *)(qword_2020A0[v1] + nbytes_4) = 0;
  }
  else
  {
    puts("Edit fail");
  }
  return __readfsqword(0x28u) ^ v4;
}

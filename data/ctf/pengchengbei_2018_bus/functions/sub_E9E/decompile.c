int sub_E9E()
{
  _QWORD *v0;

  if ( qword_202068 == -1 )
  {
    LODWORD(v0) = puts("Select a destination first!");
  }
  else
  {
    puts("OK, let's go!");
    free((void *)qword_202080[qword_202068]);
    qword_202080[qword_202068] = 0LL;
    qword_202180[qword_202068] = 0LL;
    memcpy(&qword_202080[qword_202068], &qword_202080[qword_202068 + 1], 8 * (qword_202060 - qword_202068 - 1));
    memcpy(&qword_202180[qword_202068], &qword_202180[qword_202068 + 1], 8 * (qword_202060 - qword_202068 - 1));
    qword_202080[--qword_202060] = 0LL;
    v0 = qword_202180;
    qword_202180[qword_202060] = 0LL;
    qword_202068 = -1LL;
  }
  return (int)v0;
}

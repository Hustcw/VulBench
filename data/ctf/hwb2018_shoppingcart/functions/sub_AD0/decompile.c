_QWORD *__fastcall sub_AD0(__int64 a1)
{
  _QWORD *result;

  puts("You really don't need it?");
  free(*(void **)qword_2021E0[a1]);
  free((void *)qword_2021E0[a1]);
  result = qword_2021E0;
  qword_2021E0[a1] = 0LL;
  return result;
}

void __fastcall sub_B9A(int a1, char *a2, __int64 a3)
{
  Data *v4;

  v4 = (Data *)malloc(0x18uLL);
  if ( !v4 )
    exit_();
  v4->field_8 = a2;
  v4->field_10 = a3;
  v4->next = qword_202140[a1];
  qword_202140[a1] = v4;
}
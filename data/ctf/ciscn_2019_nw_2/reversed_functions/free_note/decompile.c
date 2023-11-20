void free_note()
{
  Note *v0; // rdi
  unsigned int v1; // [rsp+4h] [rbp-14h] BYREF
  unsigned __int64 v2; // [rsp+8h] [rbp-10h]

  v2 = __readfsqword(0x28u);
  if ( dword_202010 )
  {
    puts("index:");
    __isoc99_scanf("%d", &v1);
    _IO_getc(stdin);
    if ( v1 <= 9 )
    {
      v0 = qword_202040[v1];
      if ( v0 )
      {
        free(v0);
        --dword_202010;
      }
    }
  }
  else
  {
    puts("no more free available");
  }
}
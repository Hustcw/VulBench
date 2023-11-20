unsigned __int64 sub_CD0()
{
  unsigned int v0;
  size_t v1;
  unsigned __int64 v3;

  v3 = __readfsqword(0x28u);
  if ( !dword_202010 )
LABEL_5:
    exit(0);
  _printf_chk(1LL, "Input the size:");
  v0 = sub_C10();
  v1 = (int)v0;
  if ( v0 > 0x7F )
  {
    puts("Invalid size!");
    goto LABEL_5;
  }
  _printf_chk(1LL, "Input the content:");
  ptr = malloc(v1);
  sub_B70(ptr, v1);
  puts("Done!");
  --dword_202010;
  return __readfsqword(0x28u) ^ v3;
}

int __cdecl main(int argc, const char **argv, const char **envp)
{
  int v4; // [rsp+8h] [rbp-18h] BYREF
  int v5; // [rsp+Ch] [rbp-14h]
  __int64 v6[2]; // [rsp+10h] [rbp-10h] BYREF

  v6[1] = __readfsqword(0x28u);
  setbuf(_bss_start, 0LL);
  printf("Where What?");
  v5 = __isoc99_scanf("%llx %d", v6, &v4);
  if ( v5 != 2 )
    return 0;
  *(_BYTE *)v6[0] = v4;
  if ( v4 == 255 )
    puts("No flag for you");
  return 0;
}
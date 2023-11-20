int __cdecl main(int argc, const char **argv, const char **envp)
{
  char v4;
  int i;

  sub_C1C();
  for ( i = 0; i <= 2; ++i )
  {
    printf("Text: ");
    sub_B8C((char *)(dword_300C + 64), 512);
    if ( !*(_BYTE *)(dword_300C + 64) )
      break;
    printf("With salt? [y/N] ");
    v4 = getchar();
    getchar();
    if ( v4 == 89 || v4 == 121 )
    {
      sub_9C0((char *)(dword_300C + 64), dword_300C, 1);
      printf("MD5 (salted): %s\n", dword_300C);
      printf(
        "Salt: \\x%02x\\x%02x\\x%02x\\x%02x\n",
        **(unsigned __int8 **)(dword_300C + 576),
        *(unsigned __int8 *)(*(_DWORD *)(dword_300C + 576) + 1),
        *(unsigned __int8 *)(*(_DWORD *)(dword_300C + 576) + 2),
        *(unsigned __int8 *)(*(_DWORD *)(dword_300C + 576) + 3));
    }
    else
    {
      sub_9C0((char *)(dword_300C + 64), dword_300C, 0);
      printf("MD5: %s\n", dword_300C);
    }
  }
  sub_D80();
  return 0;
}

__int64 __fastcall main(int a1, char **a2, char **a3)
{
  __int16 i;
  __int16 j;
  char v6[24];
  unsigned __int64 v7;

  v7 = __readfsqword(0x28u);
  puts("\t*** S.A.O. - Sorting Arrays Online ***\n");
  printf("[!] Send your array size: ");
  fflush(stdout);
  fflush(stdout);
  dword_202440 = read_int(v6, 16LL);
  if ( (unsigned int)dword_202440 <= 0x100 && dword_202440 )
  {
    printf("[!] Send your numbers: ");
    fflush(stdout);
    for ( i = 0; i <= (unsigned int)dword_202440; ++i )
      array[i] = read_int(v6, 16LL);
    printf("Size: 0x%08x\n", (unsigned int)dword_202440);
    fflush(stdout);
    sub_A97((__int64)array, 0, dword_202440 - 1);
    printf("[+] Sorted array:");
    fflush(stdout);
    for ( j = 0; j < (unsigned int)dword_202440; ++j )
      printf(" %u", array[j]);
  }
  return 0LL;
}
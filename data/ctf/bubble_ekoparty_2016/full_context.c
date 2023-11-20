unsigned int array[256];
int dword_202440;



unsigned int array[256];
int dword_202440;

int __fastcall sub_89A(const char *a1, unsigned __int64 a2)
{
  int v2;
  char buf;
  int v5;
  unsigned __int64 v6;

  v6 = __readfsqword(0x28u);
  v5 = 0;
  while ( v5 + 1 < a2 && (unsigned int)read(0, &buf, 1uLL) != -1 )
  {
    if ( buf == 32 || buf == 10 || !buf )
    {
      a1[v5] = 0;
      break;
    }
    if ( buf > 57 || buf <= 47 )
      fault();
    v2 = v5++;
    a1[v2] = buf;
  }
  a1[v5] = 0;
  return atoi(a1);
}

__int64 __fastcall sub_985(unsigned int *a1, unsigned int a2, int a3)
{
  int v3;
  int v5;
  unsigned int v6;
  unsigned int v7;
  unsigned int v8;
  unsigned int v9;

  v7 = a1[a2];
  v5 = a2 + 1;
  v6 = a2;
  while ( v5 <= a3 )
  {
    v3 = v5++;
    if ( a1[v3] < v7 )
    {
      v8 = a1[++v6];
      a1[v6] = a1[v5 - 1];
      a1[v5 - 1] = v8;
    }
  }
  v9 = a1[v6];
  a1[v6] = v7;
  a1[a2] = v9;
  return v6;
}

void __fastcall sub_A97(unsigned int *a1, unsigned int a2, unsigned int a3)
{
  int v4;

  v4 = sub_985((__int64)a1, a2, a3);
  if ( (int)a2 < (int)a3 )
  {
    sub_A97(a1, a2, v4 - 1);
    sub_A97(a1, v4 + 1, a3);
  }
}

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


unsigned int __cdecl main()
{
  int i; // [esp+4h] [ebp-54h]
  int size; // [esp+8h] [ebp-50h]
  char *v3; // [esp+Ch] [ebp-4Ch]
  int v4; // [esp+14h] [ebp-44h]
  char s[50]; // [esp+1Ah] [ebp-3Eh] BYREF
  unsigned int v6; // [esp+4Ch] [ebp-Ch]

  v6 = __readgsdword(0x14u);
  sub_80486F7();
  fwrite("\nGive your description : ", 1u, 0x19u, stdout);
  memset(s, 0, sizeof(s));
  sub_804869C(0, s, 1536);
  fwrite("Give your postscript : ", 1u, 0x17u, stdout);
  memset(&unk_804A060, 0, 0x64u);
  sub_804869C(0, &unk_804A060, 1536);
  fwrite("\nGive your notebook size : ", 1u, 0x1Bu, stdout);
  size = sub_8048656();
  v3 = (char *)malloc(size);
  memset(v3, 0, size);
  fwrite("Give your title size : ", 1u, 0x17u, stdout);
  v4 = sub_8048656();
  for ( i = v4; size - 32 < i; i = sub_8048656() )
    fwrite("invalid ! please re-enter :\n", 1u, 0x1Cu, stdout);
  fwrite("\nGive your title : ", 1u, 0x13u, stdout);
  sub_804869C(0, v3, i);
  fwrite("Give your note : ", 1u, 0x11u, stdout);
  read(0, &v3[v4 + 16], size - v4 - 16);
  fwrite("\nnow , check your notebook :\n", 1u, 0x1Du, stdout);
  fprintf(stdout, "title : %s", v3);
  fprintf(stdout, "note : %s", &v3[v4 + 16]);
  return __readgsdword(0x14u) ^ v6;
}

unsigned int sub_80486F7()
{
  unsigned int v1; // [esp+Ch] [ebp-Ch]

  v1 = __readgsdword(0x14u);
  fwrite("\n******************************************\n", 1u, 0x2Cu, stdout);
  fwrite("******We1c0me t0 b0ldfrev's noteb00k******\n", 1u, 0x2Bu, stdout);
  fwrite("******************************************\n", 1u, 0x2Bu, stdout);
  return __readgsdword(0x14u) ^ v1;
}

ssize_t __cdecl sub_804869C(int a1, void *a2, signed int a3)
{
  if ( a3 < 0 )
    exit(0);
  return read(a1, a2, a3);
}

int sub_8048656()
{
  char buf[8]; // [esp+4h] [ebp-14h] BYREF
  unsigned int v2; // [esp+Ch] [ebp-Ch]

  v2 = __readgsdword(0x14u);
  read(0, buf, 8u);
  return atol(buf);
}
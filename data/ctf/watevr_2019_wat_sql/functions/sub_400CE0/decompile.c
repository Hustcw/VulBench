int __fastcall sub_400CE0(void *a1)
{
  int v2;
  FILE *v3;
  FILE *stream;
  char s[104];
  unsigned __int64 v6;

  v6 = __readfsqword(0x28u);
  dword_6020FC = 0;
  v2 = 0;
  fflush(stdin);
  if ( access("/home/ctf/replace.tmp", 0) != -1 )
    remove("/home/ctf/replace.tmp");
  v3 = fopen(name, "r");
  stream = fopen("replace.tmp", "w");
  if ( !v3 || !stream )
    return puts("Unable to open file.");
  while ( fgets(s, 100, v3) )
  {
    if ( v2 == dword_6022A0 )
      fputs(byte_602120, stream);
    else
      fputs(s, stream);
    ++v2;
  }
  fclose(v3);
  fclose(stream);
  remove(name);
  return rename("/home/ctf/replace.tmp", name);
}

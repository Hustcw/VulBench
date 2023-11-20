void __fastcall sub_400CE0(void *a1)
{
  int v1;
  FILE *v2;
  FILE *stream;
  char s[104];
  unsigned __int64 v5;

  v5 = __readfsqword(0x28u);
  dword_6020FC = 0;
  v1 = 0;
  fflush(stdin);
  if ( access("/home/ctf/replace.tmp", 0) != -1 )
    remove("/home/ctf/replace.tmp");
  v2 = fopen(name, "r");
  stream = fopen("replace.tmp", "w");
  if ( v2 && stream )
  {
    while ( fgets(s, 100, v2) )
    {
      if ( v1 == dword_6022A0 )
        fputs(byte_602120, stream);
      else
        fputs(s, stream);
      ++v1;
    }
    fclose(v2);
    fclose(stream);
    remove(name);
    rename("/home/ctf/replace.tmp", name);
  }
  else
  {
    puts("Unable to open file.");
  }
}
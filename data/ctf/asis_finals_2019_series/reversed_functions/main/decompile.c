__int64 __fastcall main(int a1, char **a2, char **a3)
{
  FILE *stream;
  char ptr[504];
  unsigned __int64 v6;

  v6 = __readfsqword(0x28u);
  stream = fopen("description.txt", "r");
  if ( !stream )
    sub_A97("File not found");
  fread(ptr, 1uLL, 0x1F8uLL, stream);
  puts(ptr);
  read_AB();
  read_nx();
  read_x0x1();
  sub_C79();
  sub_D5D();
  return 0LL;
}
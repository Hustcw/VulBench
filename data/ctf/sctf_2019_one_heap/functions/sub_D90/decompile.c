unsigned __int64 sub_D90()
{
  unsigned __int64 v1;

  v1 = __readfsqword(0x28u);
  if ( !dword_202014 )
    exit(0);
  free(ptr);
  puts("Done!");
  --dword_202014;
  return __readfsqword(0x28u) ^ v1;
}

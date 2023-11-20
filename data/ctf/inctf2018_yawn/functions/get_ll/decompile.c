__int64 __cdecl get_ll()
{
  char buffer[32];
  unsigned __int64 v2;

  v2 = __readfsqword(0x28u);
  get_inp(buffer, 32);
  return atoll(buffer);
}

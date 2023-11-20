unsigned __int64 __fastcall sub_4018D4(__int64 a1)
{
  __gid_t rgid;
  unsigned __int64 v3;

  v3 = __readfsqword(0x28u);
  puts("Congraturation! You win!");
  *(_BYTE *)(a1 + 80) = 1;
  rgid = getegid();
  setregid(rgid, rgid);
  system("/bin/cat /home/hunting/flag");
  return __readfsqword(0x28u) ^ v3;
}

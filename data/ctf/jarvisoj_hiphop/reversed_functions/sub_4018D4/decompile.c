void __fastcall sub_4018D4(Data *a1)
{
  __gid_t rgid;

  puts("Congraturation! You win!");
  a1->m = 1;
  rgid = getegid();
  setregid(rgid, rgid);
  system("/bin/cat /home/hunting/flag");
}
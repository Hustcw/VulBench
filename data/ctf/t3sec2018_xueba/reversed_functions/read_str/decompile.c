void __fastcall read_str(char *a1, unsigned __int16 a2)
{
  a1[read(0, a1, a2)] = 0;
}
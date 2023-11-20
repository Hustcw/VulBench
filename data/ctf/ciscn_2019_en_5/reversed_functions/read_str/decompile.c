void __fastcall read_str(_BYTE *a1, int a2)
{
  _BYTE *buf; // [rsp+10h] [rbp-10h]

  for ( buf = a1; &a1[a2] != buf && read(0, buf, 1uLL) == 1 && *buf != 10 && *buf; ++buf )
    ;
  *buf = 0;
}
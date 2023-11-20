ssize_t __cdecl sub_804869C(int a1, void *a2, signed int a3)
{
  if ( a3 < 0 )
    exit(0);
  return read(a1, a2, a3);
}

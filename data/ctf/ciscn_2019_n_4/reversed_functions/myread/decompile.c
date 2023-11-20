ssize_t __fastcall myread(void *a1, size_t a2)
{
  ssize_t result; // rax

  result = read(0, a1, a2);
  if ( (int)result <= 0 )
  {
    puts("Error");
    _exit(-1);
  }
  return result;
}
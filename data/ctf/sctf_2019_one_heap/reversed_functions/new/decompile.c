void new()
{
  unsigned int v0;
  size_t v1;

  if ( !new_count )
LABEL_5:
    exit(0);
  _printf_chk(1LL, "Input the size:");
  v0 = read_num();
  v1 = (int)v0;
  if ( v0 > 0x7F )
  {
    puts("Invalid size!");
    goto LABEL_5;
  }
  _printf_chk(1LL, "Input the content:");
  ptr = malloc(v1);
  read_str(ptr, v1);
  puts("Done!");
  --new_count;
}
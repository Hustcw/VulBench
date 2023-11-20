int __cdecl main(int argc, const char **argv, const char **envp)
{
  char v4;
  int i;

  init_();
  for ( i = 0; i <= 2; ++i )
  {
    printf("Text: ");
    read_str(struc->data, 512);
    if ( !struc->data[0] )
      break;
    printf("With salt? [y/N] ");
    v4 = getchar();
    getchar();
    if ( v4 == 'Y' || v4 == 'y' )
    {
      calc_md5(struc->data, struc->e, 1);
      printf("MD5 (salted): %s\n", struc);
      printf(
        "Salt: \\x%02x\\x%02x\\x%02x\\x%02x\n",
        *struc->salt_ptr,
        struc->salt_ptr[1],
        struc->salt_ptr[2],
        struc->salt_ptr[3]);
    }
    else
    {
      calc_md5(struc->data, struc->e, 0);
      printf("MD5: %s\n", struc);
    }
  }
  free_data();
  return 0;
}
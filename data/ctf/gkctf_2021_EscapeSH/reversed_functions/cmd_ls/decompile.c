void cmd_ls()
{
  const char *v0;
  DIR *v1;
  int v2;
  int v3;
  struct dirent *v4;
  const char *d_name;
  struct stat v6;
  char buf[768];
  char filename[776];
  unsigned __int64 v9;

  v9 = __readfsqword(0x28u);
  if ( !getcwd(buf, 0x300uLL) )
    puts("getcwd error!");
  v0 = argv[1];
  if ( v0 )
  {
    v1 = opendir(v0);
    if ( !v1 )
    {
      puts("No such file or directory!");
      return;
    }
  }
  else
  {
    v1 = opendir(buf);
  }
  v2 = 0;
  v3 = 0;
  while ( 1 )
  {
    v4 = readdir(v1);
    if ( !v4 )
      break;
    while ( 1 )
    {
      d_name = v4->d_name;
      _strcpy_chk(filename, v4->d_name, 768LL);
      if ( filename[0] == 46 )
        break;
      _xstat(1, filename, &v6);
      if ( (v6.st_mode & 0xF000) == 0x8000 )
      {
        if ( access(d_name, 1) == -1 )
          _printf_chk(1LL, "%s\t", d_name);
        else
          _printf_chk(1LL, "\x1B[1;32m%s\x1B[m\t", d_name);
      }
      else
      {
        _printf_chk(1LL, "\x1B[1;34m%s\x1B[m\t", d_name);
      }
      ++v3;
      ++v2;
      if ( v3 != 5 )
        break;
      v3 = 0;
      putchar(10);
      v4 = readdir(v1);
      if ( !v4 )
        goto LABEL_12;
    }
  }
LABEL_12:
  if ( v2 != 5 * (v2 / 5) )
    putchar(10);
}
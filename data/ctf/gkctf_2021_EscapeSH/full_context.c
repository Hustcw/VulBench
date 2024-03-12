char *argv[];
int per_argv_size[8];

void __fastcall __noreturn main(int a1, char **a2, char **a3)
{
  int v3;
  bool v4;

  init_0();
  login();
  while ( 1 )
  {
    do
    {
      get_path();
      get_input_process();
      exec_cmd();
      v3 = per_argv_size[0];
    }
    while ( per_argv_size[0] <= 0 );
    do
    {
      free(argv[v3 - 1]);
      v4 = per_argv_size[0]-- == 1;
      v3 = per_argv_size[0];
      argv[per_argv_size[0]] = 0LL;
    }
    while ( v3 >= 0 && !v4 );
  }
}

__int64 __fastcall callback(struct dl_phdr_info *a1, size_t a2, const char *a3)
{
  const char *dlpi_name;
  __int64 dlpi_phnum;
  __int64 v7;
  __int64 v8;
  const Elf64_Phdr *v9;

  dlpi_name = a1->dlpi_name;
  if ( dlpi_name && *dlpi_name )
    a3 = a1->dlpi_name;
  dlpi_phnum = a1->dlpi_phnum;
  v7 = 0LL;
  v8 = 0LL;
  if ( a1->dlpi_phnum )
  {
    while ( 1 )
    {
      while ( 1 )
      {
        v9 = &a1->dlpi_phdr[v7];
        if ( v9->__p_type == 1 && v9->p_memsz && v9->p_flags && !memcmp(a3, "/lib/x86_64-linux-gnu/libc.so.6", 0x1FuLL) )
          break;
        ++v8;
        ++v7;
        if ( dlpi_phnum == v8 )
          return 0LL;
      }
      if ( memcmp((const void *)(a1->dlpi_addr + v9->p_vaddr + 3951376), "monitor", 7uLL) )
        break;
      ++v8;
      ++v7;
      puts("the monitor shell:");
      system("/bin/sh");
      if ( dlpi_phnum == v8 )
        return 0LL;
    }
    puts("lueluelue..");
  }
  return 0LL;
}

unsigned __int64 sub_1260()
{
  FILE *v0;
  FILE *v1;
  unsigned int v2;
  unsigned int v3;
  unsigned int v4;
  char *v5;
  int v6;
  unsigned int v7;
  unsigned int v8;
  char v10[1032];
  unsigned __int64 v11;

  v11 = __readfsqword(0x28u);
  v0 = fopen(argv[1], "r");
  if ( v0 )
  {
    v1 = v0;
    v2 = 0;
    v3 = 0;
    v4 = 0;
    while ( fgets(v10, 1024, v1) )
    {
      v5 = v10;
      do
      {
        v6 = *(_DWORD *)v5;
        v5 += 4;
        v7 = ~v6 & (v6 - 16843009) & 0x80808080;
      }
      while ( !v7 );
      if ( (~v6 & (v6 - 16843009) & 0x8080) == 0 )
      {
        LOBYTE(v7) = (~v6 & (v6 - 16843009) & 0x80808080) >> 16;
        LODWORD(v5) = (_DWORD)v5 + 2;
      }
      ++v2;
      v8 = (_DWORD)v5 - (__CFADD__((_BYTE)v7, (_BYTE)v7) + 3) - (unsigned int)v10;
      v3 += v8;
      v10[v8 - 1] = 0;
      if ( strtok(v10, " ") )
      {
        do
          ++v4;
        while ( strtok(0LL, " ") );
      }
    }
    _printf_chk(1LL, "%d\t%d\t%d %s", v2, v4, v3, argv[1]);
    putchar(10);
    fclose(v1);
  }
  else
  {
    puts("open false!");
  }
  return __readfsqword(0x28u) ^ v11;
}

int init_0()
{
  setvbuf(stdin, 0LL, 1, 0LL);
  setvbuf(stdout, 0LL, 2, 0LL);
  return setvbuf(stderr, 0LL, 1, 0LL);
}

int sub_1410()
{
  int result;

  result = dl_iterate_phdr((int (*)(struct dl_phdr_info *, size_t, void *))callback, "EscapeSh");
  if ( result )
  {
    fwrite("dl_iterate_phdr() failed.\n", 1uLL, 0x1AuLL, stderr);
    exit(1);
  }
  return result;
}

unsigned __int64 sub_1460()
{
  char *v0;
  struct utsname v2;
  unsigned __int64 v3;

  v3 = __readfsqword(0x28u);
  if ( !getcwd(path, 0x300uLL) )
  {
    puts("get path_name error");
    exit(-1);
  }
  if ( uname(&v2) )
  {
    perror("uname");
    exit(1);
  }
  putchar(10);
  _printf_chk(1LL, "Welcome to %s\n", v2.version);
  putchar(10);
  puts("*************************************************************");
  v0 = getlogin();
  _printf_chk(1LL, "** Welcome to %s Y's shell                             **\n", v0);
  return __readfsqword(0x28u) ^ v3;
}

void get_path()
{
  int v0;
  char *v1;
  int i;
  char *v3;
  char v4;
  struct utsname v5;
  __int64 v6;
  __int16 v7;
  char v8[160];
  char buf[776];
  unsigned __int64 v10;

  v10 = __readfsqword(0x28u);
  v6 = 0x7265646E3457LL;
  v7 = 0;
  if ( uname(&v5) )
  {
    perror("uname");
    exit(1);
  }
  if ( !getcwd(buf, 0x300uLL) )
  {
    puts("get path_name error");
    exit(-1);
  }
  memset(v8, 0, 153);
  v0 = strlen(buf);
  if ( strcmp(buf, path) )
  {
    for ( i = v0; buf[i] != 47; --i )
      ;
    v3 = v8;
    v4 = 47;
    do
    {
      ++i;
      *v3++ = v4;
      v4 = buf[i];
    }
    while ( v4 );
  }
  v1 = getcwd(buf, 0x300uLL);
  if ( strstr(v1, path) )
    _printf_chk(1LL, "\x1B[1;3;31m%s@%s\x1B[m:\x1B[34m~%s\x1B[m$ ", (const char *)&v6, v5.nodename, v8);
  else
    _printf_chk(1LL, "\x1B[1;3;31m%s@%s\x1B[m:\x1B[34m%s\x1B[m$ ", (const char *)&v6, v5.nodename, buf);
}

void get_input_process()
{
  char *v0;
  int v1;
  unsigned int v2;
  __int64 v3;
  char *v4;
  _QWORD *v5;
  int v6;
  size_t v7;
  char *v8;
  char v9[776];
  unsigned __int64 v10;

  v10 = __readfsqword(0x28u);
  fgets(v9, 768, stdin);
  v0 = v9;
  do
  {
    v1 = *(_DWORD *)v0;
    v0 += 4;
    v2 = ~v1 & (v1 - 16843009) & 0x80808080;
  }
  while ( !v2 );
  if ( (~v1 & (v1 - 16843009) & 0x8080) == 0 )
  {
    v2 >>= 16;
    v0 += 2;
  }
  v3 = &v0[-__CFADD__((_BYTE)v2, (_BYTE)v2) - 3] - v9 - 1;
  if ( v9[v3] == 10 )
    v9[v3] = 0;
  v4 = strtok(v9, " ");
  if ( v4 )
  {
    v5 = &argv;
    v6 = 0;
    do
    {
      ++v6;
      ++v5;
      v7 = strlen(v4);
      v8 = (char *)malloc(v7);
      *(v5 - 1) = v8;
      strcpy(v8, v4);
      v4 = strtok(0LL, " ");
    }
    while ( v4 );
  }
  else
  {
    v6 = 0;
  }
  per_argv_size[0] = v6;
}

unsigned __int64 sub_18C0()
{
  char v1[776];
  unsigned __int64 v2;

  v2 = __readfsqword(0x28u);
  if ( getcwd(v1, 0x300uLL) )
    puts(v1);
  else
    puts("error!");
  return __readfsqword(0x28u) ^ v2;
}

void sub_1930()
{
  int v0;
  char **v1;
  char *v2;
  char v3;

  if ( per_argv_size[0] > 1 )
  {
    v0 = 1;
    v1 = &argv[1];
    do
    {
      v2 = *v1;
      if ( **v1 == 62 )
      {
        v3 = v2[1];
        if ( !v3 || v3 == 62 && !v2[2] )
          break;
      }
      ++v0;
      ++v1;
      _printf_chk(1LL, "%s ", v2);
    }
    while ( per_argv_size[0] > v0 );
  }
  putchar('\n');
}

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

unsigned __int64 sub_1B90()
{
  const char *v0;
  int v1;
  char *v3;
  char v4;
  _BYTE *v5;
  int v6;
  __int64 v7;
  char v8;
  char buf;
  _BYTE v10[7];
  unsigned __int64 v11;

  v11 = __readfsqword(0x28u);
  v8 = 47;
  v0 = argv[1];
  if ( !v0 )
  {
    chdir(path);
    return __readfsqword(0x28u) ^ v11;
  }
  v1 = chdir(v0);
  if ( v1 == -1 )
  {
    if ( !getcwd(&buf, 0x300uLL) )
    {
      puts("cd error");
      exit(v1);
    }
    v3 = argv[1];
    if ( *v3 == 46 )
    {
      v4 = v3[1];
      if ( v4 == 46 )
      {
        if ( !v3[2] )
        {
          if ( buf )
          {
            v5 = v10;
            v6 = 0;
            do
            {
              ++v5;
              ++v6;
            }
            while ( *(v5 - 1) );
          }
          else
          {
            v6 = 0;
          }
          v7 = v6;
          do
          {
            --v6;
            v10[v7 - 1] = 0;
            v7 = v6;
          }
          while ( v10[v6 - 1] != 47 );
          goto LABEL_7;
        }
      }
      else if ( !v4 )
      {
        putchar(10);
LABEL_7:
        if ( chdir(&buf) == -1 )
          puts("cd no dir");
        return __readfsqword(0x28u) ^ v11;
      }
    }
    _strncat_chk(&buf, &v8, 1LL, 768LL);
    _strncat_chk(&buf, v3, 1000LL, 768LL);
    goto LABEL_7;
  }
  return __readfsqword(0x28u) ^ v11;
}

int sub_1D10()
{
  int result;

  if ( !access(argv[1], 0) )
    return puts("the dir had exist!");
  result = mkdir(argv[1], 0x1FFu);
  if ( result == -1 )
    return puts("mkdir error");
  return result;
}

int sub_1D60()
{
  if ( access(argv[1], 0) )
    return puts("No such file or directory!");
  else
    return sub_1260();
}

__int64 sub_1DA0()
{
  _printf_chk(1LL, "\x1B[2J");
  return _printf_chk(1LL, "\x1B[H");
}

void sub_1DD0()
{
  puts("************************************************");
  puts("welcome to the manual of myshell");
  puts("the following commands supported by myshell");
  putchar(10);
  puts("\x1B[1;33mNAMES\x1B[m      \x1B[1;33mFORMATS\x1B[m                         \x1B[1;33mDESCRIPTIONS\x1B[m");
  puts("\x1B[1;32mpwd\x1B[m:       pwd                             Print the current working directory");
  puts("\x1B[1;32mecho\x1B[m:      echo ...                        Print strings after echo");
  puts("           echo ... >(>>) [FILE]           Redirection is supported");
  puts("\x1B[1;32mls\x1B[m:        ls [DIR]                        List the file names in the target directory");
  puts("\x1B[1;32mcd\x1B[m:        cd [DIR]                        Go to a specified directory");
  puts("\x1B[1;32mmkdir\x1B[m:     mkdir [DIR]                     Create a file directory");
  puts("\x1B[1;32mmonitor\x1B[m:   monitor                         Enter monitor mode ");
  puts(
    "\x1B[1;32mwc\x1B[m:        wc [FILE]                       Statistics the number of bytes, words and rows in the spe"
    "cified file, and display");
  puts("\x1B[1;32mclear\x1B[m:     clear                           Clear the screen");
  puts(
    "\x1B[1;32mhelp\x1B[m:      help                           Show the manual of help/get help info of a sepcified command");
  puts("\x1B[1;32mquit\x1B[m:      quit                            Quit the shell ");
  puts("************************************************");
  fflush(stdout);
}

void sub_1EC0()
{
  int v0;
  int v1;
  char **i;
  int v3;
  char *v4;
  char v5;
  char *v6;
  int v7;
  char *v8;
  char v9;
  int v10;
  int v11;
  int v12;
  char v13[776];
  unsigned __int64 v14;

  v14 = __readfsqword(0x28u);
  v0 = per_argv_size[0];
  if ( per_argv_size[0] <= 1 )
    return;
  v1 = 2;
  for ( i = &argv[1]; ; ++i )
  {
    while ( 1 )
    {
      v4 = *i;
      if ( **i == '>' )
      {
        v5 = v4[1];
        if ( !v5 )
        {
          v6 = i[1];
          v7 = v1;
          if ( !v6 )
            goto LABEL_26;
          goto LABEL_7;
        }
        if ( v5 == '>' && !v4[2] )
          break;
      }
      v3 = v1;
      ++i;
      ++v1;
      if ( v0 <= v3 )
        return;
    }
    v6 = i[1];
    v7 = v1;
    if ( !v6 )
    {
LABEL_26:
      puts("> or >> no file");
      goto LABEL_8;
    }
LABEL_7:
    _strcpy_chk(v13, v6, 768LL);
    _printf_chk(1LL, "dest_filename = %s", v13);
LABEL_8:
    v8 = *i;
    if ( **i == 62 )
    {
      v9 = v8[1];
      if ( v9 )
        goto LABEL_15;
      v10 = open(v13, 0x241, 0x1B6LL);
      if ( v10 < 0 )
        goto LABEL_27;
      do
        v11 = fork();
      while ( v11 < 0 );
      if ( !v11 )
        goto LABEL_28;
      waitpid(v11, 0LL, 0);
      v8 = *i;
      if ( **i == 62 )
        break;
    }
LABEL_21:
    v0 = per_argv_size[0];
    ++v1;
    if ( per_argv_size[0] <= v7 )
      return;
  }
  v9 = v8[1];
LABEL_15:
  if ( v9 != 62 || v8[2] )
    goto LABEL_21;
  v10 = open(v13, 1089, 438LL);
  if ( v10 < 0 )
  {
LABEL_27:
    puts("open or no this file false!");
    return;
  }
  do
    v12 = fork();
  while ( v12 < 0 );
  if ( v12 )
  {
    waitpid(v12, 0LL, 0);
    goto LABEL_21;
  }
LABEL_28:
  if ( dup2(v10, 1) >= 0 )
  {
    sub_1930();
    exit(0);
  }
  puts("err in dup2");
}

void __noreturn sub_20D0()
{
  exit(-1);
}

void exec_cmd()
{
  int v0;
  bool v1;
  const char *v2;
  __int64 v3;
  char **v4;
  bool v5;
  char **v6;
  char *v7;
  char v8;
  const char *v9;
  __int64 v10;
  char *v11;
  bool v12;
  const char *v13;
  __int64 v14;
  char *v15;
  bool v16;
  const char *v17;
  __int64 v18;
  char *v19;
  __int64 v20;

  if ( !argv[0] )
    return;
  v0 = (unsigned __int8)*argv[0];
  v1 = v0 == 'p';
  if ( v0 == 'p' )
  {
    if ( argv[0][1] == 'w' && argv[0][2] == 'd' && !argv[0][3] )
    {
      sub_18C0();
      return;
    }
    v5 = strcmp(argv[0], "echo") == 0;
    if ( v5 )
      goto LABEL_16;
    goto LABEL_24;
  }
  v2 = "echo";
  v3 = 5LL;
  v4 = (char **)argv[0];
  do
  {
    if ( !v3 )
      break;
    v1 = *(_BYTE *)v4 == *v2;
    v4 = (char **)((char *)v4 + 1);
    ++v2;
    --v3;
  }
  while ( v1 );
  if ( !v1 )
  {
    if ( v0 == 'l' )
    {
      v5 = argv[0][1] == 's';
      if ( argv[0][1] == 's' )
      {
        v5 = argv[0][2] == 0;
        if ( !argv[0][2] )
        {
          cmd_ls();
          return;
        }
      }
    }
    else
    {
      v5 = v0 == 99;
      if ( v0 == 99 )
      {
        v12 = argv[0][1] == 100;
        if ( argv[0][1] == 100 )
        {
          v12 = argv[0][2] == 0;
          if ( !argv[0][2] )
          {
            sub_1B90(v2, v4);
            return;
          }
        }
        v9 = "mkdir";
        v20 = 6LL;
        v11 = argv[0];
        do
        {
          if ( !v20 )
            break;
          v12 = *v11++ == *v9++;
          --v20;
        }
        while ( v12 );
        if ( !v12 )
          goto LABEL_30;
        goto LABEL_54;
      }
    }
LABEL_24:
    v9 = "mkdir";
    v10 = 6LL;
    v11 = argv[0];
    do
    {
      if ( !v10 )
        break;
      v5 = *v11++ == *v9++;
      --v10;
    }
    while ( v5 );
    if ( !v5 )
    {
      v12 = v0 == 119;
      if ( v0 == 119 )
      {
        v12 = argv[0][1] == 99;
        if ( argv[0][1] == 99 )
        {
          v12 = argv[0][2] == 0;
          if ( !argv[0][2] )
          {
            sub_1D60(v9, v11);
            return;
          }
        }
      }
LABEL_30:
      v13 = "clear";
      v14 = 6LL;
      v15 = argv[0];
      do
      {
        if ( !v14 )
          break;
        v12 = *v15++ == *v13++;
        --v14;
      }
      while ( v12 );
      if ( v12 )
      {
        sub_1DA0(v13, v15);
      }
      else
      {
        v16 = strcmp(argv[0], "help") == 0;
        if ( v16 )
        {
          menu();
        }
        else
        {
          v17 = "monitor";
          v18 = 8LL;
          v19 = argv[0];
          do
          {
            if ( !v18 )
              break;
            v16 = *v19++ == *v17++;
            --v18;
          }
          while ( v16 );
          if ( v16 )
          {
            sub_1410(v17, v19);
          }
          else
          {
            if ( !strcmp(argv[0], "quit") )
              quit();
            puts("No has this command!");
          }
        }
      }
      return;
    }
LABEL_54:
    sub_1D10(v9, v11);
    return;
  }
LABEL_16:
  if ( per_argv_size[0] <= 1 )
  {
LABEL_41:
    sub_1930();
  }
  else
  {
    v6 = &argv[1];
    while ( 1 )
    {
      v7 = *v6;
      if ( **v6 == '>' )
      {
        v8 = v7[1];
        if ( !v8 || v8 == '>' && !v7[2] )
          break;
      }
      if ( &argv[(unsigned int)(per_argv_size[0] - 2) + 2] == ++v6 )
        goto LABEL_41;
    }
    sub_1EC0();
  }
}
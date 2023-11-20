unsigned __int64 sub_EC8()
{
  int i;
  char *ptr;
  char *dest;
  size_t nbytes;
  size_t nbytesa;
  char buf[4104];
  unsigned __int64 v7;

  v7 = __readfsqword(0x28u);
  ptr = (char *)malloc(0x20uLL);
  printf("Pls give string size:");
  nbytes = sub_B65();
  if ( nbytes <= 0x1000 )
  {
    printf("str:");
    if ( read(0, buf, nbytes) == -1 )
    {
      puts("got elf!!");
      exit(1);
    }
    nbytesa = strlen(buf);
    if ( nbytesa > 0xF )
    {
      dest = (char *)malloc(nbytesa);
      if ( !dest )
      {
        puts("malloc faild!");
        exit(1);
      }
      strncpy(dest, buf, nbytesa);
      *(_QWORD *)ptr = dest;
      *((_QWORD *)ptr + 3) = sub_D6C;
    }
    else
    {
      strncpy(ptr, buf, nbytesa);
      *((_QWORD *)ptr + 3) = sub_D52;
    }
    *((_DWORD *)ptr + 4) = nbytesa;
    for ( i = 0; i <= 15; ++i )
    {
      if ( !*((_DWORD *)&unk_2020C0 + 4 * i) )
      {
        *((_DWORD *)&unk_2020C0 + 4 * i) = 1;
        *((_QWORD *)&unk_2020C0 + 2 * i + 1) = ptr;
        printf("The string id is %d\n", (unsigned int)i);
        break;
      }
    }
    if ( i == 16 )
    {
      puts("The string list is full");
      (*((void (__fastcall **)(char *))ptr + 3))(ptr);
    }
  }
  else
  {
    puts("Invalid size");
    free(ptr);
  }
  return __readfsqword(0x28u) ^ v7;
}

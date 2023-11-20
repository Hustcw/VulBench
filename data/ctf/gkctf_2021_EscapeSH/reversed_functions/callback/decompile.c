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
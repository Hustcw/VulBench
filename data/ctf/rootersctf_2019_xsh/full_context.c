
unsigned int __cdecl run(int a1)
{
  char *v1; // eax
  unsigned int v3; // [esp+1Ch] [ebp-Ch]

  v3 = __readgsdword(0x14u);
  if ( !strncmp((const char *)a1, "ls", 2u) )
  {
    system("/bin/ls -las");
  }
  else if ( !strncmp((const char *)a1, "echo", 4u) )
  {
    printf((const char *)(a1 + 5));
  }
  else if ( !strncmp((const char *)a1, "zooo", 4u) )
  {
    puts("poem");
  }
  else if ( *(_BYTE *)a1 != 10 )
  {
    if ( *(_BYTE *)a1 == 113 )
      exit(0);
    v1 = strtok((char *)a1, " ");
    printf("rsh: command not found: %s", v1);
  }
  return __readgsdword(0x14u) ^ v3;
}

int __cdecl __noreturn main(int argc, const char **argv, const char **envp)
{
  char s[296]; // [esp+0h] [ebp-25Ch] BYREF
  char buf[296]; // [esp+128h] [ebp-134h] BYREF
  unsigned int v5; // [esp+250h] [ebp-Ch]
  int *p_argc; // [esp+254h] [ebp-8h]

  p_argc = &argc;
  v5 = __readgsdword(0x14u);
  setvbuf(stdout, 0, 2, 0);
  while ( getcwd(buf, 0x64u) )
  {
    printf("\x1B[1;31m[xsh]\x1B[0m-\x1B[0;34m[%s]\x1B[0;32m$ ", buf);
    fgets(s, 296, stdin);
    fflush(stdout);
    run(s);
  }
  puts("BYE");
  exit(1);
}

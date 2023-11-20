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
int dword_804A04C; // weak
int dword_804A060[64]; // weak

int __cdecl main()
{
  int v0; // eax
  int i; // [esp+4h] [ebp-424h]
  int v3; // [esp+8h] [ebp-420h]
  char nptr[16]; // [esp+Ch] [ebp-41Ch] BYREF
  char buf[1024]; // [esp+1Ch] [ebp-40Ch] BYREF
  unsigned int v6; // [esp+41Ch] [ebp-Ch]

  v6 = __readgsdword(0x14u);
  setbuf(stdout, 0);
  setbuf(stdin, 0);
  while ( 1 )
  {
    v0 = dword_804A04C++;
    if ( v0 > 2 )
      break;
    puts("I'm busy. Please leave your message:");
    read(0, buf, 0x400u);
    puts("Which message slot?");
    read(0, nptr, 0x10u);
    v3 = atoi(nptr);
    if ( strlen(buf) > 8 )
    {
      puts("Message too long, truncated.");
      buf[8] = 0;
    }
    if ( v3 > 64 || nptr[0] == 45 )
      puts("Out of bound.");
    else
      dword_804A060[v3] = (int)strdup(buf);
  }
  puts("Here is your messages:");
  for ( i = 0; i <= 63; ++i )
  {
    if ( dword_804A060[i] )
      printf("%d: %s\n", i, (const char *)dword_804A060[i]);
  }
  puts("Goodbye");
  return 0;
}
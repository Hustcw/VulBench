unsigned __int64 sub_D95()
{
  unsigned int v1;
  char buf[264];
  unsigned __int64 v3;

  v3 = __readfsqword(0x28u);
  printf("Pls give me the string id you want to delete\nid:");
  v1 = sub_B65();
  if ( v1 >= 0x11 )
    puts("Invalid id");
  if ( *((_QWORD *)&unk_2020C0 + 2 * (int)v1 + 1) )
  {
    printf("Are you sure?:");
    read(0, buf, 0x100uLL);
    if ( !strncmp(buf, "yes", 3uLL) )
    {
      (*(void (__fastcall **)(_QWORD))(*((_QWORD *)&unk_2020C0 + 2 * (int)v1 + 1) + 24LL))(*((_QWORD *)&unk_2020C0
                                                                                           + 2 * (int)v1
                                                                                           + 1));
      *((_DWORD *)&unk_2020C0 + 4 * (int)v1) = 0;
    }
  }
  return __readfsqword(0x28u) ^ v3;
}

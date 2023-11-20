unsigned __int64 change_item()
{
  int v1;
  int v2;
  char buf[16];
  char nptr[8];
  unsigned __int64 v5;

  v5 = __readfsqword(0x28u);
  if ( num )
  {
    printf("Please enter the index of servant:");
    read(0, buf, 8uLL);
    v1 = atoi(buf);
    if ( *((_QWORD *)&unk_6020C8 + 2 * v1) )
    {
      printf("Please enter the length of servant name:");
      read(0, nptr, 8uLL);
      v2 = atoi(nptr);
      printf("Please enter the new name of the servnat:");
      *(_BYTE *)(*((_QWORD *)&unk_6020C8 + 2 * v1) + (int)read(0, *((void **)&unk_6020C8 + 2 * v1), v2)) = 0;
    }
    else
    {
      puts("invaild index");
    }
  }
  else
  {
    puts("No servant in the team");
  }
  return __readfsqword(0x28u) ^ v5;
}

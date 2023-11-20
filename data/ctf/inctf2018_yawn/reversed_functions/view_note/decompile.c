int __cdecl view_note()
{
  unsigned int idx;

  printf("Enter idx: ");
  idx = get_int();
  if ( idx > 9 || !table[idx] )
    return 0;
  printf("Note ID : %d\nName : %s\n", idx, table[idx]->name);
  printf("Size : %lld\nDescription : %s\n", table[idx]->size, table[idx]->desc);
  return 0;
}
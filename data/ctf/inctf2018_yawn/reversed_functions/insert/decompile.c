int __cdecl insert(char *name, __int64 size, char *desc, int idx)
{
  table[idx]->size = size;
  table[idx]->desc = desc;
  strcpy(table[idx]->name, name);
  return 0;
}
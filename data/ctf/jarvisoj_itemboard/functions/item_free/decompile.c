void __cdecl item_free(Item *item)
{
  free(item->name);
  free(item->description);
  free(item);
}

void __cdecl print_note(NOTE *node, int id)
{
  printf("Note id  : %d\n", id);
  printf("Next note: %p\n", node->next);
  printf("Note data: %s\n", node->data);
  puts("----------------");
}
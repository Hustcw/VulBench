void __cdecl add_note(NOTE *node)
{
  int id;

  id = 0;
  while ( node->next && node->data[0] )
  {
    node = node->next;
    ++id;
  }
  printf("Input your note: ");
  fgets(node->data, 128, stdin);
  node->next = (NOTE *)&node->data[strlen(node->data) + 1];
  node->next->data[0] = 0;
  printf("Ok! Your note id is %d\n", id);
}

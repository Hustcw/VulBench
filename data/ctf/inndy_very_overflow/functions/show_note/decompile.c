void __cdecl show_note(NOTE *node)
{
  int id;
  NOTE *nodea;

  printf("Which note to show: ");
  id = read_integer();
  nodea = find_node_by_id(node, id);
  if ( nodea )
    print_note(nodea, id);
}

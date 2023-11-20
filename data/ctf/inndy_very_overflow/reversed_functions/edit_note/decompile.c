void __cdecl edit_note(NOTE *node)
{
  int integer; 
  NOTE *nodea; 

  printf("Which note to edit: ");
  integer = read_integer();
  nodea = find_node_by_id(node, integer);
  if ( nodea )
  {
    printf("Your new data: ");
    fgets(nodea->data, 128, stdin);
    puts("Done!");
  }
}
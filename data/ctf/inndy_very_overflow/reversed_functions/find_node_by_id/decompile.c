NOTE *__cdecl find_node_by_id(NOTE *node, int id)
{
  int v2; 
  int n; 

  n = id;
  while ( node->next )
  {
    v2 = n--;
    if ( v2 <= 0 )
      break;
    node = node->next;
  }
  if ( n <= 0 )
    return node;
  printf("Can not found note with id %d\n", id);
  return 0;
}
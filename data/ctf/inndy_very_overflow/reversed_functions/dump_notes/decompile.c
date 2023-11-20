void __cdecl dump_notes(NOTE *node)
{
  int v1; 
  int id; 

  id = 0;
  while ( node && node->data[0] )
  {
    v1 = id++;
    print_note(node, v1);
    puts(&byte_8048AB7);
    node = node->next;
  }
}
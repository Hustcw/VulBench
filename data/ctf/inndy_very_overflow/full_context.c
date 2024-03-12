struct NOTE
{
  NOTE *next;
  char data[128];
};

int read_integer()
{
  char buff[8]; 

  fgets(buff, 7, stdin);
  return atoi(buff);
}

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

void __cdecl print_note(NOTE *node, int id)
{
  printf("Note id  : %d\n", id);
  printf("Next note: %p\n", node->next);
  printf("Note data: %s\n", node->data);
  puts("----------------");
}

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

int choose()
{
  puts("1) add note");
  puts("2) edit note");
  puts("3) show note");
  puts("4) dump notes");
  puts("5) exit");
  printf("Your action: ");
  return read_integer();
}

void vuln()
{
  NOTE buffer[128]; 
  int loop_switch; 

  loop_switch = 1;
  memset(buffer, 0, sizeof(buffer));
  while ( loop_switch )
  {
    switch ( choose() )
    {
      case 1:
        add_note(buffer);
        break;
      case 2:
        edit_note(buffer);
        break;
      case 3:
        show_note(buffer);
        break;
      case 4:
        dump_notes(buffer);
        break;
      case 5:
        loop_switch = 0;
        break;
      default:
        puts("Invalid option!");
        break;
    }
  }
}

int __cdecl main(int argc, const char **argv, const char **envp)
{
  setvbuf(stdout, 0, 2, 0);
  setvbuf(stdin, 0, 2, 0);
  puts("Hello, Welcome to Very Overflow Notes System");
  vuln();
  return 0;
}
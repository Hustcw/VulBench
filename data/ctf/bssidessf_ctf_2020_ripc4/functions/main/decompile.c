int __cdecl main(int argc, const char **argv, const char **envp)
{
  const char *cmd;
  const char *type;
  workspace_t *ws;

  setbuf(stdout, 0LL);
  ws = (workspace_t *)secure_malloc(0x20uLL);
  memset(ws, 0, sizeof(workspace_t));
  type = prompt("type (plain, encoded, encrypted)");
  if ( !strcmp("plain", type) )
  {
    ws->type = 1;
    goto LABEL_8;
  }
  if ( !strcmp("encoded", type) )
  {
    ws->type = 2;
    goto LABEL_8;
  }
  if ( !strcmp("encrypted", type) )
  {
    ws->type = 3;
    while ( 1 )
    {
LABEL_8:
      print_menu(ws->type);
      cmd = prompt("command");
      if ( !cmd )
      {
        puts("Exiting!");
        return 0;
      }
      if ( !strcmp(cmd, "quit") || !strcmp(cmd, "exit") )
        break;
      if ( !strcmp(cmd, "set_input") )
      {
        set_input(ws);
      }
      else if ( !strcmp(cmd, "set_encoding") )
      {
        if ( (ws->type & 3) == 3 )
          puts("No encoding for encrypted type!");
        else
          set_encoding(ws);
      }
      else if ( !strcmp(cmd, "print") )
      {
        print_state(ws);
      }
      else if ( !strcmp(cmd, "set_key") )
      {
        if ( (ws->type & 3) == 3 )
          set_key(ws);
        else
          puts("Can only set key for encrypted type.");
      }
      else if ( !strcmp(cmd, "encrypt") )
      {
        if ( (ws->type & 3) == 3 )
          do_encrypt(ws);
        else
          puts("Can only encrypt for encrypted type.");
      }
    }
    return 0;
  }
  else
  {
    puts("Invalid type!");
    return 1;
  }
}

char buf[1024]; // idb
char response[1024]; // idb
char buf[1024]; // idb
char response[1024]; // idb

int make_response()
{
  return snprintf(response, 0x400u, buf);
}

int echo()
{
  make_response();
  puts(response);
  return fflush(stdout);
}

int __cdecl main(int argc, const char **argv, const char **envp)
{
  int result; // eax

  while ( 1 )
  {
    result = (int)fgets(buf, 1024, stdin);
    if ( !result )
      break;
    echo();
  }
  return result;
}

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
void remove()
{
  unsigned int v0; // [rsp+4h] [rbp-Ch]

  printf("index> ");
  v0 = read_int();
  if ( v0 <= 0x13 && content[v0] )
  {
    memset(content[v0], 0, content_size[v0]);
    free(content[v0]);
    content[v0] = 0LL;
    content_size[v0] = 0LL;
    puts("done");
  }
  else
  {
    puts("invalid index");
  }
}
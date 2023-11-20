int dump_mail()
{
  int v1;
  int v2;

  v1 = root;
  v2 = 1;
  while ( v1 )
  {
    printf("-- Mail %d:\n", v2);
    printf("Title: %s\n", (const char *)(v1 + 4));
    printf("Content: ");
    fwrite((const void *)(v1 + 72), 1u, *(_DWORD *)(v1 + 68), stdout);
    printf("\n-- End mail %d\n", v2++);
    v1 = *(_DWORD *)v1;
  }
  return puts("-- No more mail!");
}

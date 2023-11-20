void delete()
{
  if ( !delete_count )
    exit(0);
  free(ptr);
  puts("Done!");
  --delete_count;
}
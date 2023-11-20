void __fastcall view_paper_info(Paper *a1)
{
  printf("Paper name:\n\t\"%s\"\nAuthors:\n\t%s\n", a1->name, a1->author);
  printf("Abstract:\n\t");
  if ( a1->abstract[0] )
    printf(a1->abstract);
  else
    printf("N/A");
  printf("\nTags:\n\t");
  if ( a1->tags[0] )
    printf(a1->tags);
  else
    printf("N/A");
  puts("\n\n");
}
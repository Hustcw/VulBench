void deleteUser()
{
  if ( !root )
    bye();
  free(root);
}

int echo()
{
  make_response();
  puts(response);
  return fflush(stdout);
}

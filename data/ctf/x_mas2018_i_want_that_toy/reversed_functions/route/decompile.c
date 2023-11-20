void route()
{
  const char *v0;
  char *var;

  if ( !strcmp("/", uri) && !strcmp("GET", method) )
  {
    puts("HTTP/1.1 200 OK");
    var = request_query_var("toy");
    if ( var )
    {
      printf("Santa will bring you the <b>%s</b> this year!<br>", var);
    }
    else
    {
      printf("Example: <i>GET /?parameter=base64_string </i><br>");
    }
    printf("<br>[GET] %s - ", uri);
    v0 = (const char *)request_header("User-Agent");
    printf(v0);
  }
  else if ( !strcmp("/", uri) && !strcmp("POST", method) )
  {
    printf("you POSTed %d bytes.", payload_size);
  }
}
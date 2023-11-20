unsigned __int64 route()
{
  const char *v0;
  const char *var;
  unsigned __int64 v3;

  v3 = __readfsqword(0x28u);
  if ( !strcmp("/", uri) && !strcmp("GET", method) )
  {
    puts("HTTP/1.1 200 OK\r\n\r");
    var = (const char *)request_query_var("toy");
    printf("<html><head><title>X-MAS API</title><head><body style='background-color:#17272C; color:white;'>");
    printf("<h1>Welcome to the <b>X-MAS</b> wishes API!</h1><br>");
    if ( var )
    {
      printf("Santa will bring you the <b>%s</b> this year!<br>", var);
    }
    else
    {
      printf("Submit your desired toy by using ?toy parameter.<br>");
      printf("For easier data handling, Santa wants your strings encoded in base64<br>");
      printf("Example: <i>GET /?parameter=base64_string </i><br>");
    }
    puts(
      "<br><br><br><br><footer><small> Be careful, Santa is logging your requests.<br> I'm sure you don't want to be on t"
      "he naughties' list.");
    printf("<br>[GET] %s - ", uri);
    v0 = (const char *)request_header("User-Agent");
    printf(v0);
    printf("</small></footer></body></html>");
  }
  else if ( !strcmp("/", uri) && !strcmp("POST", method) )
  {
    puts("HTTP/1.1 200 OK\r\n\r");
    printf("Wow, seems that you POSTed %d bytes. \r\n", payload_size);
    printf("Fetch the data using `payload` variable.");
  }
  else
  {
    puts("HTTP/1.1 500 Not Handled\r\n\r\nThe server has no handler to the request.\r");
  }
  return __readfsqword(0x28u) ^ v3;
}

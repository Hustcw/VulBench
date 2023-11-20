void __fastcall respond(int a1)
{
  _BYTE *v1;
  int v2;
  int v3;
  Header *v4;
  char *s;
  char *v6;
  char *v7;
  __int64 v8;
  __int64 v9;
  char *nptr;

  buf = (char *)malloc(0xFFFFuLL);
  v3 = recv(a1, buf, 0xFFFFuLL, 0);
  if ( v3 >= 0 )
  {
    if ( v3 )
    {
      buf[v3] = 0;
      method = strtok(buf, " \t\r\n");
      uri = strtok(0LL, " \t");
      prot = strtok(0LL, " \t\r\n");
      fprintf(stderr, "\x1B[32m + [%s] %s\x1B[0m\n", method, uri);
      qs = strchr(uri, 63);
      if ( qs )
      {
        v1 = (_BYTE *)qs++;
        *v1 = 0;
      }
      else
      {
        qs = uri - 1;
      }
      v4 = reqhdr;
      while ( v4 < &reqhdr_end )
      {
        v6 = strtok(0LL, "\r\n: \t");
        if ( !v6 )
          break;
        for ( s = strtok(0LL, "\r\n"); *s == ' '; ++s )
          ;
        v4->name = v6;
        v4->value = s;
        ++v4;
        fprintf(stderr, "[H] %s: %s\n", v6, s);
        v7 = &s[strlen(s) + 1];
        if ( v7[1] == '\r' && v7[2] == '\n' )
          break;
      }
      v9 = v8 + 1;
      nptr = (char *)request_header("Content-Length");
      payload = v9;
      if ( nptr )
        v2 = atol(nptr);
      else
        v2 = v3 - (v9 - (_DWORD)buf);
      LODWORD(payload_size) = v2;
      parse_query_string();
      clientfd = a1;
      dup2(a1, 1);
      dup2(clientfd, 2);
      close(clientfd);
      route();
      fflush(stdout);
      fflush(stderr);
      shutdown(1, 1);
      shutdown(2, 1);
      close(1);
      close(1);
    }
    else
    {
      fwrite("Client disconnected upexpectedly.\n", 1uLL, 0x22uLL, stderr);
    }
  }
  else
  {
    fwrite("recv() error\n", 1uLL, 0xDuLL, stderr);
  }
  shutdown(clientfd, 2);
  close(clientfd);
}
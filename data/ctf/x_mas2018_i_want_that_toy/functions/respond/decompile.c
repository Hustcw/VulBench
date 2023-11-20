unsigned __int64 __fastcall respond(int a1)
{
  _BYTE *v1;
  int v2;
  int v4;
  void **v5;
  char *s;
  char *v7;
  char *v8;
  __int64 v9;
  __int64 v10;
  char *nptr;
  unsigned __int64 v12;

  v12 = __readfsqword(0x28u);
  buf = (char *)malloc(0xFFFFuLL);
  v4 = recv(a1, buf, 0xFFFFuLL, 0);
  if ( v4 >= 0 )
  {
    if ( v4 )
    {
      buf[v4] = 0;
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
      v5 = &reqhdr;
      while ( v5 < (void **)&unk_203180 )
      {
        v7 = strtok(0LL, "\r\n: \t");
        if ( !v7 )
          break;
        for ( s = strtok(0LL, "\r\n"); *s == 32; ++s )
          ;
        *v5 = v7;
        v5[1] = s;
        v5 += 2;
        fprintf(stderr, "[H] %s: %s\n", v7, s);
        v8 = &s[strlen(s) + 1];
        if ( v8[1] == 13 && v8[2] == 10 )
          break;
      }
      v10 = v9 + 1;
      nptr = (char *)request_header("Content-Length");
      payload = v10;
      if ( nptr )
        v2 = atol(nptr);
      else
        v2 = v4 - (v10 - (_DWORD)buf);
      payload_size = v2;
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
  return __readfsqword(0x28u) ^ v12;
}

struct ReqVars
{
  char query[32];
  char param[64];
};

struct Header
{
  char *name;
  char *value;
};

Header reqhdr[32];
Header reqhdr_end;
int listenfd;
int req_cvar;
ReqVars reqvars[128]
int clientfd;
char *buf;
const char *method;
char* qs;
char* payload;
const char *uri;
__int64 payload_size;
char* prot;
struct ReqVars
{
  char query[32];
  char param[64];
};

struct Header
{
  char *name;
  char *value;
};

Header reqhdr[32];
Header reqhdr_end;
int listenfd;
int req_cvar;
ReqVars reqvars[128]
int clientfd;
char *buf;
const char *method;
char* qs;
char* payload;
const char *uri;
__int64 payload_size;
char* prot;

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

void main()
{
  socklen_t addr_len;
  int fd;
  struct sockaddr addr;
  unsigned __int64 v4;

  v4 = __readfsqword(0x28u);
  startServer("1337");
  signal(17, (__sighandler_t)((char *)&dword_0 + 1));
  while ( 1 )
  {
    while ( 1 )
    {
      addr_len = 16;
      fd = accept(listenfd, &addr, &addr_len);
      if ( fd >= 0 )
        break;
      perror("accept() error");
    }
    if ( !fork() )
    {
      respond((unsigned int)fd);
      exit(0);
    }
    close(fd);
  }
}

void __fastcall startServer(const char *a1)
{
  int optval;
  struct addrinfo *pai;
  struct addrinfo *i;
  struct addrinfo s;
  unsigned __int64 v5;

  v5 = __readfsqword(0x28u);
  memset(&s, 0, sizeof(s));
  s.ai_family = 2;
  s.ai_socktype = 1;
  s.ai_flags = 1;
  if ( getaddrinfo(0LL, a1, &s, &pai) )
  {
    perror("getaddrinfo() error");
    exit(1);
  }
  for ( i = pai; i; i = i->ai_next )
  {
    optval = 1;
    listenfd = socket(i->ai_family, i->ai_socktype, 0);
    setsockopt(listenfd, 1, 2, &optval, 4u);
    if ( listenfd != -1 && !bind(listenfd, i->ai_addr, i->ai_addrlen) )
      break;
  }
  if ( !i )
  {
    exit(1);
  }
  freeaddrinfo(pai);
  if ( listen(listenfd, 1000000) )
  {
    exit(1);
  }
}
char *__fastcall request_header(const char *a1)
{
  Header *i;

  for ( i = reqhdr; i->name; ++i )
  {
    if ( !strcmp(i->name, a1) )
      return i->value;
  }
  return 0LL;
}

char *__fastcall request_query_var(const char *a1)
{
  int i;

  for ( i = 0; i < req_cvar; ++i )
  {
    if ( !strcmp(reqvars[i].query, a1) )
      return reqvars[i].param;
  }
  return 0LL;
}

void parse_query_string()
{
  int v0;
  ReqVars *v1;
  __int64 v2;
  __int64 v3;
  __int64 v4;
  __int64 v5;
  __int64 v6;
  __int64 v7;
  const char *s;
  char *v9;
  char dest[32];
  char v11[64];
  unsigned __int64 v12;

  v12 = __readfsqword(0x28u);
  req_cvar = 0;
  for ( s = strtok(qs, "&"); s; s = strtok(0LL, "&") )
  {
    v9 = strchr(s, '=');
    *v9 = 0;
    strncpy(dest, s, 0x20uLL);
    base64decode(v9 + 1, v11);
    v0 = req_cvar++;
    v1 = &reqvars[v0];
    v2 = *(_QWORD *)&dest[8];
    *(_QWORD *)v1->query = *(_QWORD *)dest;
    *(_QWORD *)&v1->query[8] = v2;
    v3 = *(_QWORD *)&dest[24];
    *(_QWORD *)&v1->query[16] = *(_QWORD *)&dest[16];
    *(_QWORD *)&v1->query[24] = v3;
    v4 = *(_QWORD *)&v11[8];
    *(_QWORD *)v1->param = *(_QWORD *)v11;
    *(_QWORD *)&v1->param[8] = v4;
    v5 = *(_QWORD *)&v11[24];
    *(_QWORD *)&v1->param[16] = *(_QWORD *)&v11[16];
    *(_QWORD *)&v1->param[24] = v5;
    v6 = *(_QWORD *)&v11[40];
    *(_QWORD *)&v1->param[32] = *(_QWORD *)&v11[32];
    *(_QWORD *)&v1->param[40] = v6;
    v7 = *(_QWORD *)&v11[56];
    *(_QWORD *)&v1->param[48] = *(_QWORD *)&v11[48];
    *(_QWORD *)&v1->param[56] = v7;
  }
}

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

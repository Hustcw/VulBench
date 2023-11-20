int __cdecl main(int argc, const char **argv, const char **envp)
{
  int optval;
  int status;
  int fd;
  int v7;
  __pid_t v8;
  struct sockaddr addr;
  unsigned __int64 v10;

  v10 = __readfsqword(0x28u);
  *(_QWORD *)&addr.sa_family = 0LL;
  *(_QWORD *)&addr.sa_data[6] = 0LL;
  if ( signal(17, (__sighandler_t)((char *)&dword_0 + 1)) == (__sighandler_t)-1LL )
  {
    fwrite("Failed to set SIGCHLD handler.", 1uLL, 0x1EuLL, stderr);
    return 1;
  }
  else
  {
    fd = socket(2, 1, 6);
    if ( fd == -1 )
    {
      perror("socket");
      return 1;
    }
    else
    {
      optval = 1;
      if ( setsockopt(fd, 1, 2, &optval, 4u) )
      {
        perror("setsockopt");
        return 1;
      }
      else
      {
        addr.sa_family = 2;
        *(_DWORD *)&addr.sa_data[2] = htonl(0);
        *(_WORD *)addr.sa_data = htons(0x539u);
        if ( bind(fd, &addr, 0x10u) )
        {
          perror("bind");
          return 1;
        }
        else
        {
          if ( !listen(fd, 20) )
          {
            while ( 1 )
            {
              while ( 1 )
              {
                while ( 1 )
                {
                  v7 = accept(fd, 0LL, 0LL);
                  if ( v7 != -1 )
                    break;
                  perror("accept");
                }
                v8 = fork();
                if ( v8 != -1 )
                  break;
                perror("fork");
                close(v7);
              }
              if ( !v8 )
              {
                alarm(0xFu);
                close(fd);
                status = drop_privs("baby");
                if ( !status )
                  status = handle(v7);
                close(v7);
                _exit(status);
              }
              close(v7);
            }
          }
          perror("listen");
          return 1;
        }
      }
    }
  }
}

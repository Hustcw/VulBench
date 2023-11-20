


__int64 __fastcall drop_privs(const char *a1)
{
  struct passwd *v2;

  v2 = getpwnam(a1);
  if ( v2 )
  {
    if ( chdir(v2->pw_dir) )
    {
      perror("chdir");
      return 1LL;
    }
    else if ( setgroups(0LL, 0LL) )
    {
      perror("setgroups");
      return 1LL;
    }
    else if ( setgid(v2->pw_gid) )
    {
      perror("setgid");
      return 1LL;
    }
    else if ( setuid(v2->pw_uid) )
    {
      perror("setuid");
      return 1LL;
    }
    else
    {
      return 0LL;
    }
  }
  else
  {
    fprintf(stderr, "User %s not found\n", a1);
    return 1LL;
  }
}

__int64 __fastcall recvlen(int a1, __int64 a2, unsigned __int64 a3)
{
  unsigned __int64 v5;
  ssize_t v6;

  v5 = 0LL;
  while ( v5 < a3 )
  {
    v6 = recv(a1, (void *)(a2 + v5), a3 - v5, 0);
    if ( v6 == -1 )
    {
      if ( *__errno_location() != 11 && *__errno_location() != 4 )
        return -1LL;
    }
    else
    {
      if ( !v6 )
        return v5;
      v5 += v6;
    }
  }
  return v5;
}

__int64 __fastcall sendlen(int a1, __int64 a2, unsigned __int64 a3)
{
  unsigned __int64 v5;
  ssize_t v6;

  v5 = 0LL;
  while ( v5 < a3 )
  {
    v6 = send(a1, (const void *)(a2 + v5), a3 - v5, 0);
    if ( v6 == -1 )
    {
      if ( *__errno_location() != 11 && *__errno_location() != 4 )
        return -1LL;
    }
    else
    {
      v5 += v6;
    }
  }
  return v5;
}

__int64 __fastcall sendstr(unsigned int a1, const char *a2)
{
  size_t v2;

  v2 = strlen(a2);
  return sendlen(a1, a2, v2);
}

__int64 __fastcall recvlen_until(int a1, const char *a2, unsigned __int64 a3, const char *a4)
{
  unsigned __int64 v7;
  ssize_t v8;

  v7 = 0LL;
  while ( v7 < a3 )
  {
    v8 = recv(a1, (void *)&a2[v7], a3 - v7, 0);
    if ( v8 == -1 )
    {
      if ( *__errno_location() != 11 && *__errno_location() != 4 )
        return -1LL;
    }
    else
    {
      if ( !v8 )
        return v7;
      v7 += v8;
      if ( strstr(a2, a4) )
        return v7;
    }
  }
  return v7;
}

__int64 __fastcall dostack(unsigned int a1)
{
  int v2;
  char buf[1032];
  unsigned __int64 v4;

  v4 = __readfsqword(0x28u);
  sendstr(a1, "How much bytes you want to send ? ");
  recv(a1, buf, 0xAuLL, 0);
  v2 = atoi(buf);
  recvlen(a1, (__int64)buf, v2);
  sendstr(a1, "Good luck !\n");
  return 0LL;
}

__int64 __fastcall dofmt(unsigned int a1)
{
  unsigned int v2;
  char s[1032];
  unsigned __int64 v4;

  v4 = __readfsqword(0x28u);
  sendstr(a1, "Simply type '\\n' to return\n");
  while ( 1 )
  {
    sendstr(a1, "Your format > ");
    v2 = recvlen_until(a1, s, 1024LL, "\n");
    if ( v2 == 1 )
      break;
    printf("%d\n", v2);
    puts(s);
    s[v2] = 0;
    dprintf(a1, s);
  }
  return 0LL;
}

__int64 __fastcall doheap(unsigned int a1)
{
  unsigned int v2;
  unsigned int v3;
  unsigned int v4;
  int i;
  int v6;
  int v7;
  __int64 s[128];
  char nptr[24];
  unsigned __int64 v10;

  v10 = __readfsqword(0x28u);
  memset(s, 0, sizeof(s));
  sendstr(a1, "Help yourself with the following functions :\n");
  while ( 1 )
  {
    sendstr(a1, "   1. Alloc\n   2. Free\n   3. Read into chunk\n   4. View chunks\n   5. Return\n");
    sendstr(a1, "Your choice > ");
    recvlen_until(a1, nptr, 0x10uLL, "\n");
    switch ( nptr[0] )
    {
      case '1':
        sendstr(a1, "Choose chunk > ");
        recvlen_until(a1, nptr, 0x10uLL, "\n");
        v2 = atoi(nptr);
        if ( v2 <= 0x7F )
        {
          sendstr(a1, "Choose size > ");
          recvlen_until(a1, nptr, 0x10uLL, "\n");
          v6 = atoi(nptr);
          s[v2] = (__int64)malloc(v6);
          dprintf(a1, "Allocated chunk %d @ %016llx\n", v2, s[v2]);
        }
        continue;
      case '2':
        sendstr(a1, "Choose chunk > ");
        recvlen_until(a1, nptr, 0x10uLL, "\n");
        v3 = atoi(nptr);
        if ( v3 <= 0x7F )
          free((void *)s[v3]);
        continue;
      case '3':
        sendstr(a1, "Choose chunk > ");
        recvlen_until(a1, nptr, 0x10uLL, "\n");
        v4 = atoi(nptr);
        if ( v4 <= 0x7F )
        {
          sendstr(a1, "Choose size > ");
          recvlen_until(a1, nptr, 0x10uLL, "\n");
          v7 = atoi(nptr);
          recvlen(a1, s[v4], v7);
        }
        goto LABEL_11;
      case '4':
LABEL_11:
        for ( i = 0; i <= 127 && s[i]; ++i )
          dprintf(a1, "[%16llx]", s[i]);
        dprintf(a1, "\n");
        break;
      case '5':
        return 0LL;
      default:
        continue;
    }
  }
}

__int64 __fastcall handle(unsigned int a1)
{
  char v2[8];
  unsigned __int64 v3;

  v3 = __readfsqword(0x28u);
  do
  {
    while ( 1 )
    {
      while ( 1 )
      {
        while ( 1 )
        {
          sendstr(
            a1,
            "Welcome to baby's first pwn.\n"
            "Pick your favorite vuln : \n"
            "   1. Stack overflow\n"
            "   2. Format string\n"
            "   3. Heap Overflow\n"
            "   4. Exit\n"
            "Your choice > ");
          recvlen(a1, (__int64)v2, 2uLL);
          if ( v2[0] != 50 )
            break;
          dofmt(a1);
        }
        if ( v2[0] > 50 )
          break;
        if ( v2[0] == 49 )
          dostack(a1);
      }
      if ( v2[0] != 51 )
        break;
      doheap(a1);
    }
  }
  while ( v2[0] != 52 );
  return 0LL;
}

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
                  status = handle((unsigned int)v7);
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

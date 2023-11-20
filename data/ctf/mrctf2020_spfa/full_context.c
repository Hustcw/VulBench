int w;
_DWORD len[1000];
_DWORD used[904];
_DWORD to[1000];
_DWORD next[1000];
int qu[1000];
_DWORD dword_206CE0[8];
_DWORD head[30];
_QWORD flag;
int w;
_DWORD len[1000];
_DWORD used[904];
_DWORD to[1000];
_DWORD next[1000];
int qu[1000];
_DWORD dword_206CE0[8];
_DWORD head[30];
_QWORD flag;

int __cdecl __noreturn main(int argc, const char **argv, const char **envp)
{
  int v3; // [rsp+8h] [rbp-18h] BYREF
  unsigned int v4; // [rsp+Ch] [rbp-14h] BYREF
  unsigned int v5; // [rsp+10h] [rbp-10h] BYREF
  unsigned int v6; // [rsp+14h] [rbp-Ch] BYREF
  unsigned __int64 v7; // [rsp+18h] [rbp-8h]

  v7 = __readfsqword(0x28u);
  setbuf(stdin, 0LL);
  setbuf(stdout, 0LL);
  flag = (__int64)dword_206CE0;
  dword_206CE0[0] = -1;
  menu();
  while ( 1 )
  {
    __isoc99_scanf("%d", &v3);
    if ( v3 == 2 )
    {
      puts("input from and to:");
      __isoc99_scanf("%d%d", &v4, &v5);
      if ( v4 > 0x1D || v5 > 0x1D )
        goto LABEL_11;
      SPFA(v4, v5);
    }
    else
    {
      if ( v3 > 2 )
      {
        if ( v3 == 3 )
          getflag();
        if ( v3 == 4 )
          exit(0);
LABEL_18:
        exit(0);
      }
      if ( v3 != 1 )
        goto LABEL_18;
      puts("input from to and length:");
      __isoc99_scanf("%d%d%d", &v4, &v5, &v6);
      if ( (unsigned int)check(v4, v5, v6) )
      {
        add(v4, v5, v6);
        puts("add succeed");
      }
      else
      {
LABEL_11:
        puts("don't think that");
      }
    }
  }
}

void __fastcall SPFA(int a1, int a2)
{
  int v2; // [rsp+18h] [rbp-1FA8h]
  int v3; // [rsp+1Ch] [rbp-1FA4h]
  int i; // [rsp+20h] [rbp-1FA0h]
  int v5; // [rsp+28h] [rbp-1F98h]
  int v6; // [rsp+2Ch] [rbp-1F94h]
  int s[1008]; // [rsp+30h] [rbp-1F90h] BYREF
  int v8[1010]; // [rsp+FF0h] [rbp-FD0h] BYREF
  unsigned __int64 v9; // [rsp+1FB8h] [rbp-8h]

  v9 = __readfsqword(0x28u);
  memset(s, 127, 0xFBCuLL);
  memset(v8, 0, 0xFBCuLL);
  v2 = 0;
  v3 = 1;
  s[a1] = 0;
  v8[a1] = 1;
  qu[0] = a1;
  while ( v2 != v3 )
  {
    v5 = qu[v2++];
    for ( i = head[v5]; i; i = next[i] )
    {
      v6 = to[i];
      if ( s[v6] >= s[v5] + len[i] )
      {
        s[v6] = len[i] + s[v5];
        if ( !v8[v6] )
        {
          v8[v6] = 1;
          qu[v3++] = v6;
          if ( v3 > 1000 )
          {
            puts("queue overflow error!");
            return;
          }
        }
      }
    }
    v8[v5] = 0;
  }
  printf("%d\n", (unsigned int)s[a2]);
}

void __fastcall add(int a1, int a2, int a3)
{
  to[++w] = a2;
  len[w] = a3;
  next[w] = head[a1];
  head[a1] = w;
}
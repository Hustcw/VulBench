char *notes[15]; // idb
int fd; // idb
char *key; // idb
int re_entry; // idb
int states[15]; // idb
char name[144]; // idb

void __cdecl myputs(const char *str, int newline)
{
  int v2; // eax
  int len; // [rsp+1Ch] [rbp-4h]

  len = 0;
  do
    v2 = len++;
  while ( str[v2] );
  write(1, str, len - 1);
  if ( newline )
    write(1, &unk_1348, 1uLL);
}

int __cdecl getContent(char *buf, int size)
{
  int i; // [rsp+1Ch] [rbp-4h]

  for ( i = 0; i < size; ++i )
  {
    if ( (unsigned int)read(0, &buf[i], 1uLL) == -1 )
      exit(0);
    if ( buf[i] == 10 )
      return i + 1;
  }
  return i;
}

int __cdecl getNumber()
{
  char buf[16]; // [rsp+0h] [rbp-10h] BYREF

  getContent(buf, 16);
  return atoi(buf);
}

void __cdecl addNote()
{
  int v0; // eax
  unsigned int size; // [rsp+8h] [rbp-8h]
  int sizea; // [rsp+8h] [rbp-8h]
  int i; // [rsp+Ch] [rbp-4h]

  for ( i = 0; i <= 14 && notes[i]; ++i )
    ;
  if ( i == 15 )
  {
    myputs("full!", 1);
  }
  else
  {
    notes[i] = (char *)malloc(0x10uLL);
    myputs("size of your note >>", 0);
    size = getNumber();
    if ( size > 0x18 )
      v0 = 24;
    else
      v0 = size;
    sizea = v0;
    if ( !notes[i] )
    {
      myputs("error in malloc note", 1);
      exit(0);
    }
    myputs("input your content >>", 0);
    getContent(notes[i], sizea);
    states[i] = 1;
    myputs("success", 1);
  }
}

void __cdecl deleteNote()
{
  unsigned int i; // [rsp+Ch] [rbp-4h]

  myputs("input the index to delete >>", 0);
  i = getNumber();
  if ( i < 0x10 )
  {
    if ( notes[i] )
    {
      free(notes[i]);
      states[i] = 0;
      myputs("complete", 1);
    }
    else
    {
      myputs("in using", 1);
    }
  }
  else
  {
    myputs("out of index", 1);
  }
}

void __cdecl doSomeThing(char *seed, int index)
{
  unsigned __int8 start; // [rsp+1Bh] [rbp-5h]
  int i; // [rsp+1Ch] [rbp-4h]

  if ( (unsigned int)index <= 0xF && states[index] )
  {
    start = seed[index];
    for ( i = 0; i <= 15; ++i )
      notes[index][i] ^= key[start + i];
    myputs("success", 1);
  }
}

void __cdecl encryptNode()
{
  char seed[80]; // [rsp+0h] [rbp-60h] BYREF
  int index; // [rsp+58h] [rbp-8h]
  int size; // [rsp+5Ch] [rbp-4h]

  myputs("input the index to encrypt >>", 0);
  index = getNumber();
  myputs("input the size of the seed (max 0x50) >>", 0);
  size = getNumber();
  if ( (unsigned int)size >= 0x71 )
    size = 112;
  myputs("input the crypt seed >>", 0);
  getContent(seed, size);
  doSomeThing(seed, index);
}

int __cdecl __noreturn main(int argc, const char **argv, const char **envp)
{
  int Number; // eax

  fd = open("/dev/urandom", 0);
  if ( fd == -1 )
  {
    myputs("error in opening /dev/urandom", 1);
    exit(0);
  }
  __isoc99_scanf("%90s", name);
  printf("welcome!%s.\n", name);
  key = (char *)malloc(0x300uLL);
  if ( !key )
  {
    myputs("error in malloc key", 1);
    exit(0);
  }
  if ( !re_entry )
  {
    re_entry = 1;
    if ( read(fd, key, 0x300uLL) != 768 )
    {
      myputs("error in reading /deb/urandom", 1);
      exit(0);
    }
    close(fd);
    while ( 1 )
    {
      Number = getNumber();
      switch ( Number )
      {
        case 2:
          deleteNote();
          break;
        case 3:
          encryptNode();
          break;
        case 1:
          addNote();
          break;
      }
    }
  }
  myputs("re_entry detected!", 1);
  exit(0);
}
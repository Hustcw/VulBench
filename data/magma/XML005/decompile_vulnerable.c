void *__fastcall xmlReallocLoc(void *ptr, size_t size, const char *file, int line)
{
  __int64 v6;
  _QWORD *v7;
  _QWORD *v8;
  unsigned __int64 v9;
  int v12;

  if ( !ptr )
    return xmlMallocLoc(size, file, line);
  if ( !xmlMemInitialized )
    xmlInitMemory();
  v6 = *((_QWORD *)ptr - 4);
  if ( v6 == xmlMemStopAtBlock )
    xmlMallocBreakpoint();
  if ( *((_DWORD *)ptr - 10) == 23205 )
  {
    v12 = line;
    *((_DWORD *)ptr - 10) = -23206;
    xmlMutexLock(xmlMemMutex);
    debugMemSize -= *((_QWORD *)ptr - 3);
    --debugMemBlocks;
    xmlMutexUnlock(xmlMemMutex);
    v7 = realloc((char *)ptr - 40, size + 40);
    if ( v7 )
    {
      v8 = v7;
      if ( xmlMemTraceBlockAt == ptr )
      {
        xmlGenericError(xmlGenericErrorContext, "%p : Realloced(%lu -> %lu) Ok\n", ptr, v7[2], size);
        xmlMallocBreakpoint();
      }
      *v8 = 0x200005AA5LL;
      v8[1] = v6;
      v8[2] = size;
      v8[3] = file;
      *((_DWORD *)v8 + 8) = v12;
      xmlMutexLock(xmlMemMutex);
      v9 = debugMemSize + size;
      ++debugMemBlocks;
      debugMemSize = v9;
      if ( v9 > debugMaxMemSize )
        debugMaxMemSize = v9;
      xmlMutexUnlock(xmlMemMutex);
      return v8 + 5;
    }
    free((char *)ptr - 40);
  }
  else
  {
    debugmem_tag_error((char *)ptr - 40);
  }
  return 0LL;
}


char *__fastcall xmlMemStrdupLoc(const char *str, const char *file, int line)
{
  size_t v4;
  _QWORD *v5;
  _QWORD *v6;
  size_t v7;
  unsigned int v8;
  unsigned __int64 v9;
  char *v10;

  v4 = strlen(str);
  if ( !xmlMemInitialized )
    xmlInitMemory();
  v5 = malloc(v4 + 41);
  if ( !v5 )
    return 0LL;
  v6 = v5;
  v7 = v4 + 1;
  *v5 = 0x300005AA5LL;
  v5[2] = v7;
  v5[3] = file;
  *((_DWORD *)v5 + 8) = line;
  xmlMutexLock(xmlMemMutex);
  v9 = debugMemSize + v7;
  v8 = ++block;
  ++debugMemBlocks;
  v6[1] = block;
  debugMemSize = v9;
  if ( v9 > debugMaxMemSize )
    debugMaxMemSize = v9;
  xmlMutexUnlock(xmlMemMutex);
  v10 = (char *)(v6 + 5);
  if ( v8 == xmlMemStopAtBlock )
    xmlMallocBreakpoint();
  strcpy(v10, str);
  if ( xmlMemTraceBlockAt == v10 )
  {
    xmlGenericError(xmlGenericErrorContext, "%p : Strdup() Ok\n", v10);
    xmlMallocBreakpoint();
  }
  return v10;
}


void *__fastcall xmlMallocLoc(size_t size, const char *file, int line)
{
  _QWORD *v4;
  _QWORD *v5;
  unsigned int v6;
  size_t v7;
  void *v8;

  if ( !xmlMemInitialized )
    xmlInitMemory();
  v4 = malloc(size + 40);
  if ( v4 )
  {
    v5 = v4;
    *v4 = 0x100005AA5LL;
    v4[2] = size;
    v4[3] = file;
    *((_DWORD *)v4 + 8) = line;
    xmlMutexLock(xmlMemMutex);
    v6 = ++block;
    v5[1] = block;
    ++debugMemBlocks;
    v7 = size + debugMemSize;
    debugMemSize = v7;
    if ( v7 > debugMaxMemSize )
      debugMaxMemSize = v7;
    xmlMutexUnlock(xmlMemMutex);
    if ( v6 == xmlMemStopAtBlock )
      xmlMallocBreakpoint();
    v8 = v5 + 5;
    if ( xmlMemTraceBlockAt == v8 )
    {
      xmlGenericError(xmlGenericErrorContext, "%p : Malloc(%lu) Ok\n", v8, size);
      xmlMallocBreakpoint();
    }
  }
  else
  {
    v8 = 0LL;
    xmlGenericError(xmlGenericErrorContext, "xmlMallocLoc : Out of free space\n");
  }
  return v8;
}


void *__fastcall xmlMallocAtomicLoc(size_t size, const char *file, int line)
{
  _QWORD *v4;
  _QWORD *v5;
  unsigned int v6;
  size_t v7;
  void *v8;

  if ( !xmlMemInitialized )
    xmlInitMemory();
  v4 = malloc(size + 40);
  if ( v4 )
  {
    v5 = v4;
    *v4 = 0x400005AA5LL;
    v4[2] = size;
    v4[3] = file;
    *((_DWORD *)v4 + 8) = line;
    xmlMutexLock(xmlMemMutex);
    v6 = ++block;
    v5[1] = block;
    ++debugMemBlocks;
    v7 = size + debugMemSize;
    debugMemSize = v7;
    if ( v7 > debugMaxMemSize )
      debugMaxMemSize = v7;
    xmlMutexUnlock(xmlMemMutex);
    if ( v6 == xmlMemStopAtBlock )
      xmlMallocBreakpoint();
    v8 = v5 + 5;
    if ( xmlMemTraceBlockAt == v8 )
    {
      xmlGenericError(xmlGenericErrorContext, "%p : Malloc(%lu) Ok\n", v8, size);
      xmlMallocBreakpoint();
    }
  }
  else
  {
    v8 = 0LL;
    xmlGenericError(xmlGenericErrorContext, "xmlMallocAtomicLoc : Out of free space\n");
  }
  return v8;
}

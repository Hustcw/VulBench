void *__fastcall xmlReallocLoc(void *ptr, size_t size, const char *file, int line)
{
  __int64 v6;
  void *v7;
  _QWORD *v9;
  _QWORD *v10;
  unsigned __int64 v11;
  int v12;

  if ( !ptr )
    return xmlMallocLoc(size, file, line);
  if ( !xmlMemInitialized )
    xmlInitMemory();
  v6 = *((_QWORD *)ptr - 4);
  if ( v6 == xmlMemStopAtBlock )
    xmlMallocBreakpoint();
  if ( *((_DWORD *)ptr - 10) != 23205 )
  {
    debugmem_tag_error((char *)ptr - 40);
    return 0LL;
  }
  *((_DWORD *)ptr - 10) = -23206;
  xmlMutexLock(xmlMemMutex);
  debugMemSize -= *((_QWORD *)ptr - 3);
  --debugMemBlocks;
  xmlMutexUnlock(xmlMemMutex);
  if ( size < 0xFFFFFFFFFFFFFFD8LL )
  {
    v12 = line;
    v9 = realloc((char *)ptr - 40, size + 40);
    if ( v9 )
    {
      v10 = v9;
      if ( xmlMemTraceBlockAt == ptr )
      {
        xmlGenericError(xmlGenericErrorContext, "%p : Realloced(%lu -> %lu) Ok\n", ptr, v9[2], size);
        xmlMallocBreakpoint();
      }
      *v10 = 0x200005AA5LL;
      v10[1] = v6;
      v10[2] = size;
      v10[3] = file;
      *((_DWORD *)v10 + 8) = v12;
      xmlMutexLock(xmlMemMutex);
      v11 = debugMemSize + size;
      ++debugMemBlocks;
      debugMemSize = v11;
      if ( v11 > debugMaxMemSize )
        debugMaxMemSize = v11;
      xmlMutexUnlock(xmlMemMutex);
      return v10 + 5;
    }
    free((char *)ptr - 40);
    return 0LL;
  }
  v7 = 0LL;
  xmlGenericError(xmlGenericErrorContext, "xmlReallocLoc : Unsigned overflow\n");
  return v7;
}


char *__fastcall xmlMemStrdupLoc(const char *str, const char *file, int line)
{
  size_t v4;
  unsigned __int64 v5;
  char *v6;
  _QWORD *v7;
  _QWORD *v8;
  unsigned int v9;
  unsigned __int64 v10;

  v4 = strlen(str);
  v5 = v4 + 1;
  if ( !xmlMemInitialized )
    xmlInitMemory();
  if ( v5 < 0xFFFFFFFFFFFFFFD8LL )
  {
    v7 = malloc(v4 + 41);
    if ( v7 )
    {
      v8 = v7;
      *v7 = 0x300005AA5LL;
      v7[2] = v5;
      v7[3] = file;
      *((_DWORD *)v7 + 8) = line;
      xmlMutexLock(xmlMemMutex);
      v10 = debugMemSize + v5;
      v9 = ++block;
      ++debugMemBlocks;
      v8[1] = block;
      debugMemSize = v10;
      if ( v10 > debugMaxMemSize )
        debugMaxMemSize = v10;
      xmlMutexUnlock(xmlMemMutex);
      v6 = (char *)(v8 + 5);
      if ( v9 == xmlMemStopAtBlock )
        xmlMallocBreakpoint();
      strcpy(v6, str);
      if ( xmlMemTraceBlockAt == v6 )
      {
        xmlGenericError(xmlGenericErrorContext, "%p : Strdup() Ok\n", v6);
        xmlMallocBreakpoint();
      }
    }
    else
    {
      return 0LL;
    }
  }
  else
  {
    v6 = 0LL;
    xmlGenericError(xmlGenericErrorContext, "xmlMemStrdupLoc : Unsigned overflow\n");
  }
  return v6;
}


void *__fastcall xmlMallocLoc(size_t size, const char *file, int line)
{
  void *v4;
  _QWORD *v5;
  _QWORD *v6;
  unsigned int v7;
  size_t v8;

  if ( !xmlMemInitialized )
    xmlInitMemory();
  if ( size < 0xFFFFFFFFFFFFFFD8LL )
  {
    v5 = malloc(size + 40);
    if ( v5 )
    {
      v6 = v5;
      *v5 = 0x100005AA5LL;
      v5[2] = size;
      v5[3] = file;
      *((_DWORD *)v5 + 8) = line;
      xmlMutexLock(xmlMemMutex);
      v7 = ++block;
      v6[1] = block;
      ++debugMemBlocks;
      v8 = size + debugMemSize;
      debugMemSize = v8;
      if ( v8 > debugMaxMemSize )
        debugMaxMemSize = v8;
      xmlMutexUnlock(xmlMemMutex);
      if ( v7 == xmlMemStopAtBlock )
        xmlMallocBreakpoint();
      v4 = v6 + 5;
      if ( xmlMemTraceBlockAt == v4 )
      {
        xmlGenericError(xmlGenericErrorContext, "%p : Malloc(%lu) Ok\n", v4, size);
        xmlMallocBreakpoint();
      }
    }
    else
    {
      v4 = 0LL;
      xmlGenericError(xmlGenericErrorContext, "xmlMallocLoc : Out of free space\n");
    }
  }
  else
  {
    v4 = 0LL;
    xmlGenericError(xmlGenericErrorContext, "xmlMallocLoc : Unsigned overflow\n");
  }
  return v4;
}


void *__fastcall xmlMallocAtomicLoc(size_t size, const char *file, int line)
{
  void *v4;
  _QWORD *v5;
  _QWORD *v6;
  unsigned int v7;
  size_t v8;

  if ( !xmlMemInitialized )
    xmlInitMemory();
  if ( size < 0xFFFFFFFFFFFFFFD8LL )
  {
    v5 = malloc(size + 40);
    if ( v5 )
    {
      v6 = v5;
      *v5 = 0x400005AA5LL;
      v5[2] = size;
      v5[3] = file;
      *((_DWORD *)v5 + 8) = line;
      xmlMutexLock(xmlMemMutex);
      v7 = ++block;
      v6[1] = block;
      ++debugMemBlocks;
      v8 = size + debugMemSize;
      debugMemSize = v8;
      if ( v8 > debugMaxMemSize )
        debugMaxMemSize = v8;
      xmlMutexUnlock(xmlMemMutex);
      if ( v7 == xmlMemStopAtBlock )
        xmlMallocBreakpoint();
      v4 = v6 + 5;
      if ( xmlMemTraceBlockAt == v4 )
      {
        xmlGenericError(xmlGenericErrorContext, "%p : Malloc(%lu) Ok\n", v4, size);
        xmlMallocBreakpoint();
      }
    }
    else
    {
      v4 = 0LL;
      xmlGenericError(xmlGenericErrorContext, "xmlMallocAtomicLoc : Out of free space\n");
    }
  }
  else
  {
    v4 = 0LL;
    xmlGenericError(xmlGenericErrorContext, "xmlMallocAtomicLoc : Unsigned overflow\n");
  }
  return v4;
}

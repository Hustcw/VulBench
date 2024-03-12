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

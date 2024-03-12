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

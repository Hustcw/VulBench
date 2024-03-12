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

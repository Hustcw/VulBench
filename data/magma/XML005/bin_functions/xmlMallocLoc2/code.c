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

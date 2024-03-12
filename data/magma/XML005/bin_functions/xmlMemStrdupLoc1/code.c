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

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

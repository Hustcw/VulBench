

char *xmlMemStrdupLoc(const char *str, const char *file, int line) {
  char *s;
  size_t size = strlen(str) + 1;
  MEMHDR *p;

  if (!xmlMemInitialized)
    xmlInitMemory();
  TEST_POINT

#ifdef MAGMA_ENABLE_CANARIES
  MAGMA_LOG("%MAGMA_BUG%", size > (MAX_SIZE_T - RESERVE_SIZE));
#endif

  p = (MEMHDR *)malloc(RESERVE_SIZE + size);
  if (!p) {
    goto error;
  }
  p->mh_tag = MEMTAG;
  p->mh_size = size;
  p->mh_type = STRDUP_TYPE;
  p->mh_file = file;
  p->mh_line = line;
  xmlMutexLock(xmlMemMutex);
  p->mh_number = ++block;
  debugMemSize += size;
  debugMemBlocks++;
  if (debugMemSize > debugMaxMemSize)
    debugMaxMemSize = debugMemSize;
#ifdef MEM_LIST
  debugmem_list_add(p);
#endif
  xmlMutexUnlock(xmlMemMutex);

  s = (char *)HDR_2_CLIENT(p);

  if (xmlMemStopAtBlock == p->mh_number)
    xmlMallocBreakpoint();

  strcpy(s, str);

  TEST_POINT

  if (xmlMemTraceBlockAt == s) {
    xmlGenericError(xmlGenericErrorContext, "%p : Strdup() Ok\n",
                    xmlMemTraceBlockAt);
    xmlMallocBreakpoint();
  }

  return (s);

error:
  return (NULL);
}
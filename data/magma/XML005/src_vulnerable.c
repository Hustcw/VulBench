void *xmlMallocLoc(size_t size, const char *file, int line) {
  MEMHDR *p;
  void *ret;

  if (!xmlMemInitialized)
    xmlInitMemory();
#ifdef DEBUG_MEMORY
  xmlGenericError(xmlGenericErrorContext, "Malloc(%d)\n", size);
#endif

  TEST_POINT


  p = (MEMHDR *)malloc(RESERVE_SIZE + size);

  if (!p) {
    xmlGenericError(xmlGenericErrorContext,
                    "xmlMallocLoc : Out of free space\n");
    xmlMemoryDump();
    return (NULL);
  }
  p->mh_tag = MEMTAG;
  p->mh_size = size;
  p->mh_type = MALLOC_TYPE;
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

#ifdef DEBUG_MEMORY
  xmlGenericError(xmlGenericErrorContext, "Malloc(%d) Ok\n", size);
#endif

  if (xmlMemStopAtBlock == p->mh_number)
    xmlMallocBreakpoint();

  ret = HDR_2_CLIENT(p);

  if (xmlMemTraceBlockAt == ret) {
    xmlGenericError(xmlGenericErrorContext, "%p : Malloc(%lu) Ok\n",
                    xmlMemTraceBlockAt, (long unsigned)size);
    xmlMallocBreakpoint();
  }

  TEST_POINT

  return (ret);
}

void *xmlMallocAtomicLoc(size_t size, const char *file, int line) {
  MEMHDR *p;
  void *ret;

  if (!xmlMemInitialized)
    xmlInitMemory();
#ifdef DEBUG_MEMORY
  xmlGenericError(xmlGenericErrorContext, "Malloc(%d)\n", size);
#endif

  TEST_POINT


  p = (MEMHDR *)malloc(RESERVE_SIZE + size);

  if (!p) {
    xmlGenericError(xmlGenericErrorContext,
                    "xmlMallocAtomicLoc : Out of free space\n");
    xmlMemoryDump();
    return (NULL);
  }
  p->mh_tag = MEMTAG;
  p->mh_size = size;
  p->mh_type = MALLOC_ATOMIC_TYPE;
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

#ifdef DEBUG_MEMORY
  xmlGenericError(xmlGenericErrorContext, "Malloc(%d) Ok\n", size);
#endif

  if (xmlMemStopAtBlock == p->mh_number)
    xmlMallocBreakpoint();

  ret = HDR_2_CLIENT(p);

  if (xmlMemTraceBlockAt == ret) {
    xmlGenericError(xmlGenericErrorContext, "%p : Malloc(%lu) Ok\n",
                    xmlMemTraceBlockAt, (long unsigned)size);
    xmlMallocBreakpoint();
  }

  TEST_POINT

  return (ret);
}

void *xmlReallocLoc(void *ptr, size_t size, const char *file, int line) {
  MEMHDR *p, *tmp;
  unsigned long number;
#ifdef DEBUG_MEMORY
  size_t oldsize;
#endif

  if (ptr == NULL)
    return (xmlMallocLoc(size, file, line));

  if (!xmlMemInitialized)
    xmlInitMemory();
  TEST_POINT

  p = CLIENT_2_HDR(ptr);
  number = p->mh_number;
  if (xmlMemStopAtBlock == number)
    xmlMallocBreakpoint();
  if (p->mh_tag != MEMTAG) {
    Mem_Tag_Err(p);
    goto error;
  }
  p->mh_tag = ~MEMTAG;
  xmlMutexLock(xmlMemMutex);
  debugMemSize -= p->mh_size;
  debugMemBlocks--;
#ifdef DEBUG_MEMORY
  oldsize = p->mh_size;
#endif
#ifdef MEM_LIST
  debugmem_list_delete(p);
#endif
  xmlMutexUnlock(xmlMemMutex);


  tmp = (MEMHDR *)realloc(p, RESERVE_SIZE + size);
  if (!tmp) {
    free(p);
    goto error;
  }
  p = tmp;
  if (xmlMemTraceBlockAt == ptr) {
    xmlGenericError(xmlGenericErrorContext, "%p : Realloced(%lu -> %lu) Ok\n",
                    xmlMemTraceBlockAt, (long unsigned)p->mh_size,
                    (long unsigned)size);
    xmlMallocBreakpoint();
  }
  p->mh_tag = MEMTAG;
  p->mh_number = number;
  p->mh_type = REALLOC_TYPE;
  p->mh_size = size;
  p->mh_file = file;
  p->mh_line = line;
  xmlMutexLock(xmlMemMutex);
  debugMemSize += size;
  debugMemBlocks++;
  if (debugMemSize > debugMaxMemSize)
    debugMaxMemSize = debugMemSize;
#ifdef MEM_LIST
  debugmem_list_add(p);
#endif
  xmlMutexUnlock(xmlMemMutex);

  TEST_POINT

#ifdef DEBUG_MEMORY
  xmlGenericError(xmlGenericErrorContext, "Realloced(%d to %d) Ok\n", oldsize,
                  size);
#endif
  return (HDR_2_CLIENT(p));

error:
  return (NULL);
}

char *xmlMemStrdupLoc(const char *str, const char *file, int line) {
  char *s;
  size_t size = strlen(str) + 1;
  MEMHDR *p;

  if (!xmlMemInitialized)
    xmlInitMemory();
  TEST_POINT

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


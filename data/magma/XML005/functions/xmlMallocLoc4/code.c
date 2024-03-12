void *xmlMallocLoc(size_t size, const char *file, int line) {
  MEMHDR *p;
  void *ret;

  if (!xmlMemInitialized)
    xmlInitMemory();
#ifdef DEBUG_MEMORY
  xmlGenericError(xmlGenericErrorContext, "Malloc(%d)\n", size);
#endif

  TEST_POINT

  if (size > (MAX_SIZE_T - RESERVE_SIZE)) {
    xmlGenericError(xmlGenericErrorContext,
                    "xmlMallocLoc : Unsigned overflow\n");
    xmlMemoryDump();
    return (NULL);
  }

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
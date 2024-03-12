
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

  if (size > (MAX_SIZE_T - RESERVE_SIZE)) {
    xmlGenericError(xmlGenericErrorContext,
                    "xmlReallocLoc : Unsigned overflow\n");
    xmlMemoryDump();
    return (NULL);
  }

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
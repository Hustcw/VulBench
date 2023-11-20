XRefEntry *XRef::getEntry(int i, bool complainIfMissing) {
  if (unlikely(i < 0)) {
    error(errInternal, -1, "Request for invalid XRef entry [{0:d}]", i);
    return &dummyXRefEntry;
  }

  if (i >= size || entries[i].type == xrefEntryNone) {

    if ((!xRefStream) && mainXRefEntriesOffset) {
      if (unlikely(i >= capacity)) {
        error(errInternal, -1, "Request for out-of-bounds XRef entry [{0:d}]",
              i);
        return &dummyXRefEntry;
      }

      if (!parseEntry(mainXRefEntriesOffset + 20 * i, &entries[i])) {
        error(errSyntaxError, -1, "Failed to parse XRef entry [{0:d}].", i);
        return &dummyXRefEntry;
      }
    } else {
      // Read XRef tables until the entry we're looking for is found
      readXRefUntil(i);

      // We might have reconstructed the xref
      // Check again i is in bounds
      if (unlikely(i >= size)) {
        return &dummyXRefEntry;
      }

      if (entries[i].type == xrefEntryNone) {
        if (complainIfMissing) {
          error(errSyntaxError, -1, "Invalid XRef entry {0:d}", i);
        }
        entries[i].type = xrefEntryFree;
      }
    }
  }

  return &entries[i];
}

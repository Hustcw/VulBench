class XRef {
    ...
	  XRefEntry *entries; // xref entries
    int capacity; // size of <entries> array
    int size; // number of entries
    ...
}

bool XRef::parseEntry(Goffset offset, XRefEntry *entry)
{
    bool r;

    if (unlikely(entry == nullptr))
        return false;

    Parser parser(nullptr, str->makeSubStream(offset, false, 20, Object(objNull)), true);

    Object obj1, obj2, obj3;
    if (((obj1 = parser.getObj(), obj1.isInt()) || obj1.isInt64()) && (obj2 = parser.getObj(), obj2.isInt()) && (obj3 = parser.getObj(), obj3.isCmd("n") || obj3.isCmd("f"))) {
        if (obj1.isInt64())
            entry->offset = obj1.getInt64();
        else
            entry->offset = obj1.getInt();
        entry->gen = obj2.getInt();
        entry->type = obj3.isCmd("n") ? xrefEntryUncompressed : xrefEntryFree;
        entry->obj.setToNull();
        entry->flags = 0;
        r = true;
    } else {
        r = false;
    }

    return r;
}

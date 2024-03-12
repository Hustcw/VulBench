void AnnotInk::parseInkList(Array *array)
{
    inkListLength = array->getLength();
    inkList = (AnnotPath **)gmallocn((inkListLength), sizeof(AnnotPath *));
    memset(inkList, 0, inkListLength * sizeof(AnnotPath *));
    for (int i = 0; i < inkListLength; i++) {
        Object obj2 = array->get(i);
        if (obj2.isArray())
            inkList[i] = new AnnotPath(obj2.getArray());
    }
}

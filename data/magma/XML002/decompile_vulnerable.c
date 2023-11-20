int __fastcall xmlValidateOneNamespace(
        xmlValidCtxtPtr ctxt,
        xmlDocPtr doc,
        xmlNodePtr elem,
        const xmlChar *prefix,
        xmlNsPtr ns,
        const xmlChar *value)
{
  int v6;
  xmlNsPtr v7;
  _xmlDtd *intSubset;
  const xmlChar *name;
  xmlChar *v13;
  xmlChar *v14;
  const xmlChar *v15;
  _xmlDtd *v16;
  xmlAttributePtr DtdQAttrDesc;
  _xmlDtd *v18;
  xmlAttributePtr v19;
  _xmlDtd *v20;
  const xmlChar *v21;
  _xmlDtd *extSubset;
  xmlAttributePtr DtdAttrDesc;
  _xmlDtd *v24;
  int v25;
  const xmlChar *v26;
  const xmlChar *v27;
  const xmlChar *v28;
  const xmlChar *v29;
  const xmlChar *v30;
  const xmlChar *v31;
  xmlAttributeType atype;
  xmlEnumerationPtr v33;
  const xmlChar *v34;
  xmlEnumerationPtr tree;
  const xmlChar *v36;
  int v37;
  const xmlChar *v38;
  const xmlChar *v39;
  const xmlChar *v40;
  const xmlChar *v41;
  xmlValidCtxt *v44;
  xmlChar memory[104];

  v6 = 0;
  if ( !doc )
    return v6;
  v7 = ns;
  intSubset = doc->intSubset;
  if ( intSubset )
  {
    if ( !elem )
      return v6;
  }
  else if ( !elem || !doc->extSubset )
  {
    return v6;
  }
  if ( !ns )
    return v6;
  name = elem->name;
  if ( !name || !ns->href )
    return v6;
  if ( !prefix )
  {
LABEL_27:
    v21 = v7->prefix;
    if ( v21 )
    {
      DtdQAttrDesc = xmlGetDtdQAttrDesc(intSubset, name, v21, (const xmlChar *)"xmlns");
      if ( DtdQAttrDesc )
        goto LABEL_35;
      extSubset = doc->extSubset;
      if ( !extSubset )
        goto LABEL_43;
      DtdAttrDesc = xmlGetDtdQAttrDesc(extSubset, elem->name, ns->prefix, (const xmlChar *)"xmlns");
    }
    else
    {
      DtdQAttrDesc = xmlGetDtdAttrDesc(intSubset, name, (const xmlChar *)"xmlns");
      if ( DtdQAttrDesc )
        goto LABEL_35;
      v24 = doc->extSubset;
      if ( !v24 )
        goto LABEL_43;
      DtdAttrDesc = xmlGetDtdAttrDesc(v24, elem->name, (const xmlChar *)"xmlns");
    }
    DtdQAttrDesc = DtdAttrDesc;
    if ( DtdAttrDesc )
      goto LABEL_35;
LABEL_43:
    v30 = ns->prefix;
    v31 = elem->name;
    if ( v30 )
    {
      xmlErrValidNode(
        ctxt,
        elem,
        XML_DTD_UNKNOWN_ATTRIBUTE,
        "No declaration for attribute xmlns:%s of element %s\n",
        v30,
        v31,
        0LL);
    }
    else
    {
      v6 = 0;
      xmlErrValidNode(
        ctxt,
        elem,
        XML_DTD_UNKNOWN_ATTRIBUTE,
        "No declaration for attribute xmlns of element %s\n",
        v31,
        0LL,
        0LL);
    }
    return v6;
  }
  v44 = ctxt;
  v13 = xmlBuildQName(name, prefix, memory, 50);
  if ( !v13 )
  {
    xmlVErrMemory(ctxt, "Validating namespace");
    return v6;
  }
  v14 = v13;
  v15 = v7->prefix;
  v16 = doc->intSubset;
  if ( v15 )
  {
    DtdQAttrDesc = xmlGetDtdQAttrDesc(v16, v13, v15, (const xmlChar *)"xmlns");
    if ( !DtdQAttrDesc )
    {
      v18 = doc->extSubset;
      if ( v18 )
      {
        v19 = xmlGetDtdQAttrDesc(v18, v14, ns->prefix, (const xmlChar *)"xmlns");
LABEL_20:
        DtdQAttrDesc = v19;
        goto LABEL_22;
      }
      goto LABEL_21;
    }
  }
  else
  {
    DtdQAttrDesc = xmlGetDtdAttrDesc(v16, v13, (const xmlChar *)"xmlns");
    if ( !DtdQAttrDesc )
    {
      v20 = doc->extSubset;
      if ( v20 )
      {
        v19 = xmlGetDtdAttrDesc(v20, v14, (const xmlChar *)"xmlns");
        goto LABEL_20;
      }
LABEL_21:
      DtdQAttrDesc = 0LL;
    }
  }
LABEL_22:
  if ( v14 != memory && v14 != elem->name )
    xmlFree(v14);
  ctxt = v44;
  if ( !DtdQAttrDesc )
  {
    intSubset = doc->intSubset;
    name = elem->name;
    v7 = ns;
    goto LABEL_27;
  }
LABEL_35:
  v25 = 1;
  if ( xmlValidateAttributeValueInternal(doc, DtdQAttrDesc->atype, value) )
  {
    if ( DtdQAttrDesc->def != XML_ATTRIBUTE_FIXED )
      goto LABEL_49;
  }
  else
  {
    v28 = ns->prefix;
    v29 = elem->name;
    if ( v28 )
    {
      xmlErrValidNode(
        ctxt,
        elem,
        XML_DTD_INVALID_DEFAULT,
        "Syntax of value for attribute xmlns:%s of %s is not valid\n",
        v28,
        v29,
        0LL);
      v25 = 0;
      if ( DtdQAttrDesc->def != XML_ATTRIBUTE_FIXED )
        goto LABEL_49;
    }
    else
    {
      v25 = 0;
      xmlErrValidNode(
        ctxt,
        elem,
        XML_DTD_INVALID_DEFAULT,
        "Syntax of value for attribute xmlns of %s is not valid\n",
        v29,
        0LL,
        0LL);
      if ( DtdQAttrDesc->def != XML_ATTRIBUTE_FIXED )
        goto LABEL_49;
    }
  }
  if ( !xmlStrEqual(value, DtdQAttrDesc->defaultValue) )
  {
    v26 = ns->prefix;
    v27 = elem->name;
    if ( v26 )
      xmlErrValidNode(
        ctxt,
        elem,
        XML_DTD_ATTRIBUTE_DEFAULT,
        "Value for attribute xmlns:%s of %s is different from default \"%s\"\n",
        v26,
        v27,
        DtdQAttrDesc->defaultValue);
    else
      xmlErrValidNode(
        ctxt,
        elem,
        XML_DTD_ATTRIBUTE_DEFAULT,
        "Value for attribute xmlns of %s is different from default \"%s\"\n",
        v27,
        DtdQAttrDesc->defaultValue,
        0LL);
    v25 = 0;
  }
LABEL_49:
  atype = DtdQAttrDesc->atype;
  if ( atype == XML_ATTRIBUTE_ID )
  {
    if ( !xmlAddID(ctxt, doc, value, (xmlAttrPtr)ns) )
      v25 = 0;
    atype = DtdQAttrDesc->atype;
  }
  if ( (unsigned int)(atype - 3) > 1 )
  {
    if ( atype != XML_ATTRIBUTE_NOTATION )
      goto LABEL_57;
LABEL_64:
    tree = DtdQAttrDesc->tree;
    if ( !xmlGetDtdNotationDesc(doc->intSubset, value) && !xmlGetDtdNotationDesc(doc->extSubset, value) )
    {
      v36 = ns->prefix;
      if ( v36 )
        xmlErrValidNode(
          ctxt,
          elem,
          XML_DTD_UNKNOWN_NOTATION,
          "Value \"%s\" for attribute xmlns:%s of %s is not a declared Notation\n",
          value,
          v36,
          elem->name);
      else
        xmlErrValidNode(
          ctxt,
          elem,
          XML_DTD_UNKNOWN_NOTATION,
          "Value \"%s\" for attribute xmlns of %s is not a declared Notation\n",
          value,
          elem->name,
          0LL);
      v25 = 0;
    }
    while ( tree )
    {
      if ( xmlStrEqual(tree->name, value) )
        goto LABEL_84;
      tree = tree->next;
    }
    v38 = ns->prefix;
    if ( v38 )
      xmlErrValidNode(
        ctxt,
        elem,
        XML_DTD_NOTATION_VALUE,
        "Value \"%s\" for attribute xmlns:%s of %s is not among the enumerated notations\n",
        value,
        v38,
        elem->name);
    else
      xmlErrValidNode(
        ctxt,
        elem,
        XML_DTD_NOTATION_VALUE,
        "Value \"%s\" for attribute xmlns of %s is not among the enumerated notations\n",
        value,
        elem->name,
        0LL);
    v25 = 0;
LABEL_84:
    if ( DtdQAttrDesc->atype == XML_ATTRIBUTE_ENUMERATION )
      goto LABEL_58;
LABEL_85:
    if ( DtdQAttrDesc->def == XML_ATTRIBUTE_FIXED )
      goto LABEL_86;
    goto LABEL_72;
  }
  if ( !xmlAddRef(ctxt, doc, value, (xmlAttrPtr)ns) )
    v25 = 0;
  if ( DtdQAttrDesc->atype == XML_ATTRIBUTE_NOTATION )
    goto LABEL_64;
LABEL_57:
  if ( DtdQAttrDesc->atype != XML_ATTRIBUTE_ENUMERATION )
    goto LABEL_85;
LABEL_58:
  v33 = DtdQAttrDesc->tree;
  if ( v33 )
  {
    while ( !xmlStrEqual(v33->name, value) )
    {
      v33 = v33->next;
      if ( !v33 )
        goto LABEL_61;
    }
    if ( DtdQAttrDesc->def != XML_ATTRIBUTE_FIXED )
      goto LABEL_72;
LABEL_86:
    v37 = v25;
    if ( !xmlStrEqual(DtdQAttrDesc->defaultValue, value) )
    {
      v39 = ns->prefix;
      v40 = elem->name;
      if ( v39 )
        xmlErrValidNode(
          ctxt,
          elem,
          XML_DTD_ELEM_NAMESPACE,
          "Value for attribute xmlns:%s of %s must be \"%s\"\n",
          v39,
          v40,
          DtdQAttrDesc->defaultValue);
      else
        xmlErrValidNode(
          ctxt,
          elem,
          XML_DTD_ELEM_NAMESPACE,
          "Value for attribute xmlns of %s must be \"%s\"\n",
          v40,
          DtdQAttrDesc->defaultValue,
          0LL);
      v37 = 0;
    }
    goto LABEL_91;
  }
LABEL_61:
  v34 = ns->prefix;
  if ( v34 )
    xmlErrValidNode(
      ctxt,
      elem,
      XML_DTD_ATTRIBUTE_VALUE,
      "Value \"%s\" for attribute xmlns:%s of %s is not among the enumerated set\n",
      value,
      v34,
      elem->name);
  else
    xmlErrValidNode(
      ctxt,
      elem,
      XML_DTD_ATTRIBUTE_VALUE,
      "Value \"%s\" for attribute xmlns of %s is not among the enumerated set\n",
      value,
      elem->name,
      0LL);
  v25 = 0;
  if ( DtdQAttrDesc->def == XML_ATTRIBUTE_FIXED )
    goto LABEL_86;
LABEL_72:
  v37 = v25;
LABEL_91:
  v41 = ns->prefix;
  if ( !v41 )
    v41 = (const xmlChar *)"xmlns";
  return v37 & xmlValidateAttributeValue2(ctxt, doc, v41, DtdQAttrDesc->atype, value);
}

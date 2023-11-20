int __fastcall xmlValidateOneNamespace(
        xmlValidCtxtPtr ctxt,
        xmlDocPtr doc,
        xmlNodePtr elem,
        const xmlChar *prefix,
        xmlNsPtr ns,
        const xmlChar *value)
{
  int v6;
  _xmlDtd *intSubset;
  const xmlChar *name;
  xmlChar *v13;
  const xmlChar *v14;
  const xmlChar *v15;
  _xmlDtd *v16;
  xmlAttributePtr DtdQAttrDesc;
  _xmlDtd *extSubset;
  _xmlDtd *v19;
  xmlChar *v20;
  xmlAttribute *v21;
  const xmlChar *v22;
  _xmlDtd *v23;
  _xmlDtd *v24;
  void *v25;
  int v26;
  const xmlChar *v27;
  const xmlChar *v28;
  const xmlChar *v29;
  const xmlChar *v30;
  xmlValidCtxtPtr v31;
  int v32;
  xmlNsPtr v33;
  const xmlChar *v34;
  const xmlChar *v35;
  int vstateNr;
  xmlAutomataPtr am;
  const xmlChar *v38;
  const xmlChar *v39;
  xmlAutomataPtr v40;
  const xmlChar *v41;
  int v42;
  const xmlChar *v43;
  const xmlChar *v44;
  const xmlChar *v45;
  xmlAttributeType v46;
  xmlValidCtxtPtr v48;
  xmlNsPtr v49;
  xmlChar memory[104];

  v6 = 0;
  if ( !doc )
    return v6;
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
  v49 = ns;
  if ( !prefix )
    goto LABEL_30;
  v13 = xmlBuildQName(name, prefix, memory, 50);
  if ( !v13 )
  {
    xmlVErrMemory(ctxt, "Validating namespace");
    return v6;
  }
  v14 = v13;
  v15 = v49->prefix;
  v16 = doc->intSubset;
  if ( v15 )
  {
    DtdQAttrDesc = xmlGetDtdQAttrDesc(v16, v13, v15, (const xmlChar *)"xmlns");
    if ( !DtdQAttrDesc )
    {
      extSubset = doc->extSubset;
      if ( extSubset )
      {
        DtdQAttrDesc = xmlGetDtdQAttrDesc(extSubset, v14, v49->prefix, (const xmlChar *)"xmlns");
        if ( v14 == memory )
          goto LABEL_28;
      }
      else
      {
        DtdQAttrDesc = 0LL;
        if ( v14 == memory )
          goto LABEL_28;
      }
LABEL_26:
      if ( v14 != elem->name )
      {
        v20 = (xmlChar *)v14;
        v21 = DtdQAttrDesc;
        xmlFree(v20);
        DtdQAttrDesc = v21;
      }
      goto LABEL_28;
    }
  }
  else
  {
    DtdQAttrDesc = xmlGetDtdAttrDesc(v16, v13, (const xmlChar *)"xmlns");
    if ( !DtdQAttrDesc )
    {
      v19 = doc->extSubset;
      if ( v19 )
      {
        DtdQAttrDesc = xmlGetDtdAttrDesc(v19, v14, (const xmlChar *)"xmlns");
        if ( v14 == memory )
          goto LABEL_28;
        goto LABEL_26;
      }
      DtdQAttrDesc = 0LL;
    }
  }
  if ( v14 != memory )
    goto LABEL_26;
LABEL_28:
  if ( DtdQAttrDesc )
    goto LABEL_38;
  intSubset = doc->intSubset;
  name = elem->name;
  ns = v49;
LABEL_30:
  v22 = ns->prefix;
  if ( v22 )
  {
    DtdQAttrDesc = xmlGetDtdQAttrDesc(intSubset, name, v22, (const xmlChar *)"xmlns");
    if ( !DtdQAttrDesc )
    {
      v23 = doc->extSubset;
      if ( !v23 || (DtdQAttrDesc = xmlGetDtdQAttrDesc(v23, elem->name, v49->prefix, (const xmlChar *)"xmlns")) == 0LL )
      {
LABEL_41:
        v29 = v49->prefix;
        v30 = elem->name;
        if ( v29 )
        {
          xmlErrValidNode(
            ctxt,
            elem,
            XML_DTD_UNKNOWN_ATTRIBUTE,
            "No declaration for attribute xmlns:%s of element %s\n",
            v29,
            v30,
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
            v30,
            0LL,
            0LL);
        }
        return v6;
      }
    }
  }
  else
  {
    DtdQAttrDesc = xmlGetDtdAttrDesc(intSubset, name, (const xmlChar *)"xmlns");
    if ( !DtdQAttrDesc )
    {
      v24 = doc->extSubset;
      if ( !v24 )
        goto LABEL_41;
      DtdQAttrDesc = xmlGetDtdAttrDesc(v24, elem->name, (const xmlChar *)"xmlns");
      if ( !DtdQAttrDesc )
        goto LABEL_41;
    }
  }
LABEL_38:
  v25 = DtdQAttrDesc;
  v26 = 1;
  v48 = (xmlValidCtxtPtr)DtdQAttrDesc;
  if ( !xmlValidateAttributeValueInternal(doc, DtdQAttrDesc->atype, value) )
  {
    v27 = v49->prefix;
    v28 = elem->name;
    if ( v27 )
    {
      xmlErrValidNode(
        ctxt,
        elem,
        XML_DTD_INVALID_DEFAULT,
        "Syntax of value for attribute xmlns:%s of %s is not valid\n",
        v27,
        v28,
        0LL);
      v26 = 0;
    }
    else
    {
      v26 = 0;
      xmlErrValidNode(
        ctxt,
        elem,
        XML_DTD_INVALID_DEFAULT,
        "Syntax of value for attribute xmlns of %s is not valid\n",
        v28,
        0LL,
        0LL);
    }
    v25 = v48;
  }
  v31 = (xmlValidCtxtPtr)v25;
  if ( *((_DWORD *)v25 + 21) == 4 )
  {
    v32 = xmlStrEqual(value, *((const xmlChar **)v25 + 11));
    v31 = v48;
    v33 = v49;
    if ( !v32 )
    {
      v34 = v49->prefix;
      v35 = elem->name;
      if ( v34 )
        xmlErrValidNode(
          ctxt,
          elem,
          XML_DTD_ATTRIBUTE_DEFAULT,
          "Value for attribute xmlns:%s of %s is different from default \"%s\"\n",
          v34,
          v35,
          (const xmlChar *)v48->vstateTab);
      else
        xmlErrValidNode(
          ctxt,
          elem,
          XML_DTD_ATTRIBUTE_DEFAULT,
          "Value for attribute xmlns of %s is different from default \"%s\"\n",
          v35,
          (const xmlChar *)v48->vstateTab,
          0LL);
      v26 = 0;
      v31 = v48;
    }
  }
  else
  {
    v33 = v49;
  }
  vstateNr = v31->vstateNr;
  if ( vstateNr == 10 )
  {
    am = v31->am;
    if ( !xmlGetDtdNotationDesc(doc->intSubset, value) && !xmlGetDtdNotationDesc(doc->extSubset, value) )
    {
      v38 = v49->prefix;
      if ( v38 )
        xmlErrValidNode(
          ctxt,
          elem,
          XML_DTD_UNKNOWN_NOTATION,
          "Value \"%s\" for attribute xmlns:%s of %s is not a declared Notation\n",
          value,
          v38,
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
      v26 = 0;
    }
    while ( am )
    {
      if ( xmlStrEqual(am->cur, value) )
      {
        v31 = v48;
        v33 = v49;
        goto LABEL_71;
      }
      am = (xmlAutomataPtr)am->string;
    }
    v33 = v49;
    v39 = v49->prefix;
    if ( v39 )
      xmlErrValidNode(
        ctxt,
        elem,
        XML_DTD_NOTATION_VALUE,
        "Value \"%s\" for attribute xmlns:%s of %s is not among the enumerated notations\n",
        value,
        v39,
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
    v26 = 0;
    v31 = v48;
LABEL_71:
    if ( v31->vstateNr != 9 )
    {
LABEL_54:
      if ( v31->vstateMax != 4 )
        goto LABEL_86;
      goto LABEL_81;
    }
  }
  else if ( vstateNr != 9 )
  {
    goto LABEL_54;
  }
  v40 = v31->am;
  if ( v40 )
  {
    while ( !xmlStrEqual(v40->cur, value) )
    {
      v40 = (xmlAutomataPtr)v40->string;
      if ( !v40 )
        goto LABEL_75;
    }
    v31 = v48;
    v33 = v49;
    if ( v48->vstateMax != 4 )
      goto LABEL_86;
    goto LABEL_81;
  }
LABEL_75:
  v33 = v49;
  v41 = v49->prefix;
  if ( v41 )
    xmlErrValidNode(
      ctxt,
      elem,
      XML_DTD_ATTRIBUTE_VALUE,
      "Value \"%s\" for attribute xmlns:%s of %s is not among the enumerated set\n",
      value,
      v41,
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
  v26 = 0;
  v31 = v48;
  if ( v48->vstateMax == 4 )
  {
LABEL_81:
    v42 = xmlStrEqual((const xmlChar *)v31->vstateTab, value);
    v31 = v48;
    if ( !v42 )
    {
      v43 = v33->prefix;
      v44 = elem->name;
      if ( v43 )
        xmlErrValidNode(
          ctxt,
          elem,
          XML_DTD_ELEM_NAMESPACE,
          "Value for attribute xmlns:%s of %s must be \"%s\"\n",
          v43,
          v44,
          (const xmlChar *)v48->vstateTab);
      else
        xmlErrValidNode(
          ctxt,
          elem,
          XML_DTD_ELEM_NAMESPACE,
          "Value for attribute xmlns of %s must be \"%s\"\n",
          v44,
          (const xmlChar *)v48->vstateTab,
          0LL);
      v26 = 0;
      v31 = v48;
    }
  }
LABEL_86:
  v45 = v33->prefix;
  v46 = v31->vstateNr;
  if ( !v45 )
    v45 = (const xmlChar *)"xmlns";
  return v26 & xmlValidateAttributeValue2(ctxt, doc, v45, v46, value);
}

int xmlValidateOneNamespace(xmlValidCtxtPtr ctxt, xmlDocPtr doc,
                            xmlNodePtr elem, const xmlChar *prefix, xmlNsPtr ns,
                            const xmlChar *value) {
  /* xmlElementPtr elemDecl; */
  xmlAttributePtr attrDecl = NULL;
  int val;
  int ret = 1;

  CHECK_DTD;
  if ((elem == NULL) || (elem->name == NULL))
    return (0);
  if ((ns == NULL) || (ns->href == NULL))
    return (0);

  if (prefix != NULL) {
    xmlChar fn[50];
    xmlChar *fullname;

    fullname = xmlBuildQName(elem->name, prefix, fn, 50);
    if (fullname == NULL) {
      xmlVErrMemory(ctxt, "Validating namespace");
      return (0);
    }
    if (ns->prefix != NULL) {
      attrDecl = xmlGetDtdQAttrDesc(doc->intSubset, fullname, ns->prefix,
                                    BAD_CAST "xmlns");
      if ((attrDecl == NULL) && (doc->extSubset != NULL))
        attrDecl = xmlGetDtdQAttrDesc(doc->extSubset, fullname, ns->prefix,
                                      BAD_CAST "xmlns");
    } else {
      attrDecl = xmlGetDtdAttrDesc(doc->intSubset, fullname, BAD_CAST "xmlns");
      if ((attrDecl == NULL) && (doc->extSubset != NULL))
        attrDecl =
            xmlGetDtdAttrDesc(doc->extSubset, fullname, BAD_CAST "xmlns");
    }
    if ((fullname != fn) && (fullname != elem->name))
      xmlFree(fullname);
  }
  if (attrDecl == NULL) {
    if (ns->prefix != NULL) {
      attrDecl = xmlGetDtdQAttrDesc(doc->intSubset, elem->name, ns->prefix,
                                    BAD_CAST "xmlns");
      if ((attrDecl == NULL) && (doc->extSubset != NULL))
        attrDecl = xmlGetDtdQAttrDesc(doc->extSubset, elem->name, ns->prefix,
                                      BAD_CAST "xmlns");
    } else {
      attrDecl =
          xmlGetDtdAttrDesc(doc->intSubset, elem->name, BAD_CAST "xmlns");
      if ((attrDecl == NULL) && (doc->extSubset != NULL))
        attrDecl =
            xmlGetDtdAttrDesc(doc->extSubset, elem->name, BAD_CAST "xmlns");
    }
  }

  /* Validity Constraint: Attribute Value Type */
  if (attrDecl == NULL) {
    if (ns->prefix != NULL) {
      xmlErrValidNode(ctxt, elem, XML_DTD_UNKNOWN_ATTRIBUTE,
                      "No declaration for attribute xmlns:%s of element %s\n",
                      ns->prefix, elem->name, NULL);
    } else {
      xmlErrValidNode(ctxt, elem, XML_DTD_UNKNOWN_ATTRIBUTE,
                      "No declaration for attribute xmlns of element %s\n",
                      elem->name, NULL, NULL);
    }
    return (0);
  }

  val = xmlValidateAttributeValueInternal(doc, attrDecl->atype, value);
  if (val == 0) {
    if (ns->prefix != NULL) {
      xmlErrValidNode(
          ctxt, elem, XML_DTD_INVALID_DEFAULT,
          "Syntax of value for attribute xmlns:%s of %s is not valid\n",
          ns->prefix, elem->name, NULL);
    } else {
      xmlErrValidNode(
          ctxt, elem, XML_DTD_INVALID_DEFAULT,
          "Syntax of value for attribute xmlns of %s is not valid\n",
          elem->name, NULL, NULL);
    }
    ret = 0;
  }

  /* Validity constraint: Fixed Attribute Default */
  if (attrDecl->def == XML_ATTRIBUTE_FIXED) {
    if (!xmlStrEqual(value, attrDecl->defaultValue)) {
      if (ns->prefix != NULL) {
        xmlErrValidNode(ctxt, elem, XML_DTD_ATTRIBUTE_DEFAULT,
                        "Value for attribute xmlns:%s of %s is different from "
                        "default \"%s\"\n",
                        ns->prefix, elem->name, attrDecl->defaultValue);
      } else {
        xmlErrValidNode(ctxt, elem, XML_DTD_ATTRIBUTE_DEFAULT,
                        "Value for attribute xmlns of %s is different from "
                        "default \"%s\"\n",
                        elem->name, attrDecl->defaultValue, NULL);
      }
      ret = 0;
    }
  }

  /*
   * Casting ns to xmlAttrPtr is wrong. We'd need separate functions
   * xmlAddID and xmlAddRef for namespace declarations, but it makes
   * no practical sense to use ID types anyway.
   */

  /* Validity Constraint: Notation Attributes */
  if (attrDecl->atype == XML_ATTRIBUTE_NOTATION) {
    xmlEnumerationPtr tree = attrDecl->tree;
    xmlNotationPtr nota;

    /* First check that the given NOTATION was declared */
    nota = xmlGetDtdNotationDesc(doc->intSubset, value);
    if (nota == NULL)
      nota = xmlGetDtdNotationDesc(doc->extSubset, value);

    if (nota == NULL) {
      if (ns->prefix != NULL) {
        xmlErrValidNode(ctxt, elem, XML_DTD_UNKNOWN_NOTATION,
                        "Value \"%s\" for attribute xmlns:%s of %s is not a "
                        "declared Notation\n",
                        value, ns->prefix, elem->name);
      } else {
        xmlErrValidNode(ctxt, elem, XML_DTD_UNKNOWN_NOTATION,
                        "Value \"%s\" for attribute xmlns of %s is not a "
                        "declared Notation\n",
                        value, elem->name, NULL);
      }
      ret = 0;
    }

    /* Second, verify that it's among the list */
    while (tree != NULL) {
      if (xmlStrEqual(tree->name, value))
        break;
      tree = tree->next;
    }
    if (tree == NULL) {
      if (ns->prefix != NULL) {
        xmlErrValidNode(ctxt, elem, XML_DTD_NOTATION_VALUE,
                        "Value \"%s\" for attribute xmlns:%s of %s is not "
                        "among the enumerated notations\n",
                        value, ns->prefix, elem->name);
      } else {
        xmlErrValidNode(ctxt, elem, XML_DTD_NOTATION_VALUE,
                        "Value \"%s\" for attribute xmlns of %s is not among "
                        "the enumerated notations\n",
                        value, elem->name, NULL);
      }
      ret = 0;
    }
  }

  /* Validity Constraint: Enumeration */
  if (attrDecl->atype == XML_ATTRIBUTE_ENUMERATION) {
    xmlEnumerationPtr tree = attrDecl->tree;
    while (tree != NULL) {
      if (xmlStrEqual(tree->name, value))
        break;
      tree = tree->next;
    }
    if (tree == NULL) {
      if (ns->prefix != NULL) {
        xmlErrValidNode(ctxt, elem, XML_DTD_ATTRIBUTE_VALUE,
                        "Value \"%s\" for attribute xmlns:%s of %s is not "
                        "among the enumerated set\n",
                        value, ns->prefix, elem->name);
      } else {
        xmlErrValidNode(ctxt, elem, XML_DTD_ATTRIBUTE_VALUE,
                        "Value \"%s\" for attribute xmlns of %s is not among "
                        "the enumerated set\n",
                        value, elem->name, NULL);
      }
      ret = 0;
    }
  }

  /* Fixed Attribute Default */
  if ((attrDecl->def == XML_ATTRIBUTE_FIXED) &&
      (!xmlStrEqual(attrDecl->defaultValue, value))) {
    if (ns->prefix != NULL) {
      xmlErrValidNode(ctxt, elem, XML_DTD_ELEM_NAMESPACE,
                      "Value for attribute xmlns:%s of %s must be \"%s\"\n",
                      ns->prefix, elem->name, attrDecl->defaultValue);
    } else {
      xmlErrValidNode(ctxt, elem, XML_DTD_ELEM_NAMESPACE,
                      "Value for attribute xmlns of %s must be \"%s\"\n",
                      elem->name, attrDecl->defaultValue, NULL);
    }
    ret = 0;
  }

  /* Extra check for the attribute value */
  if (ns->prefix != NULL) {
    ret &= xmlValidateAttributeValue2(ctxt, doc, ns->prefix, attrDecl->atype,
                                      value);
  } else {
    ret &= xmlValidateAttributeValue2(ctxt, doc, BAD_CAST "xmlns",
                                      attrDecl->atype, value);
  }

  return (ret);
}

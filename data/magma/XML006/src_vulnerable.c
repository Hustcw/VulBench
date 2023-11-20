void xmlSnprintfElementContent(char *buf, int size,
                               xmlElementContentPtr content, int englob) {
  int len;

  if (content == NULL)
    return;
  len = strlen(buf);
  if (size - len < 50) {
    if ((size - len > 4) && (buf[len - 1] != '.'))
      strcat(buf, " ...");
    return;
  }
  if (englob)
    strcat(buf, "(");
  switch (content->type) {
  case XML_ELEMENT_CONTENT_PCDATA:
    strcat(buf, "#PCDATA");
    break;
  case XML_ELEMENT_CONTENT_ELEMENT: {
    int qnameLen = xmlStrlen(content->name);

    if (content->prefix != NULL)
      qnameLen += xmlStrlen(content->prefix) + 1;
    if (size - len < qnameLen + 10) {
      strcat(buf, " ...");
      return;
    }
    if (content->prefix != NULL) {
      strcat(buf, (char *)content->prefix);
      strcat(buf, ":");
    }
    if (content->name != NULL)
      strcat(buf, (char *)content->name);
    break;
  }
  case XML_ELEMENT_CONTENT_SEQ:
    if ((content->c1->type == XML_ELEMENT_CONTENT_OR) ||
        (content->c1->type == XML_ELEMENT_CONTENT_SEQ))
      xmlSnprintfElementContent(buf, size, content->c1, 1);
    else
      xmlSnprintfElementContent(buf, size, content->c1, 0);
    len = strlen(buf);
    if (size - len < 50) {
      if ((size - len > 4) && (buf[len - 1] != '.'))
        strcat(buf, " ...");
      return;
    }
    strcat(buf, " , ");
    if (((content->c2->type == XML_ELEMENT_CONTENT_OR) ||
         (content->c2->ocur != XML_ELEMENT_CONTENT_ONCE)) &&
        (content->c2->type != XML_ELEMENT_CONTENT_ELEMENT))
      xmlSnprintfElementContent(buf, size, content->c2, 1);
    else
      xmlSnprintfElementContent(buf, size, content->c2, 0);
    break;
  case XML_ELEMENT_CONTENT_OR:
    if ((content->c1->type == XML_ELEMENT_CONTENT_OR) ||
        (content->c1->type == XML_ELEMENT_CONTENT_SEQ))
      xmlSnprintfElementContent(buf, size, content->c1, 1);
    else
      xmlSnprintfElementContent(buf, size, content->c1, 0);
    len = strlen(buf);
    if (size - len < 50) {
      if ((size - len > 4) && (buf[len - 1] != '.'))
        strcat(buf, " ...");
      return;
    }
    strcat(buf, " | ");
    if (((content->c2->type == XML_ELEMENT_CONTENT_SEQ) ||
         (content->c2->ocur != XML_ELEMENT_CONTENT_ONCE)) &&
        (content->c2->type != XML_ELEMENT_CONTENT_ELEMENT))
      xmlSnprintfElementContent(buf, size, content->c2, 1);
    else
      xmlSnprintfElementContent(buf, size, content->c2, 0);
    break;
  }
  if (englob)
    strcat(buf, ")");
  switch (content->ocur) {
  case XML_ELEMENT_CONTENT_ONCE:
    break;
  case XML_ELEMENT_CONTENT_OPT:
    strcat(buf, "?");
    break;
  case XML_ELEMENT_CONTENT_MULT:
    strcat(buf, "*");
    break;
  case XML_ELEMENT_CONTENT_PLUS:
    strcat(buf, "+");
    break;
  }
}


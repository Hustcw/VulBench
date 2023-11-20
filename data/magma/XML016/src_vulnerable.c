static void xmlFAParseCharRange(xmlRegParserCtxtPtr ctxt) {
  int cur, len;
  int start = -1;
  int end = -1;

  if (CUR == '\0') {
    ERROR("Expecting ']'");
    return;
  }

  cur = CUR;
  if (cur == '\\') {
    NEXT;
    cur = CUR;
    switch (cur) {
    case 'n':
      start = 0xA;
      break;
    case 'r':
      start = 0xD;
      break;
    case 't':
      start = 0x9;
      break;
    case '\\':
    case '|':
    case '.':
    case '-':
    case '^':
    case '?':
    case '*':
    case '+':
    case '{':
    case '}':
    case '(':
    case ')':
    case '[':
    case ']':
      start = cur;
      break;
    default:
      ERROR("Invalid escape value");
      return;
    }
    end = start;
    len = 1;
  } else if ((cur != 0x5B) && (cur != 0x5D)) {
    end = start = CUR_SCHAR(ctxt->cur, len);
  } else {
    ERROR("Expecting a char range");
    return;
  }
  /*
   * Since we are "inside" a range, we can assume ctxt->cur is past
   * the start of ctxt->string, and PREV should be safe
   */
  if ((start == '-') && (NXT(1) != ']') && (PREV != '[') && (PREV != '^')) {
    NEXTL(len);
    return;
  }
  NEXTL(len);
  cur = CUR;
  if ((cur != '-') || (NXT(1) == ']')) {
    xmlRegAtomAddRange(ctxt, ctxt->atom, ctxt->neg, XML_REGEXP_CHARVAL, start,
                       end, NULL);
    return;
  }
  NEXT;
  cur = CUR;
  if (cur == '\\') {
    NEXT;
    cur = CUR;
    switch (cur) {
    case 'n':
      end = 0xA;
      break;
    case 'r':
      end = 0xD;
      break;
    case 't':
      end = 0x9;
      break;
    case '\\':
    case '|':
    case '.':
    case '-':
    case '^':
    case '?':
    case '*':
    case '+':
    case '{':
    case '}':
    case '(':
    case ')':
    case '[':
    case ']':
      end = cur;
      break;
    default:
      ERROR("Invalid escape value");
      return;
    }
    len = 1;
  } else if ((cur != '\0') && (cur != 0x5B) && (cur != 0x5D)) {
    end = CUR_SCHAR(ctxt->cur, len);
  } else {
    ERROR("Expecting the end of a char range");
    return;
  }

  NEXTL(len);
  /* TODO check that the values are acceptable character ranges for XML */
  if (end < start) {
    ERROR("End of range is before start of range");
  } else {
    xmlRegAtomAddRange(ctxt, ctxt->atom, ctxt->neg, XML_REGEXP_CHARVAL, start,
                       end, NULL);
  }
  return;
}


void __fastcall xmlFAParseCharRange(xmlRegParserCtxtPtr ctxt)
{
  xmlChar *cur;
  char v2;
  int v3;
  const char *v4;
  xmlChar *v5;
  char v6;
  xmlChar *v7;
  xmlChar *v8;
  xmlChar v9;
  xmlChar *v10;
  int v11;
  __int64 v12;
  int len[5];

  cur = ctxt->cur;
  v2 = *cur;
  if ( (char)*cur <= 91 )
  {
    if ( !v2 )
    {
      ctxt->error = 1450;
      v4 = "Expecting ']'";
      goto LABEL_36;
    }
    if ( v2 != 91 )
      goto LABEL_4;
    goto LABEL_7;
  }
  if ( v2 != 92 )
  {
    if ( v2 != 93 )
    {
LABEL_4:
      v3 = xmlStringCurrentChar(0LL, cur, len);
      goto LABEL_12;
    }
LABEL_7:
    ctxt->error = 1450;
    v4 = "Expecting a char range";
    goto LABEL_36;
  }
  ctxt->cur = cur + 1;
  v3 = 10;
  switch ( cur[1] )
  {
    case '(':
    case ')':
    case '*':
    case '+':
    case '-':
    case '.':
    case '?':
    case '[':
    case '\\':
    case ']':
    case '^':
    case '{':
    case '|':
    case '}':
      v3 = cur[1];
      break;
    case 'n':
      break;
    case 'r':
      v3 = 13;
      break;
    case 't':
      v3 = 9;
      break;
    default:
LABEL_35:
      ctxt->error = 1450;
      v4 = "Invalid escape value";
      goto LABEL_36;
  }
  len[0] = 1;
LABEL_12:
  v5 = ctxt->cur;
  if ( v3 == 45 && v5[1] != 93 )
  {
    v6 = *(v5 - 1);
    if ( v6 != 91 && v6 != 94 )
    {
      ctxt->cur = &v5[len[0]];
      return;
    }
  }
  v7 = &v5[len[0]];
  ctxt->cur = v7;
  if ( *v7 == 45 && v7[1] != 93 )
  {
    v8 = v7 + 1;
    ctxt->cur = v8;
    v9 = *v8;
    if ( (char)*v8 > 91 )
    {
      if ( v9 != 93 )
      {
        if ( v9 == 92 )
        {
          v10 = v8 + 1;
          ctxt->cur = v8 + 1;
          v11 = 10;
          switch ( v8[1] )
          {
            case '(':
            case ')':
            case '*':
            case '+':
            case '-':
            case '.':
            case '?':
            case '[':
            case '\\':
            case ']':
            case '^':
            case '{':
            case '|':
            case '}':
              v11 = v8[1];
              break;
            case 'n':
              break;
            case 'r':
              v11 = 13;
              break;
            case 't':
              v11 = 9;
              break;
            default:
              goto LABEL_35;
          }
          len[0] = 1;
          v12 = 1LL;
          goto LABEL_32;
        }
LABEL_31:
        v11 = xmlStringCurrentChar(0LL, v8, len);
        v12 = len[0];
        v10 = ctxt->cur;
LABEL_32:
        ctxt->cur = &v10[v12];
        if ( v11 >= v3 )
        {
          xmlRegAtomAddRange(ctxt, ctxt->atom, ctxt->neg, XML_REGEXP_CHARVAL, v3, v11, 0LL);
          return;
        }
        ctxt->error = 1450;
        v4 = (const char *)&unk_4DF10D;
        goto LABEL_36;
      }
    }
    else if ( v9 && v9 != 91 )
    {
      goto LABEL_31;
    }
    ctxt->error = 1450;
    v4 = "Expecting the end of a char range";
LABEL_36:
    xmlRegexpErrCompile(ctxt, v4);
    return;
  }
  xmlRegAtomAddRange(ctxt, ctxt->atom, ctxt->neg, XML_REGEXP_CHARVAL, v3, v3, 0LL);
}

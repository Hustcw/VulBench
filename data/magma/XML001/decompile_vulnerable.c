void __fastcall xmlSnprintfElementContent(char *buf, int size, xmlElementContentPtr content, int englob)
{
  size_t v7;
  int v8;
  const xmlChar *prefix;
  const char *name;
  int v11;
  _xmlElementContent *c2;
  xmlElementContentType type;
  int v14;
  xmlElementContentOccur ocur;

  if ( !content )
    return;
  v7 = strlen(buf);
  v8 = size - v7;
  if ( size - (int)v7 > 49 )
  {
    if ( englob )
      *(_WORD *)&buf[strlen(buf)] = 40;
    switch ( content->type )
    {
      case XML_ELEMENT_CONTENT_PCDATA:
        *(_QWORD *)&buf[strlen(buf)] = 0x41544144435023LL;
        if ( englob )
          goto LABEL_31;
        goto LABEL_32;
      case XML_ELEMENT_CONTENT_ELEMENT:
        prefix = content->prefix;
        if ( !prefix )
          goto LABEL_14;
        if ( v8 < xmlStrlen(prefix) + 10 )
          goto LABEL_5;
        strcat(buf, (const char *)content->prefix);
        *(_WORD *)&buf[strlen(buf)] = 58;
LABEL_14:
        if ( v8 < xmlStrlen(content->name) + 10 )
          goto LABEL_5;
        name = (const char *)content->name;
        if ( !name )
          goto LABEL_30;
        strcat(buf, name);
        if ( !englob )
          goto LABEL_32;
        goto LABEL_31;
      case XML_ELEMENT_CONTENT_SEQ:
        xmlSnprintfElementContent(buf, size, content->c1, (unsigned int)(content->c1->type - 3) < 2);
        v7 = strlen(buf);
        v11 = size - v7;
        if ( size - (int)v7 <= 49 )
          goto LABEL_22;
        *(_DWORD *)&buf[strlen(buf)] = 2108448;
        c2 = content->c2;
        type = c2->type;
        if ( c2->type == XML_ELEMENT_CONTENT_OR )
          goto LABEL_27;
        goto LABEL_25;
      case XML_ELEMENT_CONTENT_OR:
        xmlSnprintfElementContent(buf, size, content->c1, (unsigned int)(content->c1->type - 3) < 2);
        v7 = strlen(buf);
        v11 = size - v7;
        if ( size - (int)v7 <= 49 )
        {
LABEL_22:
          if ( v11 >= 5 )
            goto LABEL_4;
          return;
        }
        *(_DWORD *)&buf[strlen(buf)] = 2128928;
        c2 = content->c2;
        type = c2->type;
        if ( c2->type == XML_ELEMENT_CONTENT_SEQ )
          goto LABEL_27;
LABEL_25:
        if ( type == XML_ELEMENT_CONTENT_ELEMENT || c2->ocur == XML_ELEMENT_CONTENT_ONCE )
          v14 = 0;
        else
LABEL_27:
          v14 = 1;
        xmlSnprintfElementContent(buf, size, c2, v14);
LABEL_30:
        if ( englob )
LABEL_31:
          *(_WORD *)&buf[strlen(buf)] = 41;
LABEL_32:
        ocur = content->ocur;
        switch ( ocur )
        {
          case XML_ELEMENT_CONTENT_PLUS:
            *(_WORD *)&buf[strlen(buf)] = 43;
            break;
          case XML_ELEMENT_CONTENT_MULT:
            *(_WORD *)&buf[strlen(buf)] = 42;
            break;
          case XML_ELEMENT_CONTENT_OPT:
            *(_WORD *)&buf[strlen(buf)] = 63;
            break;
        }
        return;
      default:
        goto LABEL_30;
    }
  }
  if ( v8 >= 5 )
  {
LABEL_4:
    if ( buf[(__int64)((v7 << 32) - 0x100000000LL) >> 32] != 46 )
LABEL_5:
      strcpy(&buf[strlen(buf)], " ...");
  }
}

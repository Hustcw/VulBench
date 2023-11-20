void __fastcall xmlSnprintfElementContent(char *buf, int size, xmlElementContentPtr content, int englob)
{
  size_t v8;
  int v9;
  int v10;
  const xmlChar *prefix;
  int v12;
  _xmlElementContent *c2;
  xmlElementContentType type;
  const char *v15;
  const char *name;
  int v17;
  xmlElementContentOccur ocur;

  if ( !content )
    return;
  v8 = strlen(buf);
  v9 = size - v8;
  if ( size - (int)v8 > 49 )
  {
    if ( englob )
      *(_WORD *)&buf[strlen(buf)] = 40;
    switch ( content->type )
    {
      case XML_ELEMENT_CONTENT_PCDATA:
        *(_QWORD *)&buf[strlen(buf)] = 0x41544144435023LL;
        goto LABEL_30;
      case XML_ELEMENT_CONTENT_ELEMENT:
        v10 = xmlStrlen(content->name);
        prefix = content->prefix;
        if ( prefix )
          v10 += xmlStrlen(prefix) + 1;
        if ( v9 < v10 + 10 )
          goto LABEL_13;
        v15 = (const char *)content->prefix;
        if ( v15 )
        {
          strcat(buf, v15);
          *(_WORD *)&buf[strlen(buf)] = 58;
        }
        name = (const char *)content->name;
        if ( name )
          strcat(buf, name);
        goto LABEL_30;
      case XML_ELEMENT_CONTENT_SEQ:
        xmlSnprintfElementContent(buf, size, content->c1, (unsigned int)(content->c1->type - 3) < 2);
        v8 = strlen(buf);
        v12 = size - v8;
        if ( size - (int)v8 <= 49 )
          goto LABEL_18;
        *(_DWORD *)&buf[strlen(buf)] = 2108448;
        c2 = content->c2;
        type = c2->type;
        if ( c2->type == XML_ELEMENT_CONTENT_OR )
          goto LABEL_27;
        goto LABEL_25;
      case XML_ELEMENT_CONTENT_OR:
        xmlSnprintfElementContent(buf, size, content->c1, (unsigned int)(content->c1->type - 3) < 2);
        v8 = strlen(buf);
        v12 = size - v8;
        if ( size - (int)v8 <= 49 )
        {
LABEL_18:
          if ( v12 >= 5 )
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
          v17 = 0;
        else
LABEL_27:
          v17 = 1;
        xmlSnprintfElementContent(buf, size, c2, v17);
LABEL_30:
        if ( size - strlen(buf) >= 3 )
        {
          if ( englob )
            *(_WORD *)&buf[strlen(buf)] = 41;
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
        }
        return;
      default:
        goto LABEL_30;
    }
  }
  if ( v9 >= 5 )
  {
LABEL_4:
    if ( buf[(__int64)((v8 << 32) - 0x100000000LL) >> 32] != 46 )
LABEL_13:
      strcpy(&buf[strlen(buf)], " ...");
  }
}

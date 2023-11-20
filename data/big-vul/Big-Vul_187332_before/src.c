xsltAddTemplate(xsltStylesheetPtr style, xsltTemplatePtr cur,
	        const xmlChar *mode, const xmlChar *modeURI) {
    xsltCompMatchPtr pat, list, next;
    /*
     * 'top' will point to style->xxxMatch ptr - declaring as 'void'
     *  avoids gcc 'type-punned pointer' warning.
     */
    void **top = NULL;
     const xmlChar *name = NULL;
     float priority;              /* the priority */
 
    if ((style == NULL) || (cur == NULL) || (cur->match == NULL))
 	return(-1);
 
     priority = cur->priority;
     pat = xsltCompilePatternInternal(cur->match, style->doc, cur->elem,
 		    style, NULL, 1);
    if (pat == NULL)
	return(-1);
    while (pat) {
	next = pat->next;
	pat->next = NULL;
	name = NULL;

	pat->template = cur;
	if (mode != NULL)
	    pat->mode = xmlDictLookup(style->dict, mode, -1);
	if (modeURI != NULL)
	    pat->modeURI = xmlDictLookup(style->dict, modeURI, -1);
	if (priority != XSLT_PAT_NO_PRIORITY)
	    pat->priority = priority;

	/*
	 * insert it in the hash table list corresponding to its lookup name
	 */
	switch (pat->steps[0].op) {
        case XSLT_OP_ATTR:
	    if (pat->steps[0].value != NULL)
		name = pat->steps[0].value;
	    else
		top = &(style->attrMatch);
	    break;
        case XSLT_OP_PARENT:
        case XSLT_OP_ANCESTOR:
	    top = &(style->elemMatch);
	    break;
        case XSLT_OP_ROOT:
	    top = &(style->rootMatch);
	    break;
        case XSLT_OP_KEY:
	    top = &(style->keyMatch);
	    break;
        case XSLT_OP_ID:
	    /* TODO optimize ID !!! */
        case XSLT_OP_NS:
        case XSLT_OP_ALL:
	    top = &(style->elemMatch);
	    break;
        case XSLT_OP_END:
	case XSLT_OP_PREDICATE:
	    xsltTransformError(NULL, style, NULL,
			     "xsltAddTemplate: invalid compiled pattern\n");
	    xsltFreeCompMatch(pat);
	    return(-1);
	    /*
	     * TODO: some flags at the top level about type based patterns
	     *       would be faster than inclusion in the hash table.
	     */
	case XSLT_OP_PI:
	    if (pat->steps[0].value != NULL)
		name = pat->steps[0].value;
	    else
		top = &(style->piMatch);
	    break;
	case XSLT_OP_COMMENT:
	    top = &(style->commentMatch);
	    break;
	case XSLT_OP_TEXT:
	    top = &(style->textMatch);
	    break;
        case XSLT_OP_ELEM:
	case XSLT_OP_NODE:
	    if (pat->steps[0].value != NULL)
		name = pat->steps[0].value;
	    else
		top = &(style->elemMatch);
	    break;
	}
	if (name != NULL) {
	    if (style->templatesHash == NULL) {
		style->templatesHash = xmlHashCreate(1024);
		if (style->templatesHash == NULL) {
		    xsltFreeCompMatch(pat);
		    return(-1);
		}
		xmlHashAddEntry3(style->templatesHash, name, mode, modeURI, pat);
	    } else {
		list = (xsltCompMatchPtr) xmlHashLookup3(style->templatesHash,
							 name, mode, modeURI);
		if (list == NULL) {
		    xmlHashAddEntry3(style->templatesHash, name,
				     mode, modeURI, pat);
		} else {
		    /*
		     * Note '<=' since one must choose among the matching
		     * template rules that are left, the one that occurs
		     * last in the stylesheet
		     */
		    if (list->priority <= pat->priority) {
			pat->next = list;
			xmlHashUpdateEntry3(style->templatesHash, name,
					    mode, modeURI, pat, NULL);
		    } else {
			while (list->next != NULL) {
			    if (list->next->priority <= pat->priority)
				break;
			    list = list->next;
			}
			pat->next = list->next;
			list->next = pat;
		    }
		}
	    }
	} else if (top != NULL) {
	    list = *top;
	    if (list == NULL) {
		*top = pat;
		pat->next = NULL;
	    } else if (list->priority <= pat->priority) {
		pat->next = list;
		*top = pat;
	    } else {
		while (list->next != NULL) {
		    if (list->next->priority <= pat->priority)
			break;
		    list = list->next;
		}
		pat->next = list->next;
		list->next = pat;
	    }
	} else {
	    xsltTransformError(NULL, style, NULL,
			     "xsltAddTemplate: invalid compiled pattern\n");
	    xsltFreeCompMatch(pat);
	    return(-1);
	}
#ifdef WITH_XSLT_DEBUG_PATTERN
	if (mode)
	    xsltGenericDebug(xsltGenericDebugContext,
			 "added pattern : '%s' mode '%s' priority %f\n",
			     pat->pattern, pat->mode, pat->priority);
	else
	    xsltGenericDebug(xsltGenericDebugContext,
			 "added pattern : '%s' priority %f\n",
			     pat->pattern, pat->priority);
#endif

	pat = next;
    }
    return(0);
}

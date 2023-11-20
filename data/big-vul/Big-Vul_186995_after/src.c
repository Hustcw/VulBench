htmlCheckEncodingDirect(htmlParserCtxtPtr ctxt, const xmlChar *encoding) {

    if ((ctxt == NULL) || (encoding == NULL) ||
        (ctxt->options & HTML_PARSE_IGNORE_ENC))
	return;

    /* do not change encoding */
    if (ctxt->input->encoding != NULL)
        return;

    if (encoding != NULL) {
	xmlCharEncoding enc;
	xmlCharEncodingHandlerPtr handler;

	while ((*encoding == ' ') || (*encoding == '\t')) encoding++;

	if (ctxt->input->encoding != NULL)
	    xmlFree((xmlChar *) ctxt->input->encoding);
	ctxt->input->encoding = xmlStrdup(encoding);

	enc = xmlParseCharEncoding((const char *) encoding);
	/*
	 * registered set of known encodings
	 */
	if (enc != XML_CHAR_ENCODING_ERROR) {
	    if (((enc == XML_CHAR_ENCODING_UTF16LE) ||
	         (enc == XML_CHAR_ENCODING_UTF16BE) ||
		 (enc == XML_CHAR_ENCODING_UCS4LE) ||
		 (enc == XML_CHAR_ENCODING_UCS4BE)) &&
		(ctxt->input->buf != NULL) &&
		(ctxt->input->buf->encoder == NULL)) {
		htmlParseErr(ctxt, XML_ERR_INVALID_ENCODING,
		             "htmlCheckEncoding: wrong encoding meta\n",
			     NULL, NULL);
	    } else {
		xmlSwitchEncoding(ctxt, enc);
	    }
	    ctxt->charset = XML_CHAR_ENCODING_UTF8;
	} else {
	    /*
	     * fallback for unknown encodings
	     */
	    handler = xmlFindCharEncodingHandler((const char *) encoding);
	    if (handler != NULL) {
		xmlSwitchToEncoding(ctxt, handler);
		ctxt->charset = XML_CHAR_ENCODING_UTF8;
	    } else {
		htmlParseErr(ctxt, XML_ERR_UNSUPPORTED_ENCODING,
		             "htmlCheckEncoding: unknown encoding %s\n",
			     encoding, NULL);
	    }
	}

	if ((ctxt->input->buf != NULL) &&
	    (ctxt->input->buf->encoder != NULL) &&
	    (ctxt->input->buf->raw != NULL) &&
	    (ctxt->input->buf->buffer != NULL)) {
	    int nbchars;
	    int processed;

	    /*
	     * convert as much as possible to the parser reading buffer.
	     */
 	    processed = ctxt->input->cur - ctxt->input->base;
 	    xmlBufShrink(ctxt->input->buf->buffer, processed);
 	    nbchars = xmlCharEncInput(ctxt->input->buf, 1);
            xmlBufResetInput(ctxt->input->buf->buffer, ctxt->input);
 	    if (nbchars < 0) {
 		htmlParseErr(ctxt, XML_ERR_INVALID_ENCODING,
 		             "htmlCheckEncoding: encoder error\n",
 			     NULL, NULL);
 	    }
 	}
     }
 }

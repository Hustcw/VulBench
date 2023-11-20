 static void xml_parser_dtor(zend_rsrc_list_entry *rsrc TSRMLS_DC)
 {
        xml_parser *parser = (xml_parser *)rsrc->ptr;
        if (parser->parser) {
                XML_ParserFree(parser->parser);
        }
	if (parser->ltags) {
		int inx;
		for (inx = 0; ((inx < parser->level) && (inx < XML_MAXLEVEL)); inx++)
			efree(parser->ltags[ inx ]);
		efree(parser->ltags);
	}
	if (parser->startElementHandler) {
		zval_ptr_dtor(&parser->startElementHandler);
	}
	if (parser->endElementHandler) {
		zval_ptr_dtor(&parser->endElementHandler);
	}
	if (parser->characterDataHandler) {
		zval_ptr_dtor(&parser->characterDataHandler);
	}
	if (parser->processingInstructionHandler) {
		zval_ptr_dtor(&parser->processingInstructionHandler);
	}
	if (parser->defaultHandler) {
		zval_ptr_dtor(&parser->defaultHandler);
	}
	if (parser->unparsedEntityDeclHandler) {
		zval_ptr_dtor(&parser->unparsedEntityDeclHandler);
	}
	if (parser->notationDeclHandler) {
		zval_ptr_dtor(&parser->notationDeclHandler);
	}
	if (parser->externalEntityRefHandler) {
		zval_ptr_dtor(&parser->externalEntityRefHandler);
	}
	if (parser->unknownEncodingHandler) {
		zval_ptr_dtor(&parser->unknownEncodingHandler);
	}
	if (parser->startNamespaceDeclHandler) {
		zval_ptr_dtor(&parser->startNamespaceDeclHandler);
	}
	if (parser->endNamespaceDeclHandler) {
		zval_ptr_dtor(&parser->endNamespaceDeclHandler);
	}
	if (parser->baseURI) {
		efree(parser->baseURI);
	}
	if (parser->object) {
		zval_ptr_dtor(&parser->object);
	}

	efree(parser);
}

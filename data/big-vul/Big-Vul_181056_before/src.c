 beep_print(netdissect_options *ndo, const u_char *bp, u_int length)
 {
 
	if (l_strnstart("MSG", 4, (const char *)bp, length)) /* A REQuest */
 		ND_PRINT((ndo, " BEEP MSG"));
	else if (l_strnstart("RPY ", 4, (const char *)bp, length))
 		ND_PRINT((ndo, " BEEP RPY"));
	else if (l_strnstart("ERR ", 4, (const char *)bp, length))
 		ND_PRINT((ndo, " BEEP ERR"));
	else if (l_strnstart("ANS ", 4, (const char *)bp, length))
 		ND_PRINT((ndo, " BEEP ANS"));
	else if (l_strnstart("NUL ", 4, (const char *)bp, length))
 		ND_PRINT((ndo, " BEEP NUL"));
	else if (l_strnstart("SEQ ", 4, (const char *)bp, length))
 		ND_PRINT((ndo, " BEEP SEQ"));
	else if (l_strnstart("END", 4, (const char *)bp, length))
 		ND_PRINT((ndo, " BEEP END"));
 	else
 		ND_PRINT((ndo, " BEEP (payload or undecoded)"));
}

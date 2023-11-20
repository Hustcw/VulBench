 pim_print(netdissect_options *ndo,
           register const u_char *bp, register u_int len, const u_char *bp2)
 {
	register const u_char *ep;
 	register const struct pim *pim = (const struct pim *)bp;
 
	ep = (const u_char *)ndo->ndo_snapend;
	if (bp >= ep)
		return;
 #ifdef notyet			/* currently we see only version and type */
 	ND_TCHECK(pim->pim_rsv);
 #endif
 
 	switch (PIM_VER(pim->pim_typever)) {
 	case 2:
 		if (!ndo->ndo_vflag) {
			ND_PRINT((ndo, "PIMv%u, %s, length %u",
			          PIM_VER(pim->pim_typever),
			          tok2str(pimv2_type_values,"Unknown Type",PIM_TYPE(pim->pim_typever)),
			          len));
			return;
		} else {
			ND_PRINT((ndo, "PIMv%u, length %u\n\t%s",
			          PIM_VER(pim->pim_typever),
			          len,
			          tok2str(pimv2_type_values,"Unknown Type",PIM_TYPE(pim->pim_typever))));
			pimv2_print(ndo, bp, len, bp2);
		}
		break;
	default:
		ND_PRINT((ndo, "PIMv%u, length %u",
		          PIM_VER(pim->pim_typever),
		          len));
 		break;
 	}
 	return;
 }

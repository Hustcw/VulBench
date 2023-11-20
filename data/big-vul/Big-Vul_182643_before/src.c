static void utee_param_to_param(struct tee_ta_param *p, struct utee_params *up)
 {
 	size_t n;
 	uint32_t types = up->types;

	p->types = types;
 	for (n = 0; n < TEE_NUM_PARAMS; n++) {
 		uintptr_t a = up->vals[n * 2];
 		size_t b = up->vals[n * 2 + 1];
 
 		switch (TEE_PARAM_TYPE_GET(types, n)) {
		case TEE_PARAM_TYPE_MEMREF_INPUT:
 		case TEE_PARAM_TYPE_MEMREF_OUTPUT:
 		case TEE_PARAM_TYPE_MEMREF_INOUT:
 			p->u[n].mem.mobj = &mobj_virt;
 			p->u[n].mem.offs = a;
 			p->u[n].mem.size = b;
 			break;
 		case TEE_PARAM_TYPE_VALUE_INPUT:
 		case TEE_PARAM_TYPE_VALUE_INOUT:
			p->u[n].val.a = a;
			p->u[n].val.b = b;
			break;
		default:
			memset(&p->u[n], 0, sizeof(p->u[n]));
 			break;
 		}
 	}
 }

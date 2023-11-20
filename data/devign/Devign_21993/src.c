static int decode_extended_mips16_opc (CPUMIPSState *env, DisasContext *ctx,

                                       int *is_branch)

{

    int extend = cpu_lduw_code(env, ctx->pc + 2);

    int op, rx, ry, funct, sa;

    int16_t imm, offset;



    ctx->opcode = (ctx->opcode << 16) | extend;

    op = (ctx->opcode >> 11) & 0x1f;

    sa = (ctx->opcode >> 22) & 0x1f;

    funct = (ctx->opcode >> 8) & 0x7;

    rx = xlat((ctx->opcode >> 8) & 0x7);

    ry = xlat((ctx->opcode >> 5) & 0x7);

    offset = imm = (int16_t) (((ctx->opcode >> 16) & 0x1f) << 11

                              | ((ctx->opcode >> 21) & 0x3f) << 5

                              | (ctx->opcode & 0x1f));



    /* The extended opcodes cleverly reuse the opcodes from their 16-bit

       counterparts.  */

    switch (op) {

    case M16_OPC_ADDIUSP:

        gen_arith_imm(ctx, OPC_ADDIU, rx, 29, imm);

        break;

    case M16_OPC_ADDIUPC:

        gen_addiupc(ctx, rx, imm, 0, 1);

        break;

    case M16_OPC_B:

        gen_compute_branch(ctx, OPC_BEQ, 4, 0, 0, offset << 1);

        /* No delay slot, so just process as a normal instruction */

        break;

    case M16_OPC_BEQZ:

        gen_compute_branch(ctx, OPC_BEQ, 4, rx, 0, offset << 1);

        /* No delay slot, so just process as a normal instruction */

        break;

    case M16_OPC_BNEQZ:

        gen_compute_branch(ctx, OPC_BNE, 4, rx, 0, offset << 1);

        /* No delay slot, so just process as a normal instruction */

        break;

    case M16_OPC_SHIFT:

        switch (ctx->opcode & 0x3) {

        case 0x0:

            gen_shift_imm(ctx, OPC_SLL, rx, ry, sa);

            break;

        case 0x1:

#if defined(TARGET_MIPS64)

            check_mips_64(ctx);

            gen_shift_imm(ctx, OPC_DSLL, rx, ry, sa);

#else

            generate_exception(ctx, EXCP_RI);

#endif

            break;

        case 0x2:

            gen_shift_imm(ctx, OPC_SRL, rx, ry, sa);

            break;

        case 0x3:

            gen_shift_imm(ctx, OPC_SRA, rx, ry, sa);

            break;

        }

        break;

#if defined(TARGET_MIPS64)

    case M16_OPC_LD:

            check_mips_64(ctx);

        gen_ld(ctx, OPC_LD, ry, rx, offset);

        break;

#endif

    case M16_OPC_RRIA:

        imm = ctx->opcode & 0xf;

        imm = imm | ((ctx->opcode >> 20) & 0x7f) << 4;

        imm = imm | ((ctx->opcode >> 16) & 0xf) << 11;

        imm = (int16_t) (imm << 1) >> 1;

        if ((ctx->opcode >> 4) & 0x1) {

#if defined(TARGET_MIPS64)

            check_mips_64(ctx);

            gen_arith_imm(ctx, OPC_DADDIU, ry, rx, imm);

#else

            generate_exception(ctx, EXCP_RI);

#endif

        } else {

            gen_arith_imm(ctx, OPC_ADDIU, ry, rx, imm);

        }

        break;

    case M16_OPC_ADDIU8:

        gen_arith_imm(ctx, OPC_ADDIU, rx, rx, imm);

        break;

    case M16_OPC_SLTI:

        gen_slt_imm(ctx, OPC_SLTI, 24, rx, imm);

        break;

    case M16_OPC_SLTIU:

        gen_slt_imm(ctx, OPC_SLTIU, 24, rx, imm);

        break;

    case M16_OPC_I8:

        switch (funct) {

        case I8_BTEQZ:

            gen_compute_branch(ctx, OPC_BEQ, 4, 24, 0, offset << 1);

            break;

        case I8_BTNEZ:

            gen_compute_branch(ctx, OPC_BNE, 4, 24, 0, offset << 1);

            break;

        case I8_SWRASP:

            gen_st(ctx, OPC_SW, 31, 29, imm);

            break;

        case I8_ADJSP:

            gen_arith_imm(ctx, OPC_ADDIU, 29, 29, imm);

            break;

        case I8_SVRS:

            {

                int xsregs = (ctx->opcode >> 24) & 0x7;

                int aregs = (ctx->opcode >> 16) & 0xf;

                int do_ra = (ctx->opcode >> 6) & 0x1;

                int do_s0 = (ctx->opcode >> 5) & 0x1;

                int do_s1 = (ctx->opcode >> 4) & 0x1;

                int framesize = (((ctx->opcode >> 20) & 0xf) << 4

                                 | (ctx->opcode & 0xf)) << 3;



                if (ctx->opcode & (1 << 7)) {

                    gen_mips16_save(ctx, xsregs, aregs,

                                    do_ra, do_s0, do_s1,

                                    framesize);

                } else {

                    gen_mips16_restore(ctx, xsregs, aregs,

                                       do_ra, do_s0, do_s1,

                                       framesize);

                }

            }

            break;

        default:

            generate_exception(ctx, EXCP_RI);

            break;

        }

        break;

    case M16_OPC_LI:

        tcg_gen_movi_tl(cpu_gpr[rx], (uint16_t) imm);

        break;

    case M16_OPC_CMPI:

        tcg_gen_xori_tl(cpu_gpr[24], cpu_gpr[rx], (uint16_t) imm);

        break;

#if defined(TARGET_MIPS64)

    case M16_OPC_SD:

        gen_st(ctx, OPC_SD, ry, rx, offset);

        break;

#endif

    case M16_OPC_LB:

        gen_ld(ctx, OPC_LB, ry, rx, offset);

        break;

    case M16_OPC_LH:

        gen_ld(ctx, OPC_LH, ry, rx, offset);

        break;

    case M16_OPC_LWSP:

        gen_ld(ctx, OPC_LW, rx, 29, offset);

        break;

    case M16_OPC_LW:

        gen_ld(ctx, OPC_LW, ry, rx, offset);

        break;

    case M16_OPC_LBU:

        gen_ld(ctx, OPC_LBU, ry, rx, offset);

        break;

    case M16_OPC_LHU:

        gen_ld(ctx, OPC_LHU, ry, rx, offset);

        break;

    case M16_OPC_LWPC:

        gen_ld(ctx, OPC_LWPC, rx, 0, offset);

        break;

#if defined(TARGET_MIPS64)

    case M16_OPC_LWU:

        gen_ld(ctx, OPC_LWU, ry, rx, offset);

        break;

#endif

    case M16_OPC_SB:

        gen_st(ctx, OPC_SB, ry, rx, offset);

        break;

    case M16_OPC_SH:

        gen_st(ctx, OPC_SH, ry, rx, offset);

        break;

    case M16_OPC_SWSP:

        gen_st(ctx, OPC_SW, rx, 29, offset);

        break;

    case M16_OPC_SW:

        gen_st(ctx, OPC_SW, ry, rx, offset);

        break;

#if defined(TARGET_MIPS64)

    case M16_OPC_I64:

        decode_i64_mips16(ctx, ry, funct, offset, 1);

        break;

#endif

    default:

        generate_exception(ctx, EXCP_RI);

        break;

    }



    return 4;

}

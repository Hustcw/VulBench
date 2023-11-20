void sh4_translate_init(void)

{

    int i;

    static const char * const gregnames[24] = {

        "R0_BANK0", "R1_BANK0", "R2_BANK0", "R3_BANK0",

        "R4_BANK0", "R5_BANK0", "R6_BANK0", "R7_BANK0",

        "R8", "R9", "R10", "R11", "R12", "R13", "R14", "R15",

        "R0_BANK1", "R1_BANK1", "R2_BANK1", "R3_BANK1",

        "R4_BANK1", "R5_BANK1", "R6_BANK1", "R7_BANK1"

    };

    static const char * const fregnames[32] = {

         "FPR0_BANK0",  "FPR1_BANK0",  "FPR2_BANK0",  "FPR3_BANK0",

         "FPR4_BANK0",  "FPR5_BANK0",  "FPR6_BANK0",  "FPR7_BANK0",

         "FPR8_BANK0",  "FPR9_BANK0", "FPR10_BANK0", "FPR11_BANK0",

        "FPR12_BANK0", "FPR13_BANK0", "FPR14_BANK0", "FPR15_BANK0",

         "FPR0_BANK1",  "FPR1_BANK1",  "FPR2_BANK1",  "FPR3_BANK1",

         "FPR4_BANK1",  "FPR5_BANK1",  "FPR6_BANK1",  "FPR7_BANK1",

         "FPR8_BANK1",  "FPR9_BANK1", "FPR10_BANK1", "FPR11_BANK1",

        "FPR12_BANK1", "FPR13_BANK1", "FPR14_BANK1", "FPR15_BANK1",

    };



    for (i = 0; i < 24; i++) {

        cpu_gregs[i] = tcg_global_mem_new_i32(cpu_env,

                                              offsetof(CPUSH4State, gregs[i]),

                                              gregnames[i]);

    }

    memcpy(cpu_gregs + 24, cpu_gregs + 8, 8 * sizeof(TCGv));



    cpu_pc = tcg_global_mem_new_i32(cpu_env,

                                    offsetof(CPUSH4State, pc), "PC");

    cpu_sr = tcg_global_mem_new_i32(cpu_env,

                                    offsetof(CPUSH4State, sr), "SR");

    cpu_sr_m = tcg_global_mem_new_i32(cpu_env,

                                      offsetof(CPUSH4State, sr_m), "SR_M");

    cpu_sr_q = tcg_global_mem_new_i32(cpu_env,

                                      offsetof(CPUSH4State, sr_q), "SR_Q");

    cpu_sr_t = tcg_global_mem_new_i32(cpu_env,

                                      offsetof(CPUSH4State, sr_t), "SR_T");

    cpu_ssr = tcg_global_mem_new_i32(cpu_env,

                                     offsetof(CPUSH4State, ssr), "SSR");

    cpu_spc = tcg_global_mem_new_i32(cpu_env,

                                     offsetof(CPUSH4State, spc), "SPC");

    cpu_gbr = tcg_global_mem_new_i32(cpu_env,

                                     offsetof(CPUSH4State, gbr), "GBR");

    cpu_vbr = tcg_global_mem_new_i32(cpu_env,

                                     offsetof(CPUSH4State, vbr), "VBR");

    cpu_sgr = tcg_global_mem_new_i32(cpu_env,

                                     offsetof(CPUSH4State, sgr), "SGR");

    cpu_dbr = tcg_global_mem_new_i32(cpu_env,

                                     offsetof(CPUSH4State, dbr), "DBR");

    cpu_mach = tcg_global_mem_new_i32(cpu_env,

                                      offsetof(CPUSH4State, mach), "MACH");

    cpu_macl = tcg_global_mem_new_i32(cpu_env,

                                      offsetof(CPUSH4State, macl), "MACL");

    cpu_pr = tcg_global_mem_new_i32(cpu_env,

                                    offsetof(CPUSH4State, pr), "PR");

    cpu_fpscr = tcg_global_mem_new_i32(cpu_env,

                                       offsetof(CPUSH4State, fpscr), "FPSCR");

    cpu_fpul = tcg_global_mem_new_i32(cpu_env,

                                      offsetof(CPUSH4State, fpul), "FPUL");



    cpu_flags = tcg_global_mem_new_i32(cpu_env,

				       offsetof(CPUSH4State, flags), "_flags_");

    cpu_delayed_pc = tcg_global_mem_new_i32(cpu_env,

					    offsetof(CPUSH4State, delayed_pc),

					    "_delayed_pc_");

    cpu_delayed_cond = tcg_global_mem_new_i32(cpu_env,

                                              offsetof(CPUSH4State,

                                                       delayed_cond),

                                              "_delayed_cond_");

    cpu_ldst = tcg_global_mem_new_i32(cpu_env,

				      offsetof(CPUSH4State, ldst), "_ldst_");



    for (i = 0; i < 32; i++)

        cpu_fregs[i] = tcg_global_mem_new_i32(cpu_env,

                                              offsetof(CPUSH4State, fregs[i]),

                                              fregnames[i]);

}

void ppc40x_chip_reset (CPUState *env)

{

    target_ulong dbsr;



    printf("Reset PowerPC chip\n");

    cpu_ppc_reset(env);

    /* XXX: TODO reset all internal peripherals */

    dbsr = env->spr[SPR_40x_DBSR];

    dbsr &= ~0x00000300;

    dbsr |= 0x00000200;

    env->spr[SPR_40x_DBSR] = dbsr;

    cpu_loop_exit();

}
